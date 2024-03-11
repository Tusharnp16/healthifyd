import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:healthifyd/profile.dart';
import 'appoiment.dart';
import 'home.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});
  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    home(),
    appoiment(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(220, 59, 206, 255),
        title: const Text(
          "HealthifyD",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 1),
          child: Padding(
            padding: EdgeInsets.zero,
            child: GNav(
                iconSize: 20,
                // tabBorder: Border.all(color: Colors.grey, width: 1),
                color: Colors.black,
                backgroundColor: Colors.white60,
                tabBackgroundColor: Color.fromARGB(220, 59, 206, 255),
                activeColor: Colors.black,
                duration: const Duration(milliseconds: 500),
                gap: 5,
                tabActiveBorder: Border.all(
                    color: Colors.black, width: 2), // tab button border
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: "Home",
                  ),
                  GButton(
                      icon: Icons.local_hospital_outlined, text: "Appoiment"),
                  GButton(icon: Icons.more_horiz_outlined, text: "Profile"),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
