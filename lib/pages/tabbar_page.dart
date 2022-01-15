import 'package:flutter/material.dart';
import 'package:medhealth/pages/delivery_history_page.dart';
import 'package:medhealth/pages/history_page.dart';
import 'package:medhealth/pages/profile_page.dart';

class TabbarPage extends StatelessWidget {
  const TabbarPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title:
              Text('การสั่งซื้อของฉัน', style: TextStyle(color: Colors.black)),
          bottom: TabBar(indicatorColor: Colors.green, tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_shipping, color: Colors.black),
                  Text(
                    ' สั่งซื้อธรรมดา',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delivery_dining, color: Colors.black),
                  Text(' Delivery', style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ]),
        ),
        body: TabBarView(children: [
          HistoryPages(),
          DeliveryHistoryPage(),
        ]),
      ),
    );
  }
}
