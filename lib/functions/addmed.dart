import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:smart_medicine_box/functions/Notification.dart';
import 'dart:async';

import '../MyHomePage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class addmed extends StatefulWidget {
  const addmed({Key? key}) : super(key: key);
  @override
  State<addmed> createState() => _addmedState();
}

class _addmedState extends State<addmed> {
  final TextEditingController med_controller = TextEditingController();

  String dropdownvalue = 'slot1';
  // List of items in our dropdown menu
  var items = [
    'slot1',
    'slot2',
    'slot3',
    'slot4',
  ];
  String medName = "No Value Entered";
  TimeOfDay selectedTime = TimeOfDay.now();
  late Timer mytimer;

  void initState(){
    //getUserData();
    super.initState();
    NotificationApi.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Add Medicine'),
          backgroundColor: Colors.blueGrey),
      body:
        Center(
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

                TextFormField(
                  controller: med_controller,
                  decoration: const InputDecoration(
                      hintText: 'Enter medicine name',
                      labelText: "Medicine Name",
                      labelStyle: TextStyle(color: Colors.blueGrey),
                      //focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
                  ),
                  onChanged: (text) {
                   medName=text;
                  },
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    const Text("Reminder",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {
                        _selectTime(context);
                      },
                      child: Text("Choose Time"),
                    ),
                    const SizedBox(width: 10),
                    Text("${selectedTime.hour}:${selectedTime.minute}"),
                  ],
                ),

                const SizedBox(height: 20),

                FlatButton(
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  onPressed: () async {
                    final DocumentSnapshot doc = await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
                    if(doc['Is'+'$dropdownvalue']==false){
                    await _firestore
                        .collection('users')
                        .doc(
                        _auth.currentUser!.uid)
                        .update(
                        {
                          dropdownvalue+'.medicineName': med_controller
                              .text
                              .trim(),
                          dropdownvalue+'.Time.Hour':
                              selectedTime.hour,
                          dropdownvalue+'.Time.Minute':
                              selectedTime.minute,
                          'Is'+'$dropdownvalue':true,
                        },
                    );
                    var m = med_controller.text.trim();
                    //FlutterAlarmClock.createAlarm(selectedTime.hour,selectedTime.minute,title: "Time to take $m in $dropdownvalue");
                    var dt = DateTime.now();
                    // mytimer = Timer.periodic(Duration(seconds: 10), (timer) {
                    //   //FlutterAlarmClock.createAlarm(dt.hour, dt.minute+2,title: "Time to take $m in $dropdownvalue");
                    // });

                    // if(dt.hour == selectedTime.hour && dt.minute == selectedTime.minute){
                    //   NotificationApi.showNotification(
                    //     title: "Notification",
                    //     body: "Time to take $m in $dropdownvalue",
                    //   );
                    // }
                    NotificationApi.showDailyAtTimeNotification(
                        title: "Medication",
                        body: "Time to take $m in $dropdownvalue",
                        time: Time(selectedTime.hour,selectedTime.minute,00)
                    );

                    Navigator.pop(context);
                    Fluttertoast.showToast(
                        msg: "Medicine added successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 14.0
                    );
                    }
                    else{
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => MyHomePage(),
                        ),
                            (route) => false,
                      );
                      Fluttertoast.showToast(
                          msg: "Slot is already filled Please Choose another slot?",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 14.0
                      );
                    }
                  },
                  child: Text('Add'),
                ),

              ],
            ),
          ),
        ),
      );
  }
  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
}
