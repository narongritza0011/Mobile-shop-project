import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/pages/edit_profile_page.dart';
import 'package:medhealth/pages/login_page.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:medhealth/widget/my_dialog.dart';
import 'package:medhealth/widget/show_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileHomePage extends StatefulWidget {
  @override
  _ProfileHomePageState createState() => _ProfileHomePageState();
}

class _ProfileHomePageState extends State<ProfileHomePage> {
  double lat, lng;
  String fullName,
      createdDate,
      phone,
      email,
      address,
      latitude,
      longitude,
      idUser;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      idUser = sharedPreferences.getString(PrefProfile.idUser);
      fullName = sharedPreferences.getString(PrefProfile.name);
      createdDate = sharedPreferences.getString(PrefProfile.createdAt);
      phone = sharedPreferences.getString(PrefProfile.phone);
      email = sharedPreferences.getString(PrefProfile.email);
      address = sharedPreferences.getString(PrefProfile.address);
      latitude = sharedPreferences.getString(PrefProfile.latitude);
      longitude = sharedPreferences.getString(PrefProfile.longitude);
    });
    //  print(latitude + longitude);
  }

  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(PrefProfile.idUser);
    sharedPreferences.remove(PrefProfile.name);
    sharedPreferences.remove(PrefProfile.email);
    sharedPreferences.remove(PrefProfile.phone);
    sharedPreferences.remove(PrefProfile.address);
    sharedPreferences.remove(PrefProfile.latitude);
    sharedPreferences.remove(PrefProfile.longitude);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPages(),
        ),
        (route) => false);
  }

//การใช้ geolocation ฟังชั่น เช็คโลเคชัน เปิด หรือ ปิด
  Future<Null> checkPermission() async {
    bool locationService;
    LocationPermission locationPermission;

    locationService = await Geolocator.isLocationServiceEnabled();
    if (locationService) {
      print('Service Location Open');

      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนุญาติเเชร์ Location', 'โปรดเเชร์ Location');
        } else {
          // Find LatLong
          findLatLng();
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนุญาติเเชร์ Location', 'โปรดเเชร์ Location');
        } else {
          //  Find LatLng
          findLatLng();
        }
      }
    } else {
      print('Service Location Close');
      MyDialog().alertLocationService(
          context, 'Location ของคุณปิดอยู่ ?', 'กรุณาเปิด Location ของคุณ');
    }
  }

  Future<Null> findLatLng() async {
    print('findlatlong==work');
    Position position = await findPosition();
    setState(() {
      lat = double.parse(latitude);
      lng = double.parse(longitude);

      // print('lat === $lat , lng === $lng');
    });
  }

  Future<Position> findPosition() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  Set<Marker> setMarker() => <Marker>[
        Marker(
          markerId: MarkerId('id'),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
              title: 'คุณอยู่ที่นี่', snippet: 'Lat =$lat , lan = $lng'),
        ),
      ].toSet();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPermission();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "บัญชีของฉัน",
                      style: regulerTextStyle.copyWith(fontSize: 25),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            signOut();
                          },
                          child: Row(
                            children: [
                              Text(
                                'ออกจากระบบ ',
                                style: TextStyle(
                                  color: greyBoldColor,
                                ),
                              ),
                              Icon(
                                Icons.exit_to_app,
                                color: greyBoldColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ชื่อ-นามสกุล",
                        style: lightTextStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        obscureText: true,
                        readOnly: true,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Colors.blueAccent,
                          ),
                          hintText: fullName,
                          hintStyle: boldTextStyle.copyWith(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "อีเมล์",
                        style: lightTextStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        obscureText: true,
                        readOnly: true,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Colors.blueAccent,
                          ),
                          hintText: email,
                          hintStyle: boldTextStyle.copyWith(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "เบอร์ติดต่อ",
                        style: lightTextStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.phone_iphone,
                            color: Colors.blueAccent,
                          ),
                          hintText: phone,
                          hintStyle: boldTextStyle.copyWith(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ที่อยู่",
                        style: lightTextStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.home,
                            color: Colors.blueAccent,
                          ),
                          hintText: address,
                          hintStyle: boldTextStyle.copyWith(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'ตำเเหน่งที่อยู่',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  width: double.infinity,
                  height: 300,
                  child: lat == null
                      ? ShowProgress()
                      : GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: _convertLatLng(latitude, longitude),
                            zoom: 16,
                          ),
                          onMapCreated: (controller) {},
                          markers: setMarker(),
                        ),
                ),
                SizedBox(
                  height: 30,
                ),
                ButtonPrimary(
                  text: 'เเก้ไขโปรไฟล์',
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//function เเปลงค่า string เป็น double
LatLng _convertLatLng(String latitude, String longitude) {
  double lat = 0.0;
  double lng = 0.0;
//  print('ดีบัค  $lat  $lng');

  lat = double.parse(latitude);
  lng = double.parse(longitude);
  return LatLng(lat, lng);
}
