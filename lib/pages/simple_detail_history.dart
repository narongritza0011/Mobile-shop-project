import 'dart:convert' as cnv;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/history_model.dart';
import 'package:medhealth/network/model/history_order_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/card_detail.dart';
import 'package:medhealth/widget/card_history.dart';

class SimpleHistoryPage extends StatefulWidget {
  final HistoryOrderModel listdata;
  final OrderDetailModel model;
  SimpleHistoryPage({this.listdata, this.model});

  @override
  _SimpleHistoryPageState createState() => _SimpleHistoryPageState();
}

class _SimpleHistoryPageState extends State<SimpleHistoryPage> {
  List<OrderDetailModel> list = [];

  String idOrder;

  getPref() async {
    setState(() {
      idOrder = widget.listdata.idOrder;
    });

    getDetailHistory();
    print(idOrder);
  }

  getDetailHistory() async {
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
        // print(response.body);
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
          return CardDetail(
            model: x,
          );
        },
      ),
    );
  }
}



// Column(
//   children: [
//     Text(widget.listdata.idOrder),
//     Text(widget.listdata.invoice),
//     RaisedButton(onPressed: () {
//       getPref();
//     }),
//   ],
// ),
