import 'package:flutter/material.dart';
import 'package:medhealth/pages/edit_profile_page.dart';
import 'package:medhealth/pages/history_page.dart';
import 'package:medhealth/pages/home_page.dart';
import 'package:medhealth/pages/page_profile.dart';
import 'package:medhealth/pages/profile_page.dart';
import 'package:medhealth/pages/tabbar_page.dart';
import 'package:medhealth/pages/tracking_page.dart';
import 'package:medhealth/theme.dart';

class MainPages extends StatefulWidget {
  @override
  _MainPagesState createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int _selectIndex = 0;

  final _pageList = [
    HomePages(),
    TabbarPage(),
    TrackingPage(),
    ProfileHomePage(),
  ];

  onTappedItem(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "หน้าหลัก"),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list), label: "การสั่งซื้อ"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_shipping), label: "ติดตามพัสดุ"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "บัญชี"),
        ],
        currentIndex: _selectIndex,
        onTap: onTappedItem,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.brown,
      ),
    );
  }
}
