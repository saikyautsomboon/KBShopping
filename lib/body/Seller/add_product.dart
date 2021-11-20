// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:kbshopping/utility/my_constant.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Product'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              behavior: HitTestBehavior.opaque,
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        productName(constraints),
                        productPrice(constraints),
                        productDetail(constraints),
                        productImage(constraints),
                        addProducts(constraints),
                      ],
                    ),
                  ),
                ),
              )),
        ));
  }

  Container addProducts(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      child: ElevatedButton(
        onPressed: () {
          if (formkey.currentState.validate()) {}
        },
        style: MyConstant().mybuttonStyle(),
        child: Text('Add Product'),
      ),
    );
  }

  Column productImage(BoxConstraints constraints) {
    return Column(
      children: [
        Container(
          width: constraints.maxHeight * 0.75,
          height: constraints.maxWidth * 0.75,
          child: Image.asset(MyConstant.image6),
        ),
        Container(
          width: constraints.maxWidth * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 45,
                height: 45,
                child: Image.asset(MyConstant.image6),
              ),
              Container(
                width: 45,
                height: 45,
                child: Image.asset(MyConstant.image6),
              ),
              Container(
                width: 45,
                height: 45,
                child: Image.asset(MyConstant.image6),
              ),
              Container(
                width: 45,
                height: 45,
                child: Image.asset(MyConstant.image6),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget productName(BoxConstraints constraints) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      width: constraints.maxWidth * 0.75,
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please Enter Product Name';
          } else {}
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.production_quantity_limits,
            color: MyConstant.primary,
          ),
          hintText: 'Product Name',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyConstant.dark),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyConstant.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }

  Widget productPrice(BoxConstraints constraints) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      width: constraints.maxWidth * 0.75,
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please Enter Product Price';
          } else {}
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.attach_money_sharp,
            color: MyConstant.primary,
          ),
          hintText: 'Product Price',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyConstant.dark),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyConstant.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }

  Widget productDetail(BoxConstraints constraints) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      width: constraints.maxWidth * 0.75,
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please Enter Product Detail';
          } else {}
        },
        keyboardType: TextInputType.emailAddress,
        maxLines: 4,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
            child: Icon(
              Icons.details,
              color: MyConstant.primary,
            ),
          ),
          hintText: 'Product Detail',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyConstant.dark),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyConstant.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
