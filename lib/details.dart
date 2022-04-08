import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class details extends StatefulWidget {
  const details({Key? key}) : super(key: key);

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  final TextEditingController name_controller = TextEditingController();
  final TextEditingController num_controller = TextEditingController();
  final TextEditingController add_controller = TextEditingController();

  String phar_name = "No Value Entered";
  String phar_num = "No Value Entered";
  String address = "No Value Entered";

  String? validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10) {
      return 'Mobile Number must be of 10 digit';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('details'),
          backgroundColor: Colors.blueGrey),
      body:
      Center(
        child: Padding(
        padding: //const EdgeInsets.all(8.0),
        const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                TextFormField(
                  controller: name_controller,
                  decoration: const InputDecoration(
                    hintText: 'Enter Pharmacy Name',
                    labelText: "Pharmacy Name",
                    labelStyle: TextStyle(color: Colors.blueGrey),
                  ),
                  onChanged: (text) {
                    phar_name=text;
                  },
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: num_controller,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Phone number',
                    labelText: "Pharmacy Phone number",
                    labelStyle: TextStyle(color: Colors.blueGrey),
                    //focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
                  ),
                ),

                const SizedBox(height: 10),

                TextFormField(
                  controller: add_controller,
                  decoration: const InputDecoration(
                    hintText: 'Address',
                    labelText: "Your Address",
                    labelStyle: TextStyle(color: Colors.blueGrey),
                    //focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
                  ),
                  onChanged: (text) {
                    address=text;
                  },
                ),

                const SizedBox(height: 10),

                FlatButton(
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  onPressed: () async {
                    await _firestore
                        .collection('users')
                        .doc(
                        _auth.currentUser!.uid)
                        .update(
                      {
                        'PharmacyName': name_controller.text.trim(),
                        'PharmacyNumber': num_controller.text.trim(),
                        'Address': add_controller.text.trim(),
                      },
                      //SetOptions(merge: true),
                    );

                    Navigator.pop(context);
                    Fluttertoast.showToast(
                        msg: "Details updated successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 14.0
                    );
                  },
                  child: Text('Update'),
                ),
              ],
            ),
        ),
      ),
    );
  }

}
