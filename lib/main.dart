import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_medicine_box/Authenticate/LoginScreen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:smart_medicine_box/Home.dart';
import 'package:smart_medicine_box/Menu/MenuItem.dart';
import 'package:smart_medicine_box/Menu/MenuItems.dart';
import 'package:smart_medicine_box/History.dart';
import 'package:smart_medicine_box/wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  /*
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: wrapper(),
    );
  }
   */

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Center(
            child: Text('Could not load app'),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Phone Verification',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: Colors.blueGrey,
                primarySwatch: Colors.blueGrey,
                inputDecorationTheme: const InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.grey)),
                backgroundColor: Colors.white),
            home: LoginScreen(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  )
                ],
              )
            ]);
      },
    );
  }
}
