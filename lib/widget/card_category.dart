import 'package:flutter/material.dart';
import 'package:medhealth/theme.dart';

class CardCategory extends StatelessWidget {
  final String imageCategory;
  final String nameCategory;

  CardCategory({this.imageCategory, this.nameCategory});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imageCategory,
          width: 55,
        ),
        SizedBox(
          height: 7,
        ),
        Expanded(
          child: Text(
            nameCategory,
            style: regulerTextStyle.copyWith(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
