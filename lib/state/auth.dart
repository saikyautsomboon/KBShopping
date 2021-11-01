import 'package:flutter/material.dart';
import 'package:kbshopping/utility/my_constant.dart';
import 'package:kbshopping/widget/show_image.dart';
import 'package:kbshopping/widget/show_title.dart';

class Auth extends StatefulWidget {
  // const Auth({ Key? key }) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool observeText = true;
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
            child: ListView(
          children: [
            buildimage(size),
            buildAppname(),
            buildEmail(size),
            buildPassword(size),
            buildLogin(size),
          ],
        )),
      ),
    );
  }

  Row buildLogin(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: size * 0.04),
          width: size * 0.7,
          child: ElevatedButton(
            style: MyConstant().mybuttonStyle(),
            onPressed: () {},
            child: Text('Login'),
          ),
        ),
      ],
    );
  }

  Row buildEmail(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top: size * 0.06),
          width: size * 0.7,
          child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_circle_rounded,
                color: MyConstant.primary,
              ),
              hintText: 'User/Email',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: MyConstant.dark),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: MyConstant.primary),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top: size * 0.05),
          width: size * 0.7,
          child: TextFormField(
            obscureText: observeText,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: MyConstant.primary,
              ),
              suffixIcon: IconButton(
                icon: observeText
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                onPressed: () {
                  setState(() {
                    observeText = !observeText;
                  });
                },
              ),
              hintText: 'Enter Your Password',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: MyConstant.dark),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: MyConstant.primary),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildAppname() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(
          title: MyConstant.appName,
          textStyle: MyConstant().h1style(),
        ),
      ],
    );
  }

  Row buildimage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.7,
          child: ShowImage(
            path: MyConstant.image1,
          ),
        ),
      ],
    );
  }
}
