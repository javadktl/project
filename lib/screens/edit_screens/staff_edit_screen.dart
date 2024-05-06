import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_force/db/functions/db_functions.dart';
import 'package:work_force/db/functions/service/service.dart';
import 'package:work_force/db/model/data_model.dart';
import 'package:work_force/globalfuntion/textformfield.dart';
import 'package:work_force/globalfuntion/variables.dart';
import 'package:work_force/screens/settings_/settings_screen.dart';

class EditStaff extends StatefulWidget {
StaffModel editstaf;
  EditStaff({super.key,required this.editstaf});

  @override
  State<EditStaff> createState() => _EditStaffState();
}

class _EditStaffState extends State<EditStaff> {
  File? imageimg;
  File? imageid;

 late String _proimagepath;
  String? _idimagepath;
  //String? updatedproimage;
 // String? updateidpath;
  String? updategenter;
  String? updateposition;
  final _formkey = GlobalKey<FormState>();
  String __selectedWork ='Electrician';

  List workcatogory = [
    'Cleaner',
    'Plumber',
    'Electrician',
  ];
  late String _selectedGender;
  final _idcontroller = TextEditingController();
  final _namecontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  final _numbercontroller = TextEditingController();
  final _salarycontroller = TextEditingController();

  @override
  void initState() {
   initialise(); 
   
    super.initState();
    workcatogory=[...workcatogory,...serviceNotifier.value];
  }

  @override
  Widget build(BuildContext context) {
    
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
            'Add Staff',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Form(
            key: _formkey,
            child: Align(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Stack(children: [
                        Container(
                          height: 110,
                          width: 160,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(_proimagepath))
                                    
                                        ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              border:
                                  Border.all(color: primaryGray, width: 2.0)),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 2,
                            child: IconButton(
                                onPressed: () {
                                  getimage(ImageSource.gallery);
                                },
                                icon: Icon(Icons.camera_alt)))
                      ])
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Input(
                    label: "ID Number",
                    controller: _idcontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter ID';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Input(
                    label: "Name",
                    controller: _namecontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('    Genter'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ChoiceChip(
                              label: Text('Male'),
                              selected: _selectedGender == 'male',
                              onSelected: (value) =>
                                  setState(() => _selectedGender = 'male'),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 1),
                              selectedColor: primaryGray,
                              checkmarkColor: Colors.white,
                            ),
                            SizedBox(width: 10),
                            ChoiceChip(
                              label: Text('Female'),
                              selected: _selectedGender == 'female',
                              onSelected: (value) =>
                                  setState(() => _selectedGender = 'female'),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 1),
                              selectedColor: primaryGray,
                              checkmarkColor: Colors.white,
                            ),

                            // SizedBox(
                            //   width: 160,
                            // )
                          ],
                        )
                      ]),
                  Input(
                    label: 'Address',
                    controller: _addresscontroller,
                    multiLine: 3,
                    height: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Input(
                    label: 'Phone Number',
                    controller: _numbercontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter mobile noumber';
                      } else if (value.length != 10) {
                        return 'Mobile number should be 10 digits';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Input(
                    label: 'Salary',
                    controller: _salarycontroller,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Please enter Salary';
                    //   }else if (value.length <=6){
                    //     return 'Salary should be lessthan seven digits';
                    //   }
                    //   return null;
                    // },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('    Position'),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            height: 35,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(15)),
                            child: DropdownButton(
                              value: __selectedWork,
                              onChanged: ( newValue) => setState(
                                  () => __selectedWork = newValue!),
                              items: workcatogory
                                  .map<DropdownMenuItem>(
                                      (value) =>
                                          DropdownMenuItem(
                                            value: value,
                                            child: Text('$value'),
                                          ))
                                  .toList(),
                            ),
                            
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Add ID Proof'),
                          ElevatedButton(
                              onPressed: () {idimage(ImageSource.gallery);},
                              child: Row(
                                children: [
                                  Icon(Icons.upload_sharp),
                                  Text('Add file')
                                ],
                              ))
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        editStaffButtonClicked(context);
                      },
                      child: Text('Update'),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(primaryGray),
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.white)),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }




  Future<void> editStaffButtonClicked(mtx) async {
    if (_formkey.currentState!.validate()){
    final _id = _idcontroller.text.trim();
    final _name = _namecontroller.text.trim();
    final _address = _addresscontroller.text.trim();
    final _phonenumber = _numbercontroller.text.trim();
    final _salary = _salarycontroller.text.trim();

   

   

    final _staffData = StaffModel(
      id: _id,
      name: _name,
      genter: _selectedGender,
      address: _address,
      phonenumber: _phonenumber,
      salary: _salary,
      position: __selectedWork,
      proimage: _proimagepath,
      idimage:_idimagepath,
      idDB: widget.editstaf.idDB
    
    );

    //addStaff(_staffData);
    editStaff(_staffData);

 

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Successfully Edited"),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      backgroundColor: Color.fromARGB(255, 8, 5, 98),
      duration: Duration(seconds: 2),
    ));
   Navigator.of(context).pop();
    print('ob kkkkkkkkkkkkkject');
  } else {ScaffoldMessenger.of(mtx).showSnackBar(
        const SnackBar(
          content: Text('Please Fill Entire Field'),
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );}}

     void initialise(){
      _idcontroller.text= widget.editstaf.id;
      _namecontroller.text=widget.editstaf.name;
      _addresscontroller.text=widget.editstaf.address;
      _numbercontroller.text=widget.editstaf.phonenumber;
      _salarycontroller.text=widget.editstaf.salary;
      _proimagepath = widget.editstaf.proimage;
      _idimagepath = widget.editstaf.idimage;
      _selectedGender= widget.editstaf.genter;
      __selectedWork = widget.editstaf.position;

     }






  Future<void> getimage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }
    setState(() {
      imageimg = File(image.path);
      _proimagepath = image.path.toString();
    });
  }
  Future <void> idimage(ImageSource source) async{
    final image = await ImagePicker().pickImage(source:source);
    if (image == null){
      return;
    }
setState(() {
  imageid =File(image.path);
  _idimagepath = image.path.toString();
});
  }
}
