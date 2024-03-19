import 'package:flutter/material.dart';
import 'package:petshop/UI/Screens/category.dart';

import '../UI/Screens/Favorites.dart';
import '../UI/Screens/Home.dart';
import '../UI/Screens/Profile.dart';
import '../UI/Screens/notificationScreen.dart';

int selectedIndex = 0;

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

final screens = [
  Home(),
  Favorites(),
  NotificationScreen(id: '',),
  Profile(),
];


class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF0E697C),
        elevation: 0,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_)=> Category()));
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 27,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF0E697C),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Color(0xFF0E697C),
        onTap: (index) {
          print(selectedIndex);
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: selectedIndex == 0
                  ? Icon(
                      Icons.home_rounded,
                      color: Color(0xFF0E697C),
                    )
                  : Icon(Icons.home_outlined),
              label: ""),

          BottomNavigationBarItem(
              icon: selectedIndex == 1
                  ? Icon(
                      Icons.favorite_rounded,
                      color: Color(0xFF0E697C),
                    )
                  : Icon(Icons.favorite_border),
              label: ""),
          BottomNavigationBarItem(
              icon: selectedIndex == 2
                  ? Icon(Icons.notifications, color: Color(0xFF0E697C))
                  : Icon(Icons.notifications_none_rounded),
              label: ""),
          BottomNavigationBarItem(
              icon: selectedIndex == 3
                  ? Icon(
                      Icons.person,
                      color: Color(0xFF0E697C),
                    )
                  : Icon(Icons.person_outline_rounded),
              label: ""),
        ],
      ),
      body: screens[selectedIndex],
    );
  }
}
