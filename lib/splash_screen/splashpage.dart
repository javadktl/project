import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:work_force/db/functions/service/workservice.dart';
import 'package:work_force/globalfuntion/variables.dart';
import 'package:work_force/screens/onbording_screens/pageview.dart';
import 'package:work_force/db/functions/service/service.dart';

class WorkForce extends StatefulWidget {
  const WorkForce({super.key});

  @override
  State<WorkForce> createState() => _WorkForceState();
}

class _WorkForceState extends State<WorkForce> {
  @override
  void initState() {
    goto();
    super.initState();
    //this for addServices
    updateSercvices();
    //this for add work
    updateSercvice();
   // workNotifier.value=List.from(workBox.get('work_services'));
  }
  Widget build(BuildContext context) {
    dheight= MediaQuery.of(context).size.height;
    dwidth= MediaQuery.of(context).size.width;
    
    // var height = MediaQuery.of(context).size.height;
     // var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 161, 208, 239),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: dheight * 7 / 30,
            ),
            const Text(
              'WorkForce',
              style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 239, 63, 63),fontWeight: FontWeight.bold),
            ),SizedBox(height: dheight*7/30,),
          
         Lottie.asset('assets/animations/lotti1.json',height: 150,width: 150)
          ],
          
        ),
      ),
    );
  }

  Future<void> goto() async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Scrool(),
    ));
  }
}
