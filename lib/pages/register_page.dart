import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/pages/Login_Page.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:medhealth/widget/general_logo_space.dart';
import 'package:medhealth/widget/my_dialog.dart';
import 'package:medhealth/widget/show_progress.dart';
import '../theme.dart';
import 'package:http/http.dart' as http;

class RegisterPages extends StatefulWidget {
  @override
  _RegisterPagesState createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
  double lat, lng;
  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
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

  registerSubmit() async {
    var registerUrl = Uri.parse(BASEURL.apiRegister);
    final response = await http.post(registerUrl, body: {
      "fullname": fullNameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "address": addressController.text,
      "password": passwordController.text,
      "lat": lat.toString(),
      "lng": lng.toString(),
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                content: Text(
                  message,
                  style: TextStyle(color: Colors.green),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPages()),
                          (route) => false);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 100,
                          child: Text(
                            "ตกลง",
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));
      setState(() {});
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                content: Text(
                  message,
                  style: TextStyle(color: Colors.red),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 100,
                          child: Text(
                            "ตกลง",
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));
    }
    setState(() {});
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: GeneralLogoSpace(),
          ),
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "สมัครสมาชิก",
                  style: regulerTextStyle.copyWith(fontSize: 25),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "ลงทะเบียนบัญชีใหม่ของคุณ",
                  style: regulerTextStyle.copyWith(
                      fontSize: 15, color: greyLightColor),
                ),
                SizedBox(
                  height: 8,
                ),
                //Note:: Textfield
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: whiteColor),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'ชื่อ-นามสกุล',
                      hintStyle: lightTextStyle.copyWith(
                          fontSize: 15, color: greyLightColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: whiteColor),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'อีเมล์',
                      hintStyle: lightTextStyle.copyWith(
                          fontSize: 15, color: greyLightColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: whiteColor),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'เบอร์ติดต่อ',
                      hintStyle: lightTextStyle.copyWith(
                          fontSize: 15, color: greyLightColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: whiteColor),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    keyboardType: TextInputType.streetAddress,
                    controller: addressController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'ที่อยู่',
                      hintStyle: lightTextStyle.copyWith(
                          fontSize: 15, color: greyLightColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                // Text('พิกัดเเผนที่ lat $lat  lng $lng'),
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
                            target: LatLng(lat, lng),
                            zoom: 16,
                          ),
                          onMapCreated: (controller) {},
                          markers: setMarker(),
                        ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: whiteColor),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: passwordController,
                    obscureText: _secureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: showHide,
                        icon: _secureText
                            ? Icon(
                                Icons.visibility_off,
                                size: 20,
                              )
                            : Icon(
                                Icons.visibility,
                                size: 20,
                              ),
                      ),
                      border: InputBorder.none,
                      hintText: 'รหัสผ่าน',
                      hintStyle: lightTextStyle.copyWith(
                          fontSize: 15, color: greyLightColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonPrimary(
                    text: "สมัครสมาชิก",
                    ontap: () {
                      if (fullNameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          phoneController.text.isEmpty ||
                          addressController.text.isEmpty ||
                          passwordController.text.isEmpty) {
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
                        registerSubmit();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "มีบัญชีอยู่แล้วหรือ ? ",
                      style: lightTextStyle.copyWith(
                          color: greyLightColor, fontSize: 15),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPages()),
                            (route) => false);
                      },
                      child: Text(
                        "ลงชื่อเข้าใช้",
                        style: boldTextStyle.copyWith(
                            color: greenColor, fontSize: 15),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
