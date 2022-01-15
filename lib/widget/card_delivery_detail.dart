import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medhealth/network/model/delivery_history_order_detail_model.dart';
import 'package:medhealth/theme.dart';

class CardDeliveryDetail extends StatelessWidget {
  final price = NumberFormat("#,##0", "EN_US");
  final OrderDeliveryDetailModel model;
  CardDeliveryDetail({this.model});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.network(
                      model.image,
                      height: 100,
                      width: 100,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  model.name,
                  overflow: TextOverflow.ellipsis,
                  style: regulerTextStyle.copyWith(fontSize: 16),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('จำนวน ', style: TextStyle(fontSize: 16)),
                    Text(
                      model.quantity,
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                    Text(' ชิ้น', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'ราคา ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      price.format(
                        int.parse(model.price),
                      ),
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                    Text(
                      ' บาท',
                      style: TextStyle(fontSize: 16),
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
      ),
    );
  }
}
