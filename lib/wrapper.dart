import 'package:flutter/material.dart';
import 'package:smart_medicine_box/Authenticate/LoginScreen.dart';
import 'package:smart_medicine_box/main.dart';
import 'package:smart_medicine_box/MyHomePage.dart';

class wrapper extends StatelessWidget {
  const wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //return either Home or authenticate page
    return const MyHomePage();
  }
}
