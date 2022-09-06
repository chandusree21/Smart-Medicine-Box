import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:smart_medicine_box/functions/delMed.dart';
import 'package:smart_medicine_box/functions/modifyMed.dart';
import 'package:smart_medicine_box/main.dart';
import 'package:smart_medicine_box/functions/addmed.dart';
import 'package:smart_medicine_box/functions/delMed.dart';
import 'package:smart_medicine_box/functions/modifyMed.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  ButtonStyle style = ElevatedButton.styleFrom(primary: Colors.blueGrey ,textStyle: const TextStyle(fontSize: 20),fixedSize: Size(170.0, 50.0));

  @override
  Widget build(BuildContext context) {
    //WidgetsBinding.instance?.addPostFrameCallback((_) => onAfterBuild(context));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              style: style,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder  : (context)=>const addmed()));
              } ,
              child: const Text('Add Medicine'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const modifyMed()));
              },
              child: const Text('Modify Medicine'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const delMed()));
              },
              child: const Text('Delete Medicine'),
            ),
          ],
        ),
      ),
    );
  }
}
