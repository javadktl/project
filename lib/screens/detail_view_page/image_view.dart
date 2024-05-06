import 'dart:io';

import 'package:flutter/material.dart';

import 'package:work_force/globalfuntion/variables.dart';
import 'package:work_force/screens/settings_/settings_screen.dart';

class ImageView extends StatelessWidget {
  String? ImagePath;
   ImageView({super.key, this.ImagePath});


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            foregroundColor: Colors.white,
            backgroundColor: primaryGray,
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SetingsScreen()),
              );},
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ))
            ],
            title: Text(
              'ID Proof',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: InteractiveViewer(
                      maxScale: 4.0,
                      minScale: 0.5,
                      child: Image.file(
                        File(ImagePath!),
                        
                      ),
                    ),
                  ),),
            ),);
  }
}