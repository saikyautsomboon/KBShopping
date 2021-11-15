import 'package:flutter/material.dart';
import 'package:kbshopping/utility/my_constant.dart';
import 'package:kbshopping/widget/show_logout.dart';
import 'package:kbshopping/widget/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Saler extends StatefulWidget {
  // const Saler({ Key? key }) : super(key: key);

  @override
  _SalerState createState() => _SalerState();
}

class _SalerState extends State<Saler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saler Page'),
      ),
      drawer: Drawer(
        child: ShowLogout(),
      ),
    );
  }
}
