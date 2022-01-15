import 'dart:convert' as cnv;
import 'package:flutter/material.dart';
import 'package:medhealth/main_page.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/about_model.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/button_primary.dart';

import 'package:http/http.dart' as http;

class SuccessCheckout extends StatefulWidget {
  @override
  _SuccessCheckoutState createState() => _SuccessCheckoutState();
}

class _SuccessCheckoutState extends State<SuccessCheckout> {
  List<AboutModel> model = [];
  // List<AboutModel> list = [];

  getData() async {
    var url = Uri.parse(BASEURL.aboutContact);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      //final data = jsonDecode(response.body);

      // print(response.body);
      setState(() {
        List<dynamic> body = cnv.jsonDecode(response.body);
        model = body.map((dynamic item) => AboutModel.fromJson(item)).toList();
      });
    }
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Container(
        child: ListView.builder(
            itemCount: model.length,
            itemBuilder: (context, i) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text('รายการสั่งซื้อสำเร็จ',
                          style: regulerTextStyle.copyWith(fontSize: 25),
                          textAlign: TextAlign.center),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'ช่องทางการชำระเงิน QRCODE',
                        style: regulerTextStyle.copyWith(
                            fontSize: 18, color: greyLightColor),
                      ),
                      Image.network(
                        model[i].imageQR,
                        width: 200,
                      ),
                      Text(
                        'หรือ',
                        style: regulerTextStyle.copyWith(
                            fontSize: 18, color: greyLightColor),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://i.pinimg.com/originals/26/96/c2/2696c2c7cac1c731475e585ac5847918.png',
                            width: 150,
                          ),
                          Text(': ' + model[i].bankNumber,
                              style: regulerTextStyle.copyWith(fontSize: 25),
                              textAlign: TextAlign.center),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(model[i].fullName,
                          style: regulerTextStyle.copyWith(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center),
                      SizedBox(
                        height: 20,
                      ),
                      Text('กรุณาส่งหลักฐานการชำระเงิน',
                          style: regulerTextStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      SizedBox(
                        height: 20,
                      ),
                      Text('ไปที่ Line :' + model[i].lineId,
                          style: regulerTextStyle.copyWith(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center),
                      SizedBox(
                        height: 30,
                      ),
                      ButtonPrimary(
                        text: "เสร็จสิ้น",
                        ontap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPages()),
                              (route) => false);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
