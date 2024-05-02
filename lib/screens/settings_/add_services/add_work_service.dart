import 'package:flutter/material.dart';
import 'package:work_force/db/functions/service/workservice.dart';
import 'package:work_force/globalfuntion/variables.dart';

class addWorkSrvices extends StatefulWidget {
  const addWorkSrvices({super.key});

  @override
  State<addWorkSrvices> createState() => _addWorkSrvicesState();
}

class _addWorkSrvicesState extends State<addWorkSrvices> {
  final _workcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      appBar: AppBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          foregroundColor:Colors.white,
          backgroundColor: primaryGray,
          centerTitle: true,
          title: Text(
            'Add Work',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: ValueListenableBuilder(
        valueListenable: workNotifier,
        builder: (context, value, child) { if (value.isEmpty) {
            return Center(
              child: Text('No data available'),
            );
          }   return ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(value[index]),
              trailing: IconButton(
                  onPressed: () {deleteService(index);}, icon: Icon(Icons.remove_circle_outline)),
            );
          },
          itemCount: value.length,
          separatorBuilder: (context, index) => Divider(),
        );}
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          _showAlertDialog();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: primaryGray,
      ),
    );
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return dialog content
        return AlertDialog(iconColor: Colors.amber,
          title: Text('Enter Service Name'),
          content: TextFormField(controller: _workcontroller,
            decoration: InputDecoration(isDense: true,contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0))),
          ),
          actions: [
            TextButton(
              onPressed: () { if(_workcontroller.text.trim().isNotEmpty){addWorkService(_workcontroller.text.trim());} 
                         Navigator.of(context).pop();},
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

