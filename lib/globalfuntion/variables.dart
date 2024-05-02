import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
var dheight;
var dwidth;
const Color primaryGray = Color.fromARGB(255, 72, 68, 65);
const Color tileColor = Color.fromARGB(184, 63, 77, 52);
const Color headingcolor = Colors.white;
//Color.fromARGB(255, 149, 28, 19);

double screenHeight = 0.0;
double screenWidth = 0.0;
double smallestHeight = 0.0;
double smallestWidth = 0.0;


void mediaqQueryHightAndWidth(BuildContext context){
final mediaQuery = MediaQuery.of(context);
screenHeight = mediaQuery.size.height;
screenWidth = mediaQuery.size.width;
smallestHeight = screenHeight * 0.1;
smallestWidth = screenWidth * 0.1 ; 
}


