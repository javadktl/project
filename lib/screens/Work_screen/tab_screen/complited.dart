import 'package:flutter/material.dart';
import 'package:work_force/db/functions/work_functions/work_function.dart';
import 'package:work_force/db/model/addwork_model.dart';
import 'package:work_force/globalfuntion/variables.dart';
import 'package:work_force/screens/Work_screen/work_detaile_view.dart';

class Work_Complete extends StatefulWidget {
  const Work_Complete({Key? key}) : super(key: key);

  @override
  State<Work_Complete> createState() => _Work_CompleteState();
}

class _Work_CompleteState extends State<Work_Complete> {
  bool sortByDateAscending = true;
  String keyword = '';
  @override
  Widget build(BuildContext context) {
    mediaqQueryHightAndWidth(context);
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
                      return ['Sort by A to Z ⬇', 'Sort by Z to A ⬆']
                          .map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                    onSelected: (String choice) {
                      setState(() {
                        sortByDateAscending = choice == 'Sort by A to Z ⬇';
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
                  //This condition for ListTile appearing when icon condition is true.
                  List<WorkModel> data = worklist
                      .where((element) => element.workstatus == true)
                      .toList();
                        //Filtering based on name
                  List<WorkModel> filteredWorkList = worklist.where((work) {
                    String name = work.name.toLowerCase();
                    return name.contains(keyword);
                  }).toList();

                  // Sorting logic based on name
                  filteredWorkList.sort((a, b) {
                    int comparison = sortByDateAscending
                        ? a.name.compareTo(b.name)
                        : b.name.compareTo(a.name);
                    return comparison;
                  });
                  
                  if (filteredWorkList.isEmpty) {
            return Center(
              child: Text('No data available for the given search query'),
            );
          }
          if (data.isEmpty) {
            return Center(
              child: Text('No data available'),
            );
          }
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final workdata = filteredWorkList[index];
                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    WorkDetaileView(workdetails: workdata))),
                        child: Container(
                          height: smallestHeight * 1.1,
                        width: screenWidth,
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
                            color: tileColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
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
                                  // SizedBox(height: 8.0),
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '₹${int.parse(workdata.day) * int.parse(workdata.amount)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    workdata.worklist,
                                    style: TextStyle(color: Colors.white70),
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
            )
          ],
        ),
      ),
    );
  }
}

