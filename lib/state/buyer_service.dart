import 'package:flutter/material.dart';
import 'package:kbshopping/widget/show_logout.dart';

class Buyer extends StatefulWidget {
  // const Buyer({ Key? key }) : super(key: key);

  @override
  _BuyerState createState() => _BuyerState();
}

class _BuyerState extends State<Buyer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buyer Page'),
      ),
      drawer: Drawer(
        child: ShowLogout(),
      ),
    );
  }
}
