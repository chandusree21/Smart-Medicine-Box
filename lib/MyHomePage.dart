import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/scheduler.dart';
import 'package:smart_medicine_box/Home.dart';
import 'package:smart_medicine_box/Menu/MenuItem.dart';
import 'package:smart_medicine_box/Menu/MenuItems.dart';
import 'package:smart_medicine_box/History.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  void initState() {
    // TODO: implement initState
    print("initState");
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      print("WidgetsBinding");
    });
    /****SchedulerBinding.instance?.addPostFrameCallback((_) {
      print("SchedulerBinding");
    });*****/
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    History(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.



    //const TextStyle optionStyle = TextStyle(fontSize: 27, fontWeight: FontWeight.bold);



    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Home'),
        backgroundColor: Colors.blueGrey,
        actions: [DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: const Icon(
              Icons.list,
              size: 46,
              color: Colors.white,
            ),
            customItemsIndexes: const [3],
            customItemsHeight: 5,
            items: [
              ...MenuItems.firstItems.map(
                    (item) =>
                    DropdownMenuItem<MenuItem>(
                      value: item,
                      child: MenuItems.buildItem(item),
                    ),
              ),
              const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
              ...MenuItems.secondItems.map(
                    (item) =>
                    DropdownMenuItem<MenuItem>(
                      value: item,
                      child: MenuItems.buildItem(item),
                    ),
              ),
            ],
            onChanged: (value) {
              MenuItems.onChanged(context, value as MenuItem);
            },
            itemHeight: 25,
            dropdownWidth: 130,
            itemPadding: const EdgeInsets.only(left: 16, right: 16),
            dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
            //dropdownBorderRadius: BorderRadius.circular(4),
            //dropdownBorder: null,
            //dropdownColor: Colors.blueGrey,
            dropdownElevation: 8,
            offset: const Offset(0, 8),
          ),
        ),],
      ),

      body: _widgetOptions.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        onTap: _onItemTapped,

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
