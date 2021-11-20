import 'package:flutter/material.dart';
import 'package:kbshopping/body/Seller/shop_manage_seller.dart';
import 'package:kbshopping/body/Seller/show_order_seller.dart';
import 'package:kbshopping/body/Seller/show_product_seller.dart';
import 'package:kbshopping/utility/my_constant.dart';
import 'package:kbshopping/widget/show_logout.dart';
import 'package:kbshopping/widget/show_title.dart';

class Saler extends StatefulWidget {
  // const Saler({ Key? key }) : super(key: key);

  @override
  _SalerState createState() => _SalerState();
}

class _SalerState extends State<Saler> {
  List<Widget> widgets = [
    Order(),
    Manage(),
    Product(),
  ];
  int indexWidget = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller Page'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            ShowLogout(),
            Column(
              children: [
                UserAccountsDrawerHeader(accountName: null, accountEmail: null),
                buildShowOrder(),
                buildShopManage(),
                buildShowProduct()
              ],
            ),
          ],
        ),
      ),
      body: widgets[indexWidget],
    );
  }

  ListTile buildShowProduct() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 2;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_3_outlined),
      title: ShowTitle(
        title: 'Show Product',
        textStyle: MyConstant().h2style(),
      ),
      subtitle: ShowTitle(
        title: 'Show details of the Product',
        textStyle: MyConstant().h3style(),
      ),
    );
  }

  ListTile buildShopManage() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 1;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_2_rounded),
      title: ShowTitle(
        title: 'Shop Manage',
        textStyle: MyConstant().h2style(),
      ),
      subtitle: ShowTitle(
        title: 'Show the storefront to Customers',
        textStyle: MyConstant().h3style(),
      ),
    );
  }

  ListTile buildShowOrder() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 0;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_1_rounded),
      title: ShowTitle(
        title: 'Show Order',
        textStyle: MyConstant().h2style(),
      ),
      subtitle: ShowTitle(
        title: 'Show Customer List Order',
        textStyle: MyConstant().h3style(),
      ),
    );
  }
}
