import 'package:flutter/material.dart';
import 'package:medhealth/network/model/tracking_model.dart';
import 'package:medhealth/theme.dart';

class CardTracking extends StatelessWidget {
  final TrackingModel model;
  CardTracking({this.model});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.description,
                      color: Colors.redAccent,
                    ),
                    Text(
                      '  เลขที่ใบเสร็จ : ',
                      style: regulerTextStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      model.invoice,
                      style: boldTextStyle.copyWith(fontSize: 16),
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.local_shipping,
                      color: Colors.black45,
                    ),
                    Text(
                      '  หมายเลขติดตามพัสดุ : ',
                      style: regulerTextStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      model.noTracking,
                      style: boldTextStyle.copyWith(fontSize: 16),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(),
            Row(
              children: [
                Icon(Icons.history_toggle_off),
                Text(
                  ' ' + model.orderAt,
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
