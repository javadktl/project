import 'package:flutter/material.dart';
import 'package:work_force/screens/Work_screen/work_tabbar.dart';
import 'package:work_force/screens/revenue/revenue_screen.dart';

import 'package:work_force/screens/home_screen/home_screen.dart';


import 'package:work_force/screens/staff_screen/staff_screen.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentindex = 0;
  final pages = [
    HomeScreen(),
    Staffscreen(),
   
   WorkTab(),
    RevenuePage(),
    
  ];
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color.fromARGB(255, 254, 254, 254),
          backgroundColor: const Color.fromARGB(255, 72, 68, 65),
          type: BottomNavigationBarType.fixed,
          currentIndex: currentindex,
          onTap: (newstate) {
            setState(() {
              currentindex = newstate;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Staff'),
            BottomNavigationBarItem(icon: Icon(Icons.library_books_sharp), label: 'Work'),
            BottomNavigationBarItem(icon: Icon(Icons.event_available), label: 'Revenue'),
           
          ]),
      body: pages[currentindex],
    );
  }
}
