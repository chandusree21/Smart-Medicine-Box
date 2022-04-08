import 'package:flutter/material.dart';
import 'package:smart_medicine_box/Menu/MenuItem.dart';
import 'package:smart_medicine_box/main.dart';
import 'package:smart_medicine_box/Authenticate/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_medicine_box/details.dart';

import '../functions/addmed.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
class MenuItems {
  static const List<MenuItem> firstItems = [settings];
  static const List<MenuItem> secondItems = [logout];

  static const settings = MenuItem(text: 'Settings', icon: Icons.settings);
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);


  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(
            item.icon,
            color: Colors.blueGrey,
            size: 22
        ),
        const SizedBox(
          width: 7,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.settings:
        //Navigator.pushReplacement(context,
          //  MaterialPageRoute(builder: (BuildContext context) => details));
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const details()));
        break;
      case MenuItems.logout:
        _auth.signOut().then((value) => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => LoginScreen())));
      //Do something
        break;
    }
  }
}