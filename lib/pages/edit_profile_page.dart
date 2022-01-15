import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medhealth/main_page.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/pages/login_page.dart';
import 'package:medhealth/pages/page_profile.dart';
import 'package:medhealth/pages/profile_page.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:medhealth/widget/my_dialog.dart';
import 'package:medhealth/widget/show_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  double lat, lng;
  String fullName, createdDate, phone, email, address, idUser;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      idUser = sharedPreferences.getString(PrefProfile.idUser);
      fullName = sharedPreferences.getString(PrefProfile.name);
      createdDate = sharedPreferences.getString(PrefProfile.createdAt);
      phone = sharedPreferences.getString(PrefProfile.phone);
      email = sharedPreferences.getString(PrefProfile.email);
      address = sharedPreferences.getString(PrefProfile.address);
    });
    // print(idUser);
  }

  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(PrefProfile.idUser);
    sharedPreferences.remove(PrefProfile.name);
    sharedPreferences.remove(PrefProfile.email);
    sharedPreferences.remove(PrefProfile.phone);
    sharedPreferences.remove(PrefProfile.address);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPages(),
        ),
        (route) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPermission();
    getPref();
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
      lat = position.latitude;
      lng = position.longitude;

      print('lat === $lat , lng === $lng');
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

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  editProfileSubmit() async {
    var editProfileUrl = Uri.parse(
        'http://1448-1-20-149-88.ngrok.io/medhealth_db/editUserWhereId.php?id_user=$idUser&name=${fullNameController.text}&phone=${phoneController.text}&address=${addressController.text}&lat=$lat&lng=$lng');
    final response = await http.post(editProfileUrl);
    final data = jsonDecode(response.body);
    // print(editProfileUrl);
    setState(() {});
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                content: Text(
                  message,
                  style: TextStyle(fontSize: 16),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      signOut();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 100,
                      color: Colors.green,
                      child: Text(
                        "ออกจากระบบ",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ));
      setState(() {});
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  "Notification",
                  style: TextStyle(
                    color: Color(0xfff09FF41),
                  ),
                ),
                content: Text(message),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                  )
                ],
              ));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('เเก้ไขโปรไฟล์'),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
                        keyboardType: TextInputType.name,
                        controller: fullNameController,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Colors.blueAccent,
                          ),
                          hintText: fullName,
                          hintStyle: lightTextStyle.copyWith(
                              fontSize: 15, color: greyLightColor),
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
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.phone_iphone,
                            color: Colors.blueAccent,
                          ),
                          hintText: phone,
                          hintStyle: lightTextStyle.copyWith(
                              fontSize: 15, color: greyLightColor),
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
                        controller: addressController,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.home,
                            color: Colors.blueAccent,
                          ),
                          hintText: address,
                          hintStyle: lightTextStyle.copyWith(
                              fontSize: 15, color: greyLightColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'ตำเเหน่งปัจจุบัน',
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
                            target: LatLng(lat, lng),
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
                  text: 'บันทึก',
                  ontap: () {
                    if (fullNameController.text.isEmpty ||
                        phoneController.text.isEmpty ||
                        addressController.text.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Text(
                                  "กรุณากรอกข้อมูลให้ครบ",
                                  style: TextStyle(color: Colors.red),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 30,
                                          width: 100,
                                          child: Text(
                                            "ตกลง",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ));
                    } else {
                      editProfileSubmit();
                      // print(idUser);
                    }
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
