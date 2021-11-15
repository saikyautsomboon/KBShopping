import 'package:flutter/material.dart';
import 'package:kbshopping/widget/show_logout.dart';

class Rider extends StatefulWidget {
  // const Rider({ Key? key }) : super(key: key);

  @override
  _RiderState createState() => _RiderState();
}

class _RiderState extends State<Rider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rider Page'),
      ),
      drawer: Drawer(
        child: ShowLogout(),
      ),
    );
  }
}
