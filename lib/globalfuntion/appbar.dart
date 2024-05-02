
import 'package:flutter/material.dart';

import 'package:work_force/globalfuntion/variables.dart';

// class costomAppBar extends StatelessWidget {
//   bool settings;
//   String costomtitle;
//    costomAppBar({super.key, required this.costomtitle ,this.settings=true,});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
//           foregroundColor: Colors.white,
//           backgroundColor: primaryBlue,
//           centerTitle: true,
//           actions: settings?[
//             IconButton(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.settings,
//                   color: Colors.white,
//                 ))
//           ]:null,
//           title: Text(
//             costomtitle,
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ));
// }}
 customAppBar({required String title,bool settings=true,}){
  return AppBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          foregroundColor: Colors.white,
          backgroundColor: primaryGray,
          centerTitle: true,
          actions: settings?[
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ))
          ]:null,
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ));
}