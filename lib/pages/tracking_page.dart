import 'dart:convert' as cnv;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/network/model/tracking_model.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/card_tracking.dart';
import 'package:medhealth/widget/widget_ilustration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({Key key}) : super(key: key);

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  List<TrackingModel> model = [];
  String userID;

  String fullName, phone, email, address, idUser;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser);
    });
    getTracking();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getPref();
  }

  getTracking() async {
    // listdata.clear();
    var urlTracking = Uri.parse(BASEURL.getTracking + userID);
    final response = await http.get(urlTracking);
    if (response.statusCode == 200) {
      setState(() {
        List<dynamic> body = cnv.jsonDecode(response.body);
        model =
            body.map((dynamic item) => TrackingModel.fromJson(item)).toList();
        //print(userID);
      });
    } else {
      print('Url ผิดพลาด');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        elevation: 1,
        title: Text('ติดตามพัสดุ'),
        centerTitle: true,
      ),
      body: model.length == 0
          ? Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                child: WidgetIlustration(
                  image:
                      "assets/undraw_web_shopping_re_owap-removebg-preview.png",
                  title: "ไม่มีการเเจ้งเตือนพัสดุ",
                  subtitle1: "คุณไม่มีการเเจ้งเตือนติดตามพัสดุ",
                  subtitle2: "",
                ),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: model.length,
              itemBuilder: (context, i) {
                final x = model[i];
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: CardTracking(
                    model: x,
                  ),
                );
              }),
    );
  }
}
