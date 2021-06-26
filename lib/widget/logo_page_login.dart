import 'package:flutter/material.dart';

class logo_page_login extends StatelessWidget {
  final Widget child;
  logo_page_login({this.child});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Image.asset(
            "assets/logo.png",
            width: 350,
          ),
          child ?? SizedBox()
        ],
      ),
    );
  }
}
