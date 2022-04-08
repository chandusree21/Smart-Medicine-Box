import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_medicine_box/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Future<DocumentSnapshot<Map<String, dynamic>>> v = _firestore.collection('users').doc(_auth.currentUser!.uid).get();
  @override
  Scaffold build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("History",
        style:TextStyle(
          fontSize: 20.0,
          color: Colors.blueGrey,
        ),),
      ),
    );
  }
}
