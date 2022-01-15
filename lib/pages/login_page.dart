import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medhealth/main_page.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/pages/register_page.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:http/http.dart' as http;
import 'package:medhealth/widget/logo_page_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPages extends StatefulWidget {
  @override
  _LoginPagesState createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  submitLogin() async {
    var urlLogin = Uri.parse(BASEURL.apiLogin);
    final response = await http.post(urlLogin, body: {
      "email": emailController.text,
      "password": passwordController.text
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String idUser = data['user_id'];
    String name = data['name'];
    String email = data['email'];
    String phone = data['phone'];
    String address = data['address'];
    String latitude = data['lat'];
    String longitude = data['lng'];
    String createdAt = data['create_at'];
    if (value == 1) {
      savePref(idUser, name, email, phone, address,latitude,longitude, createdAt);
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
                          MaterialPageRoute(builder: (context) => MainPages()),
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
      setState(() {});
    }
  }

  savePref(String idUser, String name, String email, String phone,
      String address,String latitude,String longitude, String createdAt) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString(PrefProfile.idUser, idUser);
      sharedPreferences.setString(PrefProfile.name, name);
      sharedPreferences.setString(PrefProfile.email, email);
      sharedPreferences.setString(PrefProfile.phone, phone);
      sharedPreferences.setString(PrefProfile.address, address);
      sharedPreferences.setString(PrefProfile.latitude,latitude);
      sharedPreferences.setString(PrefProfile.longitude, longitude);
      sharedPreferences.setString(PrefProfile.createdAt, createdAt);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: logo_page_login(),
          ),
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                ),
                Text(
                  "เข้าสู่ระบบ",
                  style: regulerTextStyle.copyWith(fontSize: 25),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "เข้าสู่ระบบด้วยบัญชีของคุณ",
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
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
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
                      hintText: 'Password',
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
                    text: "เข้าสู่ระบบ",
                    ontap: () {
                      if (emailController.text.isEmpty ||
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
                        submitLogin();
                        //registerSubmit();
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
                      "ไม่มีบัญชีผู้ใช้ ? ",
                      style: lightTextStyle.copyWith(
                          color: greyLightColor, fontSize: 15),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPages()),
                            (route) => false);
                      },
                      child: Text(
                        "ลงทะเบียนใหม่",
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
