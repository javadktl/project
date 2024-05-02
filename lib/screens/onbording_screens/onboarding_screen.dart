import 'package:flutter/material.dart';
import 'package:work_force/globalfuntion/variables.dart';


class OnBoardingPage extends StatelessWidget {
  String imagePath;
  String title;
  String description;

  OnBoardingPage({super.key,required this.imagePath,required this.description,required this.title});

  @override
  Widget build(BuildContext context) {
    

     mediaqQueryHightAndWidth(context);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 161, 208, 239),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
              child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.1
              ),
              Image.asset(imagePath),
              SizedBox(
                height: screenHeight * 0.1
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color.fromARGB(255, 56, 41, 41),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,),
              ),
              SizedBox(
                height: smallestHeight * 0.3              ),
              Text(
                  description,
                  textAlign: TextAlign.center,),
              // SizedBox(
              //   height: smallestHeight * 1,
              // ),
            
             ],
          )),
        ));
  }
}
