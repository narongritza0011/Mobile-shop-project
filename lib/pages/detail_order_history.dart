import 'dart:convert' as cnv;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/history_order_detail_model.dart';
import 'package:medhealth/theme.dart';
import 'package:http/http.dart' as http;

class DetailOrderHistry extends StatefulWidget {
  final OrderDetailModel model;

   DetailOrderHistry({this.model});

  @override
  _DetailOrderHistryState createState() => _DetailOrderHistryState();
}

class _DetailOrderHistryState extends State<DetailOrderHistry> {
  final price = NumberFormat("#,##0", "EN_US");
  List<OrderDetailModel> list = [];
  String idOrder;

  getPref() async {
    setState(() {
      idOrder = '43';
    });
    getHistory();
  }

  getHistory() async {
    // listdata.clear();
    var urlDetail = Uri.parse(BASEURL.historyOrderDetail + idOrder);
    final response = await http.get(urlDetail);
    if (response.statusCode == 200) {
      setState(() {
        //  final data = cnv.jsonDecode(response.body);
      
        List<dynamic> body = cnv.jsonDecode(response.body);
        list = body
            .map((dynamic item) => OrderDetailModel.fromJson(item))
            .toList();
        // for (Map item in data) {
        //   listdata.add(OrderDetailModel.fromJson(item));
        // }
        print(response.body);
        // print(list);
      });
    } else {
      print('Url ผิดพลาด');
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('รายละเอียด',
            style: regulerTextStyle.copyWith(
              fontSize: 25,
            )),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, i) {
          final x = list[i];
          return Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              list[i].image,
                              height: 100,
                              width: 100,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  list[i].name,
                                  style:
                                      regulerTextStyle.copyWith(fontSize: 18),
                                ),
                                Row(
                                  children: [
                                    Text('จำนวน ',
                                        style: TextStyle(fontSize: 18)),
                                    Text(
                                      list[i].quantity,
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 18),
                                    ),
                                    Text(' ชิ้น',
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'ราคา ',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      price.format(
                                        int.parse(list[i].price),
                                      ),
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 18),
                                    ),
                                    Text(
                                      ' บาท',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
