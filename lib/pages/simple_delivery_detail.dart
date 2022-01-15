import 'package:flutter/material.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/delivery_history_model.dart';
import 'package:medhealth/network/model/delivery_history_order_detail_model.dart';
import 'package:medhealth/theme.dart';
import 'dart:convert' as cnv;
import 'package:http/http.dart' as http;
import 'package:medhealth/widget/card_delivery_detail.dart';

class SimpleDeliveryHistoryPage extends StatefulWidget {
  final DeliveryHistoryOrderModel listdata;
  final OrderDeliveryDetailModel model;
  SimpleDeliveryHistoryPage({this.listdata, this.model});

  @override
  _SimpleDeliveryHistoryPageState createState() =>
      _SimpleDeliveryHistoryPageState();
}

class _SimpleDeliveryHistoryPageState extends State<SimpleDeliveryHistoryPage> {
  List<OrderDeliveryDetailModel> list = [];

  String idOrder;

  getPref() async {
    setState(() {
      idOrder = widget.listdata.idOrder;
      // print('idorder = ${widget.listdata.idOrder}');
      //idOrder = '2';
    });

    getDetailHistory();
    //print(idOrder);
  }

  getDetailHistory() async {
    // listdata.clear();
    var urlDeliveryDetail =
        Uri.parse(BASEURL.deliveryHistoryOrderDetail + idOrder);
    final response = await http.get(urlDeliveryDetail);
    if (response.statusCode == 200) {
      setState(() {
        //  final data = cnv.jsonDecode(response.body);

        List<dynamic> body = cnv.jsonDecode(response.body);
        list = body
            .map((dynamic item) => OrderDeliveryDetailModel.fromJson(item))
            .toList();
        // for (Map item in data) {
        //   listdata.add(OrderDetailModel.fromJson(item));
        // }
        //  print(response.body);
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

  @override
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
          return CardDeliveryDetail(
            model: x,
          );
        },
      ),
    );
  }
}
