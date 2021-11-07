import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kbshopping/utility/my_constant.dart';
import 'package:kbshopping/utility/my_dialog.dart';
import 'package:kbshopping/widget/show_image.dart';
import 'package:kbshopping/widget/show_progress.dart';
import 'package:kbshopping/widget/show_title.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Register extends StatefulWidget {
  // const Register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String typeUser;
  bool observeText = true;
  File file; // ပုံထည့်ဖို့တွက်
  double lat, lng; //5.11.21
  final formkey = GlobalKey<FormState>(); //6.11.21

  @override
  void initState() {
    super.initState();
    checkLocation(); //5.11.21
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
        backgroundColor: MyConstant.primary,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildtitle('ขอมูลทั้วไป'),
                buildName(size),
                buildtitle('ชนิดของ User'),
                buildUser(size, 'ผู่ซื้อ (Buyer)', 'Buyer'),
                buildUser(size, 'ผู่ขาย (Seller)', 'Seller'),
                buildUser(size, 'ผู่ส่ง (Driver)', 'Driver'),
                buildtitle('ขัอมูลพื้นฐาน'),
                buildAddress(size),
                buildPhone(size),
                buildEmail(size),
                buildPassword(size),
                buildtitle('Photo'),
                buildAvatar(size),
                buildtitle('Map Location'),
                buildMap(),
                buildRegister(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildRegister(double size) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      width: size * 0.7,
      child: ElevatedButton(
        style: MyConstant().mybuttonStyle(),
        onPressed: () {
          if (formkey.currentState.validate()) {
            if (typeUser == null) {
              print('NO Choose Type User');
              MyDialog().simpleDialop(
                  context, 'No Choose User', 'Please Choose Type of User');
            } else {
              print('Your is $typeUser');
            }
          }
        },
        child: Text('Register'),
      ),
    );
  }

//5.11.21
  Future<Null> checkLocation() async {
    bool locationservice;

    LocationPermission locationPermission;
    locationservice = await Geolocator.isLocationServiceEnabled();

    if (locationservice) {
      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'Location Service OFF', 'Please Open Your Location');
        } else {
          findlatlao();
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'Location Service OFF', 'Please Open Your Location');
        } else {
          findlatlao();
        }
      }
    } else {
      print('Location is Close');
      MyDialog().alertLocationService(
          context, 'Location Service OFF', 'Please Open Your Location');
    }
  }

//5.11.21
  Future<Null> findlatlao() async {
    print('work');
    Position position = await findlocation();
    setState(() {
      lat = position.latitude;
      lng = position.longitude;
      print('lat = $lat and lng=$lng');
    });
  }

//5.11.21
  Set<Marker> setMarker() => <Marker>[
        Marker(
          markerId: MarkerId('Id'),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: 'Your Locaiton',
            snippet: 'Lat $lat , Lng $lng',
          ),
        ),
      ].toSet();
//5.11.21
  Container buildMap() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      height: 300,
      child: Center(
        child: lat == null
            ? ShowProgress()
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, lng),
                  zoom: 16,
                ),
                onMapCreated: (controller) {},
                markers: setMarker(),
              ),
      ),
    );
  }

//5.11.21
  Future<Position> findlocation() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result.path);
      });
    } catch (e) {}
  }

  Padding buildAvatar(double size) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(
              Icons.photo_camera,
              size: 30,
            ),
            onPressed: () {
              chooseImage(ImageSource.camera);
            },
          ),
          Container(
            width: size * 0.4,
            child: file == null
                ? ShowImage(
                    path: MyConstant.avatar,
                  )
                : Image.file(file),
          ),
          IconButton(
            icon: Icon(
              Icons.photo,
              size: 30,
            ),
            onPressed: () {
              chooseImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  Row buildUser(double size, String userType, String userValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: userValue,
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String;
              });
            },
            title: ShowTitle(
              title: userType,
              textStyle: MyConstant().h3style(),
            ),
          ),
        ),
      ],
    );
  }

  // Row buildSeller(double size) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //         width: size * 0.6,
  //         child: RadioListTile(
  //           value: 'Seller',
  //           groupValue: typeUser,
  //           onChanged: (value) {
  //             setState(() {
  //               typeUser = value;
  //             });
  //           },
  //           title: ShowTitle(
  //             title: 'ผู่ขาย (Seller)',
  //             textStyle: MyConstant().h2style(),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Row buildDriver(double size) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //         width: size * 0.6,
  //         child: RadioListTile(
  //           value: 'Driver',
  //           groupValue: typeUser,
  //           onChanged: (value) {
  //             setState(() {
  //               typeUser = value;
  //             });
  //           },
  //           title: ShowTitle(
  //             title: 'ผู่ส่ง (Driver)',
  //             textStyle: MyConstant().h2style(),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Padding buildtitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2style(),
      ),
    );
  }

  Row buildName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          width: size * 0.7,
          child: TextFormField(
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Your Name';
              } else {}
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.perm_identity,
                color: MyConstant.primary,
              ),
              hintText: 'Name',
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

  Row buildAddress(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          width: size * 0.7,
          child: TextFormField(
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Your Address';
              } else {}
            },
            maxLines: 4,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Icon(
                  Icons.home,
                  color: MyConstant.primary,
                ),
              ),
              hintText: 'Address',
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

  Row buildEmail(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          width: size * 0.7,
          child: TextFormField(
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Your Email';
              } else {}
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.alternate_email,
                color: MyConstant.primary,
              ),
              hintText: 'Email',
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

  Row buildPhone(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          width: size * 0.7,
          child: TextFormField(
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Your Phone';
              } else {}
            },
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.phone,
                color: MyConstant.primary,
              ),
              hintText: 'Phone',
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
          padding: EdgeInsets.symmetric(vertical: 15),
          width: size * 0.7,
          child: TextFormField(
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Your Password';
              } else {}
            },
            obscureText: observeText,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock_outline,
                color: MyConstant.primary,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    observeText = !observeText;
                  });
                },
                icon: observeText
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.remove_red_eye_outlined),
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
            ),
          ),
        ),
      ],
    );
  }
}
