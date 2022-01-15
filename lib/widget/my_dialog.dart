import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyDialog {
  Future<Null> alertLocationService(BuildContext context,String title , String message) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: ListTile(
                leading: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/235/235861.png'),
                title: Text(title),
                subtitle: Text(message),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    //  Navigator.pop(context);
                    await Geolocator.openLocationSettings();
                    exit(0);
                  },
                  child: Text('ตกลง'),
                )
              ],
            ));
  }
}
