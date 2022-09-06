import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_medicine_box/functions/addmed.dart.';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class delMed extends StatefulWidget {
  const delMed({Key? key}) : super(key: key);

  @override
  State<delMed> createState() => _delMedState();
}

class _delMedState extends State<delMed> {
  String dropdownvalue = 'slot1';

  // List of items in our dropdown menu
  var items = [
    'slot1',
    'slot2',
    'slot3',
    'slot4',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Delete Medicine'),
          backgroundColor: Colors.blueGrey),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Row(
                children: [
                  const Text("Choose slot :",
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(width: 13),
                  DropdownButton(
                    // Initial Value
                    value: dropdownvalue,
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18.0,
                    ),
                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        alignment: Alignment.center,
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ],
              ),

              //const SizedBox(height: 5),

              const SizedBox(height: 20),

              FlatButton(
                color: Colors.blueGrey,
                textColor: Colors.white,
                onPressed: () async {
                  await _firestore
                      .collection('users')
                      .doc(
                      _auth.currentUser!.uid)
                      .update({dropdownvalue:FieldValue.delete()});
                  await _firestore
                      .collection('users')
                      .doc(
                      _auth.currentUser!.uid)
                      .update(
                    {
                      'Is'+'$dropdownvalue':false,
                    },
                  );
                    //SetOptions(merge: true),
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg: "Medicine deleted successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 14.0
                  );
                },
                child: Text('Delete'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
