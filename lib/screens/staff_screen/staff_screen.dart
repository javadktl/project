// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:work_force/db/functions/db_functions.dart';
// import 'package:work_force/db/model/data_model.dart';
// import 'package:work_force/globalfuntion/variables.dart';
// import 'package:work_force/screens/detail_view_page/staff_detail_view.dart';
// import 'package:work_force/screens/edit_screens/staff_edit_screen.dart';
// import 'package:work_force/screens/settings_/settings_screen.dart';
// import 'package:work_force/screens/staff_screen/addstaff.dart';

// class Staffscreen extends StatefulWidget {
//   const Staffscreen({Key? key}) : super(key: key);

//   @override
//   State<Staffscreen> createState() => _StaffscreenState();
// }

// class _StaffscreenState extends State<Staffscreen> {
//   List<StaffModel> finduser = [];
//   bool sortByDateAscending = true;
//   String keyword2 = '';

//   @override
//   void initState() {
//     super.initState();
//     finduser = staffListNotifier.value;
//   }

//   @override
//   Widget build(BuildContext context) {
//     mediaqQueryHightAndWidth(context);
//     gettAllStaff();
//     return Scaffold(
//       appBar: AppBar(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
//         foregroundColor: Colors.white,
//         backgroundColor: Color.fromARGB(255, 72, 68, 65),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(builder: (context) => SetingsScreen()),
//               );
//             },
//             icon: Icon(Icons.settings),
//           )
//         ],
//         title: Text(
//           'Staff Details',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             SizedBox(
//               height: smallestHeight * 0.5,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       onChanged: (value) {
//                         setState(() {
//                           keyword2 = value.toLowerCase();
//                         });
//                       },
//                       decoration: InputDecoration(
//                         isDense: true,
//                         contentPadding: EdgeInsets.symmetric(
//                             vertical: 7.0, horizontal: 15.0),
//                         suffixIcon: Icon(Icons.search),
//                         hintText: 'Search Name/Position',
//                         hintStyle: TextStyle(
//                             fontWeight: FontWeight.w300, fontSize: 13),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(20)),
//                         ),
//                       ),
//                     ),
//                   ),
//                   PopupMenuButton<String>(
//                     icon: Icon(Icons.sort),
//                     itemBuilder: (BuildContext context) {
//                       return ['Sort by A to Z ⬆', 'Sort by Z to A ⬇']
//                           .map((String choice) {
//                         return PopupMenuItem<String>(
//                           value: choice,
//                           child: Text(choice),
//                         );
//                       }).toList();
//                     },
//                     onSelected: (String choice) {
//                       setState(() {
//                         sortByDateAscending = choice == 'Sort by A to Z ⬆';
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: smallestHeight * 0.1),
//             buildStaffList(context),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         mini: true,
//         onPressed: () {
//           Navigator.of(context)
//               .push(MaterialPageRoute(builder: (context) => AddStaff()));
//         },
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//         backgroundColor: primaryGray,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     );
//   }
// // ==============================================================================================================================

// Widget buildStaffList(BuildContext context) {
//   return Expanded(
//     child: FutureBuilder(
//       future: getAllStaffs(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasData) {
//           final List<StaffModel> data = List<StaffModel>.from(snapshot.data!);

//           // Apply search filter
//           List<StaffModel> filteredList = data.where((staff) {
//             return staff.name.toLowerCase().contains(keyword2) ||
//                    staff.position.toLowerCase().contains(keyword2);
//           }).toList();

//           // Apply sorting
//           if (sortByDateAscending) {
//             filteredList.sort((a, b) => a.name.compareTo(b.name));
//           } else {
//             filteredList.sort((a, b) => b.name.compareTo(a.name));
//           }
          
//           if (filteredList.isEmpty) {
//             return Center(
//               child: Text('No data available for the given search query'),
//             );
//           } else {
//             return buildStaffListView(filteredList, context); // Pass filtered and sorted data
//           }
//         } else {
//           return Center(
//             child: Text('No data found'),
//           );
//         }
//       },
//     ),
//   );
// }


// Widget buildStaffListView(List<StaffModel> staffList, BuildContext context) {
//   return ListView.builder(
//     itemCount: staffList.length,
//     itemBuilder: (ctx, index) {
//       final data = staffList[index];
//       return GestureDetector(
//         onTap: () {
//           Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => StaffDetails(staffdetail: data),
//           ));
//         },
//         child: buildStaffTile(data),
//       );
//     },
//   );
// }

//   Widget buildStaffTile(StaffModel data) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8.0),
//       padding: EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 4,
//             blurRadius: .2,
//             offset: Offset(0, 4),
//           ),
//         ],
//         borderRadius: BorderRadius.circular(20.0),
//         color: tileColor,
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 30,
//             backgroundImage: FileImage(File(data.proimage)),
//           ),
//           SizedBox(width: smallestWidth * 0.3),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 data.name,
//                 style:
//                     TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               Text(
//                 data.position,
//                 style: TextStyle(color: Colors.white70),
//               ),
//             ],
//           ),
//           Expanded(child: SizedBox()),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => EditStaff(editstaf: data),
//                   ));
//                 },
//                 icon: Icon(Icons.edit),
//                 color: Color.fromARGB(255, 6, 73, 129),
//                 iconSize: 20,
//               ),
//               IconButton(
//                 onPressed: () {
//                   deletestaff(context, data);
//                 },
//                 icon: Icon(Icons.delete),
//                 color: Color.fromARGB(255, 180, 49, 40),
//                 iconSize: 20,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void deletestaff(context, StaffModel data) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Delete'),
//           content: const Text('Do You Want delete?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 deliteStaff(data.idDB!);
//                 Navigator.pop(context);
//               },
//               child: const Text('Yes'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('No'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }









import 'dart:io';
import 'package:flutter/material.dart';
import 'package:work_force/db/functions/db_functions.dart';
import 'package:work_force/db/model/data_model.dart';
import 'package:work_force/globalfuntion/variables.dart';
import 'package:work_force/screens/detail_view_page/staff_detail_view.dart';
import 'package:work_force/screens/edit_screens/staff_edit_screen.dart';
import 'package:work_force/screens/settings_/settings_screen.dart';
import 'package:work_force/screens/staff_screen/addstaff.dart';

class Staffscreen extends StatefulWidget {
  const Staffscreen({Key? key}) : super(key: key);

  @override
  State<Staffscreen> createState() => _StaffscreenState();
}

class _StaffscreenState extends State<Staffscreen> {
  List<StaffModel> finduser = [];
  bool sortByDateAscending = true;
  String keyword2 = '';

  @override
  void initState() {
    super.initState();
    finduser = staffListNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    mediaqQueryHightAndWidth(context);
    gettAllStaff();
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 72, 68, 65),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SetingsScreen()),
              );
            },
            icon: Icon(Icons.settings),
          )
        ],
        title: Text(
          'Staff Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: smallestHeight * 0.5,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          keyword2 = value.toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 15.0),
                        suffixIcon: Icon(Icons.search),
                        hintText: 'Search Name/Position',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 13),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.sort),
                    itemBuilder: (BuildContext context) {
                      return ['Sort by A to Z ⬆', 'Sort by Z to A ⬇']
                          .map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                    onSelected: (String choice) {
                      setState(() {
                        sortByDateAscending = choice == 'Sort by A to Z ⬆';
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: smallestHeight * 0.1),
            buildStaffList(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddStaff()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: primaryGray,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
// ==============================================================================================================================

  Widget buildStaffList(BuildContext context) {
    
    return Expanded(
      child: ValueListenableBuilder(
        key: ValueKey(finduser),
        valueListenable: staffListNotifier,
        builder: (BuildContext ctx, List<StaffModel> staffList, Widget? child) {
          List<StaffModel> filteredStaffList = staffList.where((staff) {
            String name = staff.name.toLowerCase();
            return name.contains(keyword2);
          }).toList();

          // Sorting logic based on name
          filteredStaffList.sort((a, b) {
            int comparison = sortByDateAscending
                ? a.name.compareTo(b.name)
                : b.name.compareTo(a.name);
            return comparison;
          });
          if (filteredStaffList.isEmpty) {
            return Center(
              child: Text('No data available for the given search query'),
            );
          }
          if (staffList.isEmpty) {
            return Center(
              child: Text('No data available'),
            );
          }
          return buildStaffListView(filteredStaffList, context);
        },
      ),
    );
  }

  Widget buildStaffListView(
      List<StaffModel> filteredStaffList, BuildContext context) {
    return ListView.builder(
      itemCount: filteredStaffList.length,
      itemBuilder: (ctx, index) {
        final data = filteredStaffList[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => StaffDetails(staffdetail: data),
            ));
          },
          child: buildStaffTile(data),
        );
      },
    );
  }

  Widget buildStaffTile(StaffModel data) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: .2,
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(20.0),
        color: tileColor,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: FileImage(File(data.proimage)),
          ),
          SizedBox(width: smallestWidth * 0.3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                data.position,
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditStaff(editstaf: data),
                  ));
                },
                icon: Icon(Icons.edit),
                color: Color.fromARGB(255, 6, 73, 129),
                iconSize: 20,
              ),
              IconButton(
                onPressed: () {
                  deletestaff(context, data);
                },
                icon: Icon(Icons.delete),
                color: Color.fromARGB(255, 180, 49, 40),
                iconSize: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void deletestaff(context, StaffModel data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Do You Want delete?'),
          actions: [
            TextButton(
              onPressed: () {
                deliteStaff(data.idDB!);
                Navigator.pop(context);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}






















// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:work_force/db/functions/db_functions.dart';
// import 'package:work_force/db/model/data_model.dart';
// import 'package:work_force/globalfuntion/variables.dart';
// import 'package:work_force/screens/detail_view_page/staff_detail_view.dart';
// import 'package:work_force/screens/edit_screens/staff_edit_screen.dart';
// import 'package:work_force/screens/settings_/settings_screen.dart';
// import 'package:work_force/screens/staff_screen/addstaff.dart';

// class Staffscreen extends StatefulWidget {
//   const Staffscreen({Key? key}) : super(key: key);

//   @override
//   State<Staffscreen> createState() => _StaffscreenState();
// }

// class _StaffscreenState extends State<Staffscreen> {
//   List<StaffModel> finduser = [];
//   String keyword2 = '';

//   @override
//   void initState() {
//     super.initState();
//     finduser = staffListNotifier.value;
//   }

//   @override
//   Widget build(BuildContext context) {
//     gettAllStaff();
//     return Scaffold(
//       appBar: AppBar(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
//         foregroundColor: Colors.white,
//         backgroundColor: Color.fromARGB(255, 72, 68, 65),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(builder: (context) => SetingsScreen()),
//               );
//             },
//             icon: Icon(Icons.settings),
//           )
//         ],
//         title: Text(
//           'Staff Details',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             SizedBox(height :40,
//               child: TextField(
//                 onChanged: (value) {
//                   setState(() {
//                     keyword2 = value.toLowerCase();
//                   });
//                 },
//                 decoration: InputDecoration(
//                   isDense: true,
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 7.0, horizontal: 15.0),
//                   suffixIcon: Icon(Icons.search),
//                   hintText: 'Search Name/Position',hintStyle: TextStyle(fontWeight: FontWeight.w300,fontSize: 13),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 2),
//             Expanded(
//               child: ValueListenableBuilder(
//                 key: ValueKey(finduser),
//                 valueListenable: staffListNotifier,
//                 builder: (BuildContext ctx, List<StaffModel> staffList,
//                     Widget? child) {
//                   if (staffList.isEmpty) {
//                     return Center(
//                       child: Text('No data available'),
//                     );
//                   }

//                   List<StaffModel> filteredStaffList = staffList.where((staff) {
//                     String name = staff.name.toLowerCase();
//                     String position = staff.position.toLowerCase();
//                     return name.contains(keyword2) ||
//                         position.contains(keyword2);
//                   }).toList();
//                   if (filteredStaffList.isEmpty) {
//                     return Center(
//                       child:
//                           Text('No data available for the given search query'),
//                     );
//                   }

//                   return ListView.builder(
//                     itemCount: filteredStaffList.length,
//                     itemBuilder: (ctx, index) {
//                       final data = filteredStaffList[index];

//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) =>
//                                 StaffDetails(staffdetail: data),
//                           ));
//                         },
//                         child: Container(
//                           margin: EdgeInsets.symmetric(vertical: 8.0),
//                           padding: EdgeInsets.all(8.0),
//                           decoration: BoxDecoration(
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   spreadRadius: 4,
//                                   blurRadius: .2,
//                                   offset: Offset(0, 4),
//                                 ),
//                               ],
//                               borderRadius: BorderRadius.circular(20.0),
//                               color: tileColor),
//                           child: Row(
//                             children: [
//                               CircleAvatar(
//                                 radius: 30,
//                                 backgroundImage: FileImage(File(data.proimage)),
//                               ),
//                               SizedBox(width: 10),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     data.name,
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white),
//                                   ),
//                                   Text(
//                                     data.position,
//                                     style: TextStyle(color: Colors.white70),
//                                   ),
//                                 ],
//                               ),
//                               Expanded(child: SizedBox()),
//                               Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   IconButton(
//                                     onPressed: () {
//                                       Navigator.of(context)
//                                           .push(MaterialPageRoute(
//                                         builder: (context) =>
//                                             EditStaff(editstaf: data),
//                                       ));
//                                     },
//                                     icon: Icon(Icons.edit),
//                                     color: Color.fromARGB(255, 6, 73, 129),
//                                     iconSize: 20,
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       deletestaff(context, data);
//                                     },
//                                     icon: Icon(Icons.delete),
//                                     color: Color.fromARGB(255, 180, 49, 40),
//                                     iconSize: 20,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         mini: true,
//         onPressed: () {
//           Navigator.of(context)
//               .push(MaterialPageRoute(builder: (context) => AddStaff()));
//         },
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//         backgroundColor: primaryBlue,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     );
//   }

//   void deletestaff(context, StaffModel data) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Delete'),
//           content: const Text('Do You Want delete?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 deliteStaff(data.idDB!);
//                 Navigator.pop(context);
//               },
//               child: const Text('Yes'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('No'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

