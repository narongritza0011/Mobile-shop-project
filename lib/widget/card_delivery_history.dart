import 'package:flutter/material.dart';
import 'package:medhealth/network/model/delivery_history_model.dart';
import 'package:medhealth/theme.dart';

class CardDeliveryHistory extends StatelessWidget {
  final DeliveryHistoryOrderModel model;
  CardDeliveryHistory({this.model});

  @override
  Widget build(BuildContext context) {

    String statusName = 'unknown';
    int statusColor = 0xffaabbcc;
    if (model.status == '1') {
      statusName = ' รอชำระเงิน';
      statusColor = 0xfffdd2c00;
    } else if (model.status == '2') {
      statusName = ' กำลังเตรียมสินค้า';
      statusColor = 0xfffbc02d;
    } else if (model.status == '3') {
      statusName = ' จัดส่งสินค้าเเล้ว';
      statusColor = 0xff64dd17;
    }
    return Card(
      margin: EdgeInsets.symmetric(vertical: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.description,
                      color: Colors.redAccent,
                    ),
                    Text(
                      ' เลขที่ใบเสร็จ ',
                      style: regulerTextStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      model.invoice,
                      style: boldTextStyle.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.alarm,
                  color: Colors.black87,
                ),
                Text(
                  '  ' + model.orderAt,
                  style: regulerTextStyle.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.history_toggle_off),
                Text(
                  statusName,
                  style: TextStyle(
                    color: Color(statusColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
