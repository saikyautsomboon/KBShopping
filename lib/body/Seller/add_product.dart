// ignore_for_file: missing_return

import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kbshopping/utility/my_constant.dart';
import 'package:kbshopping/utility/my_dialog.dart';
import 'package:kbshopping/widget/show_image.dart';
import 'package:kbshopping/widget/show_title.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final formkey = GlobalKey<FormState>();
  List<File> files = [];
  File file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialFile();
  }

  void initialFile() {
    for (var i = 0; i < 4; i++) {
      files.add(null);
    }
  }

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
        onPressed: () => processAddProduct(),
        style: MyConstant().mybuttonStyle(),
        child: Text('Add Product'),
      ),
    );
  }

  Future<Null> processAddProduct() async {
    if (formkey.currentState.validate()) {
      bool checkFile = true;
      for (var item in files) {
        if (item == null) {
          checkFile = false;
        }
      }
      if (checkFile) {
        // print('Upload 4 image Success');
        String apiSaveProduct =
            '${MyConstant.domain}/kbshopping/saveProduct.php';
        // print('MY APi is $apiSaveProduct');

        MyDialog().showProgressDialog(context);
        int loop = 0;

        for (var item in files) {
          int i = Random().nextInt(10000000);
          String nameFile = 'product$i.jpg';

          Map<String, dynamic> map = {};
          map['file'] =
              await MultipartFile.fromFile(item.path, filename: nameFile);

          FormData data = FormData.fromMap(map);
          // print('## Data is $data');
          await Dio().post(apiSaveProduct, data: data).then((value) {
            loop++;
            if (loop >= files.length) {
              Navigator.pop(context);
            }
          });
        }
      } else {
        MyDialog()
            .simpleDialop(context, 'More Image', 'Please Choose More Image');
      }
    }
  }

  Future<Null> processImagePicker(ImageSource source, int index) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxHeight: 800,
        maxWidth: 800,
      );

      setState(() {
        file = File(result.path);
        files[index] = File(result.path);
      });
    } catch (e) {}
  }

  Future<Null> chooseSourceImageDialog(int index) async {
    print('Click From index ==>> $index');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(
            path: MyConstant.image2,
          ),
          title: ShowTitle(
            title: 'Source Image ${index + 1}',
            textStyle: MyConstant().h2style(),
          ),
          subtitle: ShowTitle(
            title: 'Plase Tab on Camera or Gallery',
            textStyle: MyConstant().h3style(),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  processImagePicker(ImageSource.camera, index);
                  Navigator.pop(context);
                },
                child: Text('Camera'),
              ),
              TextButton(
                onPressed: () {
                  processImagePicker(ImageSource.gallery, index);
                  Navigator.pop(context);
                },
                child: Text('Gallery'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Column productImage(BoxConstraints constraints) {
    return Column(
      children: [
        Container(
          width: constraints.maxHeight * 0.75,
          height: constraints.maxWidth * 0.75,
          child:
              file == null ? Image.asset(MyConstant.image6) : Image.file(file),
        ),
        Container(
          width: constraints.maxWidth * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildproductmultiimage(0),
              buildproductmultiimage(1),
              buildproductmultiimage(2),
              buildproductmultiimage(3),
            ],
          ),
        )
      ],
    );
  }

  Container buildproductmultiimage(int index) {
    return Container(
      width: 45,
      height: 45,
      child: InkWell(
        onTap: () {
          chooseSourceImageDialog(index);
        },
        child: files[index] == null
            ? Image.asset(MyConstant.image6)
            : Image.file(
                files[index],
                fit: BoxFit.cover,
              ),
      ),
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
