import 'package:flutter/material.dart';

class Manage extends StatefulWidget {
  const Manage({Key key}) : super(key: key);

  @override
  _ManageState createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('This is Shop Manage'),
    );
  }
}
