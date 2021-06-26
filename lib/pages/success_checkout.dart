import 'package:flutter/material.dart';
import 'package:medhealth/main_page.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:medhealth/widget/general_logo_space.dart';
import 'package:medhealth/widget/widget_ilustration.dart';

class SuccessCheckout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(24),
        children: [
          SizedBox(
            height: 80,
          ),
          WidgetIlustration(
            image: "assets/order_success_ilustration.png",
            title: "รายการสั่งซื้อสำเร็จ",
            subtitle1: "กรุณารอสักครู่",
            subtitle2: "จัดส่งสินค้าภายใน 15-30 นาที",
          ),
          SizedBox(
            height: 150,
          ),
          ButtonPrimary(
            text: "กลับหน้าหลัก",
            ontap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainPages()),
                  (route) => false);
            },
          ),
        ],
      ),
    ));
  }
}
