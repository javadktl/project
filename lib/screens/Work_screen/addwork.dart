import 'package:flutter/material.dart';
import 'package:work_force/db/functions/db_functions.dart';
import 'package:work_force/db/functions/service/workservice.dart';
import 'package:work_force/db/functions/work_functions/work_function.dart';
import 'package:work_force/db/model/addwork_model.dart';
import 'package:work_force/globalfuntion/textformfield.dart';
import 'package:work_force/globalfuntion/variables.dart';
import 'package:work_force/screens/settings_/settings_screen.dart';

class AddworkScreen extends StatefulWidget {
  const AddworkScreen({
    super.key,
  });

  @override
  State<AddworkScreen> createState() => _AddworkScreenState();
}

class _AddworkScreenState extends State<AddworkScreen> {
  final _namecontroller = TextEditingController();
  final _locationcontroller = TextEditingController();
  final _apartmentcontroller = TextEditingController();
  final _remarkscontroller = TextEditingController();
  final _phonenumbercontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  final _daycontroller = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  String _selectedwork = 'Electric';
  String? _selectedstaff;

  List<String> staffname = [
    // 'item1',
    // 'item2',
    // 'item3',
  ];

  List  work = [
    'Electric',
    'Plumbing',
    'Cleanig',
  ];
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    initList();
    super.initState();
    work=[...work,...workNotifier.value];
  }

  @override
  Widget build(BuildContext context) {
    mediaqQueryHightAndWidth(context);
    return Scaffold(
      appBar: AppBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
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
            'Add Work',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Form(
            key: _formkey,
            child: Column(
              children: [
                Text('Select Work'),
                Container(
                  width: double.infinity,
                  child: DropdownButton(
                    isExpanded: true,
                    value: _selectedwork,
                    onChanged: (newValue) =>
                        setState(() => _selectedwork = newValue!),
                    items: work
                        .map<DropdownMenuItem>(
                            (value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    ('$value')
                                  ),
                                ))
                        .toList(),
                  ),
                  
                ),
                Text('Select Staff'),
                Container(
                  width: double.infinity,
                  child: FutureBuilder(
                    future: getAllNameAsync(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        staffname = snapshot.data ?? ['a', 'b', 'c'];
                        if (staffname.length == 0)
                          staffname = ['No employees add employees'];
                        if (_selectedstaff == null)
                          _selectedstaff = staffname[0];

                        return DropdownButton(
                          value: _selectedstaff,
                          isExpanded: true,
                          items: List.generate(
                            staffname.length,
                            (index) => DropdownMenuItem(
                              value: staffname[index],
                              child: Text(
                                staffname[index],
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectedstaff = value;
                            });
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ),
                
                SizedBox(
                  height:smallestHeight * 0.2 ,
                ),
                Input(
                  label: 'Customer Name',
                  controller: _namecontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height:smallestHeight * 0.2 ,
                ),
                Input(
                  label: 'Location',
                  controller: _locationcontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Location';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: smallestHeight * 0.2 ,
                ),
                Input(
                  label: 'Villa/Apartment',
                  controller: _apartmentcontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Fill The Field';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height:smallestHeight * 0.2 ,
                ),
                
                Input(
                  label: 'Phonenumber',
                  controller: _phonenumbercontroller,
                  keyboard: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty)
                      return 'Please Enter Phone number';
                    else if (value.length != 10) {
                      return 'Mobile Number Should Be 10 Digits';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: smallestHeight * 0.2 ,
                ),
                Input(
                  label: 'Date',
                  controller: _dateController,
                  suffixIcon: IconButton(
                      onPressed: () {
                        _selectDate();
                      },
                      icon: Icon(Icons.calendar_month_rounded)),
                  readonly: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Selecte Date';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: smallestHeight * 0.2 ,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text('Amount/day'),
                        SizedBox(
                            width: screenWidth * 0.3,
                            height: smallestHeight * 0.5 ,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _amountcontroller,
                              cursorHeight: 15,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7))),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return;
                                }
                                return null;
                              },
                            )),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Total days'),
                        SizedBox(
                            width: screenWidth * 0.3,
                            height: smallestHeight * 0.5 ,
                            child: TextFormField(keyboardType: TextInputType.number,
                              controller: _daycontroller,
                              cursorHeight: 15,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7))),
                            ))
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: smallestHeight * 0.2 ,
                ),
                Input(label: 'Remarks', controller: _remarkscontroller),
                SizedBox(
                  height: smallestHeight * 0.2 ,
                ),
                SizedBox(
                  width: screenWidth * 0.7 ,
                  child: ElevatedButton(
                    onPressed: () {
                      onAddWorkButtonClicked(context);
                    },
                    child: Text('Add'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(primaryGray),
                        foregroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Future<void> initList() async {
    var data = await getAllNameAsync();
    setState(() {
      if (data != null) {
        print('data reached here $data');
        staffname = data;
      } else {
        print('data is not in here');
      }
      // staffname;
    });
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> onAddWorkButtonClicked(mtx) async {
    if (_formkey.currentState!.validate()) {
      final _name = _namecontroller.text.trim();
      final _location = _locationcontroller.text.trim();
      final _apartment = _apartmentcontroller.text.trim();
      final _phonenumber = _phonenumbercontroller.text.trim();
      final _date = _dateController.text.trim();
      final _amount = _amountcontroller.text.trim();
      final _days = _daycontroller.text.trim();
      final _remark = _remarkscontroller.text.trim();

      final _workdata = WorkModel(
          worklist: _selectedwork,
          stafflist: _selectedstaff!,
          name: _name,
          location: _location,
          apartment: _apartment,
          phonenumber: _phonenumber,
          date: _date,
          day: _days,
          amount: _amount,
          workstatus: false,
          paidstatus: false,
          remarks: _remark);

      addwork(_workdata);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Successfully added"),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ));
    }else{{ScaffoldMessenger.of(mtx).showSnackBar(
        const SnackBar(
          content: Text('Please Fill Entire Field'),
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );}}
  }
}
