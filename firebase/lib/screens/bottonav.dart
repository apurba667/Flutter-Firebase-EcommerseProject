import 'package:firebase/screens/mobile.dart';
import 'package:firebase/screens/headphone.dart';
import 'package:firebase/screens/laptop.dart';
import 'package:firebase/screens/profile.dart';
import 'package:flip_box_bar_plus/flip_box_bar_plus.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    DisplayData(),
    LaptopData(),
    HeadphoneData(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[selectedIndex], //
      bottomNavigationBar: FlipBoxBarPlus(
        selectedIndex: selectedIndex,
        items: [
          FlipBarItem(
              icon: Icon(Icons.mobile_friendly),
              text: Text("Mobile"),
              frontColor: Colors.red,
              backColor: Colors.redAccent),
          FlipBarItem(
              icon: Icon(Icons.laptop),
              text: Text("laptop"),
              frontColor: Colors.green,
              backColor: Colors.greenAccent),
          FlipBarItem(
              icon: Icon(Icons.headphones),
              text: Text("Headphone"),
              frontColor: Colors.orange,
              backColor: Colors.orangeAccent),
          FlipBarItem(
              icon: Icon(Icons.person),
              text: Text("Profile"),
              frontColor: Colors.purple,
              backColor: Colors.purpleAccent),
        ],
        onIndexChanged: (newIndex) {
          setState(() {
            selectedIndex = newIndex;
          });
        },
      ),
    );
  }
}
