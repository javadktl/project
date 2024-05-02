import 'package:flutter/material.dart';
import 'package:work_force/db/functions/work_functions/work_function.dart';
import 'package:work_force/db/model/addwork_model.dart';
import 'package:work_force/globalfuntion/variables.dart';

class Work_Pending extends StatefulWidget {
  const Work_Pending({Key? key}) : super(key: key);

  @override
  State<Work_Pending> createState() => _Work_PendingState();
}

class _Work_PendingState extends State<Work_Pending> {
  String keyword = '';
  bool sortByDateAscending = true;
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Scaffold(
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
                          keyword = value.toLowerCase();
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
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: worklistNotifier,
                builder: (BuildContext ctx, List<WorkModel> worklist,
                    Widget? child) {
                  List<WorkModel> filteredWorkList = worklist.where((staff) {
                    String name = staff.name.toLowerCase();
                    return name.contains(keyword);
                  }).toList();
                  


                  filteredWorkList.sort((a, b) {
                    int comparison = sortByDateAscending
                        ? a.name.compareTo(b.name)
                        : b.name.compareTo(a.name);
                    return comparison;
                  });
                  List<WorkModel> data = filteredWorkList.where((work) {
                    DateTime workDate = DateTime.parse(
                        work.date); 
                    return workDate.isBefore(
                        now); 
                  }).toList();

                  if (data.isEmpty) {
                    return Center(
                      child: Text('No data av,,,ailable'),
                    );
                  } ;

                  if (filteredWorkList.isEmpty) {
                    return Center(
                      child:
                          Text('No data available for the given search query'),
                    );
                  }
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      WorkModel workdata = data[index];

                      if (workdata.workstatus) {
                        return SizedBox
                            .shrink(); 
                      }
                      
                      return Container(  height: smallestHeight * 1.1,
                        width: screenWidth,
                        decoration: BoxDecoration(
                        
                            color: tileColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 4,
                                blurRadius: .2,
                                offset: Offset(0, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20.0)),
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    workdata.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: headingcolor),
                                  ),
                                  Text(
                                    workdata.apartment,
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  Text(
                                    workdata.date,
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '₹${int.parse(workdata.day) * int.parse(workdata.amount)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(workdata.worklist,
                                      style: TextStyle(color: Colors.white70)),
                                  InkWell(
                                    splashColor: Colors.red,
                                    onTap: () {
                                      setState(() {
                                        data[index].workstatus =
                                            !data[index].workstatus;
                                      });
                                      editWork(data[index]);
                                    },
                                    child: Icon(
                                      Icons.check_circle_rounded,
                                      color: data[index].workstatus
                                          ? Colors.green
                                          : Color.fromARGB(255, 180, 49, 40),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: data.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}











// import 'package:flutter/material.dart';
// import 'package:work_force/db/functions/work_functions/work_function.dart';
// import 'package:work_force/db/model/addwork_model.dart';

// class Work_Pending extends StatefulWidget {
//   const Work_Pending({Key? key}) : super(key: key);

//   @override
//   State<Work_Pending> createState() => _Work_PendingState();
// }

// class _Work_PendingState extends State<Work_Pending> {
//   @override
//   Widget build(BuildContext context) {
//     DateTime now = DateTime.now(); // Define now as the current date and time
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ValueListenableBuilder(
//                 valueListenable: worklistNotifier,
//                 builder: (BuildContext ctx, List<WorkModel> worklist, Widget? child) {
//                   List<WorkModel> data = worklist
//                       .where((work) {
//                         DateTime workDate = DateTime.parse(work.date); // Convert date string to DateTime
//                         return workDate.isBefore(now); // Filter out work whose date has not passed
//                       })
//                       .toList();
//                   return ListView.builder(
//                     itemBuilder: (context, index) {
//                       WorkModel workdata = data[index];
//                        if (workdata.workstatus) {
//                         return SizedBox.shrink(); // If workstatus is true, return an empty SizedBox to hide the ListTile
//                       }
//                       return Container(
//                         margin: EdgeInsets.symmetric(vertical: 5.0),
//                         child: ListTile(
//                           title: Text(
//                             workdata.name,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Color.fromARGB(255, 149, 28, 19),
//                             ),
//                           ),
//                           tileColor: Color.fromARGB(255, 194, 194, 193),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('villa 21'),
//                               Text('25/06/2024'),
//                             ],
//                           ),
//                           trailing: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text('Plumping'),
//                               Text('₹700'),
//                               InkWell(
//                                 splashColor: Colors.red,
//                                 onTap: () {
//                                   setState(() {
//                                     data[index].workstatus = !data[index].workstatus;
//                                   });
//                                   editWork(data[index]);
//                                 },
//                                 child: Icon(
//                                   Icons.check_circle_rounded,
//                                   color: data[index].workstatus ? Colors.green : Colors.red,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     itemCount: data.length,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }