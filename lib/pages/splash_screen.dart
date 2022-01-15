import 'package:flutter/material.dart';
import 'package:medhealth/main_page.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/pages/login_page.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:medhealth/widget/general_logo_space.dart';
import 'package:medhealth/widget/widget_ilustration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser);
      userID == null ? sessionLogout() : sessionLogin();
    });
  }

  sessionLogout() {}
  sessionLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainPages()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              WidgetIlustration(
                image: "assets/fulllogo2.png",
                title: "ยินดีต้อนรับ",
                subtitle1: "ซื้อสินค้าออนไลน์",
                subtitle2: "ทุกที่ทุกเวลาที่คุณต้องการ",
              ),
              SizedBox(
                height: 100,
              ),
              ButtonPrimary(
                text: "เริ่มต้นใช้งาน",
                ontap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPages(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
