import 'package:flutter/material.dart';
import 'package:work_force/screens/settings_/add_services/add_services_screen.dart';
import 'package:work_force/globalfuntion/variables.dart';
import 'package:work_force/screens/settings_/add_services/add_work_service.dart';

class SetingsScreen extends StatefulWidget {
  const SetingsScreen({super.key});

  @override
  State<SetingsScreen> createState() => _SetingsScreenState();
}

class _SetingsScreenState extends State<SetingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          foregroundColor: Colors.white,
          backgroundColor: primaryGray,
          centerTitle: true,
          title: Text(
            'Settings',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              splashColor: Color.fromARGB(31, 73, 15, 15),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => addSrvices())),
              title: Text('Add Services'),
              trailing: Icon(Icons.chevron_right_sharp),
            ),
            Divider(),
            ListTile(
              splashColor: Color.fromARGB(31, 73, 15, 15),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => addWorkSrvices())),
              title: Text('Add Work'),
              trailing: Icon(Icons.chevron_right_sharp),
            ),
            Divider(),
          //   Row(
          //     children: [
          //       ElevatedButton(
          //           onPressed: () {},
          //           child: Row(
          //             children: [
          //               Icon(
          //                 Icons.privacy_tip,
          //                 size: 18,
          //               ),
          //               Text(
          //                 'Privacy Policy',
          //                 style: TextStyle(fontSize: 10),
          //               )
          //             ],
          //           )),ElevatedButton(
          //           onPressed: () {},
          //           child: Row(
          //             children: [
          //               Icon(
          //                 Icons.
          //                 size: 18,
          //               ),
          //               Text(
          //                 'Privacy Policy',
          //                 style: TextStyle(fontSize: 10),
          //               )
          //             ],
          //           ))
          //     ],
          //   )
           ],
        ),
      ),
    );
  }
}
