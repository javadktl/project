import 'package:flutter/material.dart';
import 'package:work_force/globalfuntion/variables.dart';
import 'package:work_force/screens/Work_screen/tab_screen/complited.dart';
import 'package:work_force/screens/Work_screen/tab_screen/pending.dart';
import 'package:work_force/screens/Work_screen/tab_screen/all_work.dart';
import 'package:work_force/screens/settings_/settings_screen.dart';

class WorkTab extends StatelessWidget {
  const WorkTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        animationDuration: Durations.extralong1,
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            foregroundColor: Colors.white,
            backgroundColor: primaryGray,
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SetingsScreen()));
                  },
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ))
            ],
            title: Text(
              'Work Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'All Works ',
                ),
                Tab(
                  text: 'Pending',
                ),
                Tab(
                  text: 'Completed',
                )
              ],
              labelColor: Color.fromARGB(255, 165, 45, 37),
              unselectedLabelColor: Colors.white,
            ),
          ),
          body: TabBarView(children: [
            //Work_UpComing(),
            WorkScreenPage(),
            Work_Pending(), Work_Complete()
          ]),
        ));
  }
}
