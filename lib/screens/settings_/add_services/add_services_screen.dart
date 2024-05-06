import 'package:flutter/material.dart';

import 'package:work_force/db/functions/service/service.dart';
import 'package:work_force/globalfuntion/variables.dart';

class addSrvices extends StatefulWidget {
  const addSrvices({super.key});

  @override
  State<addSrvices> createState() => _addSrvicesState();
}

class _addSrvicesState extends State<addSrvices> {
  final _servicecontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    updateSercvices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      appBar: AppBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          foregroundColor: Colors.white,
          backgroundColor: primaryGray,
          centerTitle: true,
          title: Text(
            'Add Service',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: ValueListenableBuilder(
          valueListenable: serviceNotifier,
          builder: (context, value, child) {
            if (value.isEmpty) {
              return Center(
                child: Text('No data available'),
              );
            }
            return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${value[index]}'),
                  trailing: IconButton(
                      onPressed: () {
                        deleteServices(index);
                      },
                      icon: Icon(Icons.remove_circle_outline)),
                );
              },
              itemCount: value.length,
              separatorBuilder: (context, index) => Divider(),
            );
          }),
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
        return AlertDialog(
          title: Text('Enter Service Name'),
          content: TextFormField(
            controller: _servicecontroller,
            decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0))),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_servicecontroller.text.trim().isNotEmpty) {
                  addServices(_servicecontroller.text.trim());
                }

                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
