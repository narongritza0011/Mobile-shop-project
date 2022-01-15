import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medhealth/main_page.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/delivery_history_model.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/pages/simple_delivery_detail.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:medhealth/widget/card_delivery_history.dart';
import 'package:medhealth/widget/widget_ilustration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DeliveryHistoryPage extends StatefulWidget {
  @override
  _DeliveryHistoryPageState createState() => _DeliveryHistoryPageState();
}

class _DeliveryHistoryPageState extends State<DeliveryHistoryPage> {
  List<DeliveryHistoryOrderModel> list = [];

  String userID;

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser);
    });
    getDeliveryHistory();
  }

  getDeliveryHistory() async {
    list.clear();
    var urlDeliveryHistory = Uri.parse(BASEURL.deliveryHistoryOrder + userID);
    final response = await http.get(urlDeliveryHistory);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          list.add(DeliveryHistoryOrderModel.fromJson(item));
        }
        // print(data);
        print(data);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list.length == 0
          ? Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                  child: WidgetIlustration(
                    image:
                        "assets/undraw_Note_list_re_r4u9__1_-removebg-preview.png",
                    title: "ไม่มีประวัติการสั่งซื้อสินค้า",
                    subtitle1: "คุณไม่มีประวัติการสั่งซื้อสินค้า",
                    subtitle2: "",
                    child: Container(
                      margin: EdgeInsets.only(top: 60),
                      width: MediaQuery.of(context).size.width,
                      child: ButtonPrimary(
                        text: "ดูสินค้า",
                        ontap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPages()),
                              (route) => false);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, i) {
                final x = list[i];
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: InkWell(
                    onTap: () {
                      // print(list);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SimpleDeliveryHistoryPage(
                            listdata: x,
                          ),
                        ),
                      );
                    },
                    child: CardDeliveryHistory(
                      model: x,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
