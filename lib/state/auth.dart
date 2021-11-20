import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kbshopping/model/user_model.dart';
import 'package:kbshopping/utility/my_constant.dart';
import 'package:kbshopping/utility/my_dialog.dart';
import 'package:kbshopping/widget/show_image.dart';
import 'package:kbshopping/widget/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends StatefulWidget {
  // const Auth({ Key? key }) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool observeText = true;
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // keyboard တက်လာတဲ့ချိန်မှာ အောက်ပြန်ဆင်းအောင်လုပ်ပေးတာ
          FocusScope.of(context).requestFocus(FocusNode());
        },
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formkey,
          child: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                buildimage(size),
                buildAppname(),
                buildEmail(size),
                buildPassword(size),
                buildLogin(size),
                buildCreateAccount(),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Row buildCreateAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(
          title: 'No Account ?',
          textStyle: MyConstant().h3style(),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, MyConstant.routeRegister);
          },
          child: Text('Create Account'),
        ),
      ],
    );
  }

  Row buildLogin(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 14),
          width: size * 0.7,
          child: ElevatedButton(
            style: MyConstant().mybuttonStyle(),
            onPressed: () {
              if (formkey.currentState.validate()) {
                String email = emailController.text;
                String password = passwordController.text;
                // print('Email $email and Password $password');
                checkAuth(email: email, password: password);
              }
            },
            child: Text('Login'),
          ),
        ),
      ],
    );
  }

  Future<Null> checkAuth({String email, String password}) async {
    String apiCheckAuth =
        '${MyConstant.domain}/kbshopping/getUserWhereUser.php?isAdd=true&email=$email';
    await Dio().get(apiCheckAuth).then(
      (value) async {
        // print('Value for API ==>> $value');
        if (value.toString() == 'null') {
          MyDialog()
              .simpleDialop(context, 'Email Fail!', 'NO $email in Register');
        } else {
          for (var item in json.decode(value.data)) {
            UserModel model = UserModel.fromMap(item);
            if (password == model.password) {
              String usertype = model.usertype;
              // print('## Authen Success in UserType ==>> $usertype');
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setString('usertype', usertype);
              preferences.setString('email', model.email);
              switch (usertype) {
                case 'Buyer':
                  Navigator.pushNamedAndRemoveUntil(
                      context, MyConstant.routeByer, (route) => false);
                  break;
                case 'Seller':
                  Navigator.pushNamedAndRemoveUntil(
                      context, MyConstant.routeSaler, (route) => false);
                  break;
                case 'Driver':
                  Navigator.pushNamedAndRemoveUntil(
                      context, MyConstant.routeRider, (route) => false);
                  break;
                default:
              }
            } else {
              MyDialog().simpleDialop(
                  context, 'Password Fail!', 'Please Enter Your Password');
            }
          }
        }
      },
    );
  }

  Row buildEmail(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top: 17),
          width: size * 0.7,
          child: TextFormField(
            controller: emailController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Your Email';
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.emailAddress,
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
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.red),
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
          padding: EdgeInsets.only(top: 16),
          width: size * 0.7,
          child: TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Your Password';
              } else {
                return null;
              }
            },
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
              hintText: 'Password',
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
