import 'package:flutter/material.dart';
import 'package:medhealth/network/model/history_order_detail_model.dart';
import 'package:medhealth/theme.dart';

class Detailhistory extends StatelessWidget {
  final OrderDetailModel model;

  Detailhistory({this.model});

  @override
  Widget build(BuildContext context) {
    // String statusName = 'unknown';
    // int statusColor = 0xffaabbcc;
    // if (model.status == '1') {
    //   statusName = ' รอชำระเงิน';
    //   statusColor = 0xfffdd2c00;
    // } else if (model.status == '2') {
    //   statusName = ' กำลังเตรียมสินค้า';
    //   statusColor = 0xfffbc02d;
    // } else if (model.status == '3') {
    //   statusName = ' จัดส่งสินค้าเเล้ว';
    //   statusColor = 0xff64dd17;
    // } else {
    //   statusName = 'waiting';
    // }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title:
            Text('รายละเอียด', style: regulerTextStyle.copyWith(fontSize: 25)),
      ),
      body: SafeArea(
        child: ListView(children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Text(
                  "เลขที่ใบเสร็จ : 202100000008182257",
                  style: regulerTextStyle.copyWith(fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Text(
                  "วัน-เวลา : 2021-08-25 23:22:57",
                  style: regulerTextStyle.copyWith(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "สถานะ :",
                    style: regulerTextStyle.copyWith(fontSize: 20),
                  ),
                  Text(
                    'model.status',
                    style: regulerTextStyle.copyWith(
                      fontSize: 20,
                      color: Color(0xfffdd2c00),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "รายการสั่งซื้อ",
                style: regulerTextStyle.copyWith(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "KAT-TO Cat Litter Lemon แคทโตะ ทรายแมวกลิ่น",
                style: regulerTextStyle.copyWith(fontSize: 16),
              ),
              Text(
                "จำนวน 1 ชิ้น  ราคา 299",
                style: regulerTextStyle.copyWith(fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "MAKAR กะบะทรายแมวเสริมขอบสูง ",
                style: regulerTextStyle.copyWith(fontSize: 16),
              ),
              Text(
                "จำนวน 2 ชิ้น  ราคา 500",
                style: regulerTextStyle.copyWith(fontSize: 16),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "ราคารวม 1299 บาท",
                style: boldTextStyle.copyWith(fontSize: 20),
              ),
            ],
          ),
          SizedBox(
            height: 80,
          ),
        ]),
      ),
    );
  }
}
