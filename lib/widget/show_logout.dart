import 'package:flutter/material.dart';
import 'package:kbshopping/utility/my_constant.dart';
import 'package:kbshopping/widget/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowLogout extends StatelessWidget {
  const ShowLogout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.clear().then((value) {
              Navigator.pushNamedAndRemoveUntil(
                  context, MyConstant.routeAuth, (route) => false);
            });
          },
          tileColor: Colors.redAccent.shade200,
          leading: Icon(
            Icons.logout,
            color: MyConstant.light,
            size: 34,
          ),
          title: ShowTitle(
            title: 'LogOut',
            textStyle: MyConstant().h2Whitestyle(),
          ),
          subtitle: ShowTitle(
            title: 'LogOut And Go to Login',
            textStyle: MyConstant().h3Whitestyle(),
          ),
        ),
      ],
    );
  }
}
