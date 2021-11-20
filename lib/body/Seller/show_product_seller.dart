import 'package:flutter/material.dart';
import 'package:kbshopping/utility/my_constant.dart';

class Product extends StatefulWidget {
  const Product({Key key}) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('This is Show Product'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, MyConstant.routeAddProduct);
        },
        child: Text('Add'),
      ),
    );
  }
}
