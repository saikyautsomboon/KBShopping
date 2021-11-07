import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kbshopping/utility/my_constant.dart';
import 'package:kbshopping/widget/show_image.dart';
import 'package:kbshopping/widget/show_title.dart';

class MyDialog {
  Future<Null> alertLocationService(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(
            path: MyConstant.image2,
          ),
          title: ShowTitle(
            title: title,
            textStyle: MyConstant().h2style(),
          ),
          subtitle: ShowTitle(
            title: message,
            textStyle: MyConstant().h3style(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: TextButton(
              onPressed: () async {
                await Geolocator.openLocationSettings();
                exit(0);
              },
              child: Text('OK'),
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> simpleDialop(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: ShowImage(
            path: MyConstant.image2,
          ),
          title: ShowTitle(
            title: title,
            textStyle: MyConstant().h2style(),
          ),
          subtitle: ShowTitle(
            title: message,
            textStyle: MyConstant().h3style(),
          ),
        ),
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
