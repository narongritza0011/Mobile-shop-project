import 'package:flutter/material.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/pages/edit_profile_page.dart';
import 'package:medhealth/pages/login_page.dart';
import 'package:medhealth/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePages extends StatefulWidget {
  @override
  _ProfilePagesState createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  String fullName, phone, email, address, latitude, longitude, idUser;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      idUser = sharedPreferences.getString(PrefProfile.idUser);
      fullName = sharedPreferences.getString(PrefProfile.name);
      latitude = sharedPreferences.getString(PrefProfile.latitude);
      longitude = sharedPreferences.getString(PrefProfile.longitude);
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
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(24),
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
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 25,
                ),
                Text(
                  'เเก้ไขโปรไฟล์',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
            ),
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
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    Text(
                      'longitude',
                      style: boldTextStyle.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: whiteColor,
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
                Row(
                  children: [
                    Icon(
                      Icons.phone_iphone,
                      color: Colors.blue,
                    ),
                    Text(
                      phone,
                      style: boldTextStyle.copyWith(fontSize: 18),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
            ),
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
                Row(
                  children: [
                    Icon(
                      Icons.mail_outline,
                      color: Colors.blue,
                    ),
                    Text(
                      email,
                      style: boldTextStyle.copyWith(fontSize: 18),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: whiteColor,
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
                Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.blue,
                    ),
                    Text(
                      address,
                      style: boldTextStyle.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
