import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_force/db/functions/db_functions.dart';
import 'package:work_force/db/functions/service/service.dart';
import 'package:work_force/db/model/data_model.dart';
import 'package:work_force/globalfuntion/textformfield.dart';
import 'package:work_force/globalfuntion/variables.dart';

class AddStaff extends StatefulWidget {
  AddStaff({super.key});

  @override
  State<AddStaff> createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
  File? imageimg;
  File? imageid;
  late String _proimagepath;
  String? _idimagepath;
  final _formkey = GlobalKey<FormState>();
  String _selectedWork = 'Cleaner';
  List workcatogory = [
    'Electrician',
    'Plumber',
    'Cleaner',
  ];
  String _selectedGender = 'Male';
  final _idcontroller = TextEditingController();
  final _namecontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  final _numbercontroller = TextEditingController();
  final _salarycontroller = TextEditingController();
  @override
  void initState() {
  
    super.initState();
    workcatogory=[...workcatogory,...serviceNotifier.value];
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
                onPressed: () {},
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
                 buildProfileImageField(),
                  SizedBox(
                    height: smallestHeight * 0.3,
                  ),
                  Input(
                    label: "ID Number",
                    keyboard: TextInputType.number,
                    controller: _idcontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter ID';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: smallestHeight * 0.2
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
                    height:smallestHeight * 0.2
                  ),
                  buildGenderSelection(),
                  SizedBox(
                    height:smallestHeight * 0.1
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text('     Address')),
                  TextFormField(keyboardType: TextInputType.streetAddress,
                    maxLines: 3,
                    cursorHeight: 20,
                    controller: _addresscontroller,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      
                      hintText: 'Enter Address',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(15.0, 7.0, 15.0, 7.0),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: smallestHeight * 0.2),
                  Input(
                    label: 'Phone Number',
                    controller: _numbercontroller,
                    keyboard: TextInputType.phone,
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
                    height: smallestHeight * 0.2,
                  ),
                  Input(
                    keyboard: TextInputType.number,
                    label: 'Salary',
                    controller: _salarycontroller,
                  ),
                  SizedBox(
                    height: smallestHeight * 0.2,
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
                            height: smallestHeight*0.4,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(15)),
                            child: DropdownButton(
                              value: _selectedWork,
                              onChanged: ( newValue) => setState(
                                  () => _selectedWork = newValue!),
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
                              onPressed: () {
                                idimage(ImageSource.gallery);
                              },
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
                    height:smallestHeight * 0.2
                  ),
                  SizedBox( 
                    width:screenWidth * 0.7,
                    child: ElevatedButton(
                      onPressed: () {
                        onAddStaffButtonClicked(context);
                      },
                      child: Text('Add'),
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
//--------------------------------------------------------------------------------------------------------------------------------





  Future<void> onAddStaffButtonClicked(mtx) async {
    if (_formkey.currentState!.validate() && imageimg != null) {
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
        position: _selectedWork,
        proimage: _proimagepath,
        idimage: _idimagepath,
      );

      addStaff(_staffData);

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Successfully added"),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ));

      print('ob kkkkkkkkkkkkkject');
    } else {
      ScaffoldMessenger.of(mtx).showSnackBar(
        const SnackBar(
          content: Text('Please Fill Entire Field'),
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );
    }
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

  Future<void> idimage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }
    setState(() {
      imageid = File(image.path);
      _idimagepath = image.path.toString();
    });
  }



  Widget buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('    Gender'),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ChoiceChip(
              label: const Text('Male'),
              selected: _selectedGender == 'Male',
              onSelected: (value) => setState(() => _selectedGender = 'Male'),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              selectedColor: primaryGray,
              checkmarkColor: Colors.white,
            ),
            const SizedBox(width: 10),
            ChoiceChip(
              label: const Text('Female'),
              selected: _selectedGender == 'Female',
              onSelected: (value) => setState(() => _selectedGender = 'Female'),
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
              selectedColor: primaryGray,
              checkmarkColor: Colors.white,
            ),
          ],
        ),
      ],
    );
  }



   Widget buildProfileImageField() {
    return Stack(
      children: [
        Container(
          height: 110,
          width: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: imageimg != null ? FileImage(imageimg!) : const AssetImage('assets/image/profileimage.png') as ImageProvider,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: primaryGray, width: 2.0),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 2,
          child: IconButton(
            onPressed: () => getimage(ImageSource.gallery),
            icon: const Icon(Icons.camera_alt),
          ),
        )
      ],
    );
  }

}




































 

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:work_force/db/functions/db_functions.dart';
// import 'package:work_force/db/functions/service/service.dart';
// import 'package:work_force/db/model/data_model.dart';
// import 'package:work_force/globalfuntion/textformfield.dart';
// import 'package:work_force/globalfuntion/variables.dart';

// class AddStaff extends StatefulWidget {
//   AddStaff({super.key});

//   @override
//   State<AddStaff> createState() => _AddStaffState();
// }

// class _AddStaffState extends State<AddStaff> {
//   File? imageimg;
//   File? imageid;
//   late String _proimagepath;
//   String? _idimagepath;
//   final _formkey = GlobalKey<FormState>();
//   String _selectedWork = 'Cleaner';
//   List workcatogory = [
//     'Electrician',
//     'Plumber',
//     'Cleaner',
//   ];
//   String _selectedGender = 'Male';
//   final _idcontroller = TextEditingController();
//   final _namecontroller = TextEditingController();
//   final _addresscontroller = TextEditingController();
//   final _numbercontroller = TextEditingController();
//   final _salarycontroller = TextEditingController();
//   @override
//   void initState() {
  
//     super.initState();
//     workcatogory=[...workcatogory,...serviceNotifier.value];
//   }

//   @override
//   Widget build(BuildContext context) {
  
//     return Scaffold(
//       appBar: AppBar(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
//           foregroundColor: Colors.white,
//           backgroundColor: primaryBlue,
//           centerTitle: true,
//           actions: [
//             IconButton(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.settings,
//                   color: Colors.white,
//                 ))
//           ],
//           title: Text(
//             'Add Staff',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           )),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(8),
//         child: Form(
//             key: _formkey,
//             child: Align(
//               child: Column(
//                 children: [
//                   Stack(
//                     children: [
//                       Stack(children: [
//                         Container(
//                           height: 110,
//                           width: 160,
//                           decoration: BoxDecoration(
//                               image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: imageimg != null
//                                       ? FileImage(imageimg!)
//                                       : AssetImage(
//                                               'assets/image/profileimage.png')
//                                           as ImageProvider),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10.0)),
//                               border:
//                                   Border.all(color: primaryBlue, width: 2.0)),
//                         ),
//                         Positioned(
//                             bottom: 0,
//                             right: 2,
//                             child: IconButton(
//                                 onPressed: () {
//                                   getimage(ImageSource.gallery);
//                                 },
//                                 icon: Icon(Icons.camera_alt)))
//                       ])
//                     ],
//                   ),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   Input(
//                     label: "ID Number",
//                     keyboard: TextInputType.number,
//                     controller: _idcontroller,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter ID';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Input(
//                     label: "Name",
//                     controller: _namecontroller,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter Name';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('    Genter'),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             ChoiceChip(
//                               label: Text('Male'),
//                               selected: _selectedGender == 'Male',
//                               onSelected: (value) =>
//                                   setState(() => _selectedGender = 'male'),
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 4, vertical: 1),
//                               selectedColor: primaryBlue,
//                               checkmarkColor: Colors.white,
//                             ),
//                             SizedBox(width: 10),
//                             ChoiceChip(
//                               label: Text('Female'),
//                               selected: _selectedGender == 'Female',
//                               onSelected: (value) =>
//                                   setState(() => _selectedGender = 'Female'),
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 2, vertical: 1),
//                               selectedColor: primaryBlue,
//                               checkmarkColor: Colors.white,
//                             ),

//                             // SizedBox(
//                             //   width: 160,
//                             // )
//                           ],
//                         )
//                       ]),
//                   Align(
//                       alignment: Alignment.topLeft,
//                       child: Text('     Address')),
//                   TextFormField(
//                     maxLines: 3,
//                     cursorHeight: 20,
//                     controller: _addresscontroller,
//                     autovalidateMode: AutovalidateMode.onUserInteraction,
//                     decoration: InputDecoration(
//                       hintText: 'Enter Address',
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                       isDense: true,
//                       contentPadding: EdgeInsets.fromLTRB(15.0, 7.0, 15.0, 7.0),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter Address';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   Input(
//                     label: 'Phone Number',
//                     controller: _numbercontroller,
//                     keyboard: TextInputType.phone,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter mobile noumber';
//                       } else if (value.length != 10) {
//                         return 'Mobile number should be 10 digits';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Input(
//                     keyboard: TextInputType.number,
//                     label: 'Salary',
//                     controller: _salarycontroller,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('    Position'),
//                           Container(
//                             padding: EdgeInsets.only(left: 10),
//                             height: 35,
//                             decoration: BoxDecoration(
//                                 border: Border.all(),
//                                 borderRadius: BorderRadius.circular(15)),
//                             child: DropdownButton(
//                               value: _selectedWork,
//                               onChanged: ( newValue) => setState(
//                                   () => _selectedWork = newValue!),
//                               items: workcatogory
//                                   .map<DropdownMenuItem>(
//                                       (value) =>
//                                           DropdownMenuItem(
//                                             value: value,
//                                             child: Text('$value'),
//                                           ))
//                                   .toList(),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           Text('Add ID Proof'),
//                           ElevatedButton(
//                               onPressed: () {
//                                 idimage(ImageSource.gallery);
//                               },
//                               child: Row(
//                                 children: [
//                                   Icon(Icons.upload_sharp),
//                                   Text('Add file')
//                                 ],
//                               ))
//                         ],
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     width: 300,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         onAddStaffButtonClicked(context);
//                       },
//                       child: Text('Add'),
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStatePropertyAll(primaryBlue),
//                           foregroundColor:
//                               MaterialStatePropertyAll(Colors.white)),
//                     ),
//                   )
//                 ],
//               ),
//             )),
//       ),
//     );
//   }

//   Future<void> onAddStaffButtonClicked(mtx) async {
//     if (_formkey.currentState!.validate() && imageimg != null) {
//       final _id = _idcontroller.text.trim();
//       final _name = _namecontroller.text.trim();
//       final _address = _addresscontroller.text.trim();
//       final _phonenumber = _numbercontroller.text.trim();
//       final _salary = _salarycontroller.text.trim();

//       final _staffData = StaffModel(
//         id: _id,
//         name: _name,
//         genter: _selectedGender,
//         address: _address,
//         phonenumber: _phonenumber,
//         salary: _salary,
//         position: _selectedWork,
//         proimage: _proimagepath,
//         idimage: _idimagepath,
//       );

//       addStaff(_staffData);

//       Navigator.of(context).pop();

//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text("Successfully added"),
//         behavior: SnackBarBehavior.floating,
//         margin: EdgeInsets.all(10),
//         backgroundColor: Colors.green,
//         duration: Duration(seconds: 2),
//       ));

//       print('ob kkkkkkkkkkkkkject');
//     } else {
//       ScaffoldMessenger.of(mtx).showSnackBar(
//         const SnackBar(
//           content: Text('Please Fill Entire Field'),
//           duration: Duration(seconds: 2),
//           margin: EdgeInsets.all(10),
//           behavior: SnackBarBehavior.floating,
//           backgroundColor: Colors.redAccent,
//         ),
//       );
//     }
//   }

//   Future<void> getimage(ImageSource source) async {
//     final image = await ImagePicker().pickImage(source: source);
//     if (image == null) {
//       return;
//     }
//     setState(() {
//       imageimg = File(image.path);
//       _proimagepath = image.path.toString();
//     });
//   }

//   Future<void> idimage(ImageSource source) async {
//     final image = await ImagePicker().pickImage(source: source);
//     if (image == null) {
//       return;
//     }
//     setState(() {
//       imageid = File(image.path);
//       _idimagepath = image.path.toString();
//     });
//   }
// }
