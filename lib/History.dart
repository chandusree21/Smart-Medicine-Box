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

  // Stream<DocumentSnapshot> provideDocumentFieldStream() {
  //   return _firestore
  //       .collection('users')
  //       .doc(_auth.currentUser!.uid)
  //       .snapshots();
  // }
  @override
  Scaffold build(BuildContext context) {
    // StreamBuilder<DocumentSnapshot>(
    //     stream: provideDocumentFieldStream(),
    //     builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //       if (snapshot.hasData) {
    //         //snapshot -> AsyncSnapshot of DocumentSnapshot
    //         //snapshot.data -> DocumentSnapshot
    //         //snapshot.data.data -> Map of fields that you need :)
    //
    //         Map<String, dynamic> documentFields = snapshot.data!.data as Map<String, dynamic>;
    //         //TODO Okay, now you can use documentFields (json) as needed
    //
    //         return Text(documentFields['name']);
    //       }
    //     }
    // );
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
  // Widget build(BuildContext context) {
  //   return StreamBuilder(
  //       stream: _firestore.collection('users').doc(_auth.currentUser!.uid).snapshots(),
  //       builder: (context, snapshot) {
  //         if (!snapshot.hasData) {
  //           return new Text("Loading");
  //         }
  //         var userDocument = snapshot.data;
  //         return Text(snapshot.data!["name"]);
  //       }
  //   );
  // }
}
