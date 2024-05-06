
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:work_force/db/functions/work_functions/work_function.dart';
import 'package:work_force/db/model/addwork_model.dart';
import 'package:work_force/globalfuntion/variables.dart';
import 'package:work_force/screens/Work_screen/addwork.dart';
import 'package:work_force/screens/Work_screen/edit_work_screen.dart';
import 'package:work_force/screens/Work_screen/work_detaile_view.dart';

class WorkScreenPage extends StatefulWidget {
  @override
  State<WorkScreenPage> createState() => _WorkScreenPageState();
}

class _WorkScreenPageState extends State<WorkScreenPage> {
  int selectedIndex = 0;
  String keyword = '';
  bool sortByDateAscending = true;

  @override
  Widget build(BuildContext context) {
    getAllWork();
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
                      onChanged: (value) => setState(() {
                        keyword = value.toLowerCase();
                      }),
                      decoration: InputDecoration(
                        hintText: 'Search Name/Apartment',
                        hintStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
                      suffixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(icon: Icon(Icons.sort),
                    itemBuilder: (BuildContext context) {
                      return ['Sort by Date ⬆', 'Sort by Date ⬇'].map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                    onSelected: (String choice) {
                      setState(() {
                        sortByDateAscending = choice == 'Sort by Date ⬆';
                        
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: smallestHeight * 0.1,
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: worklistNotifier,
                builder: (BuildContext ctx, List<WorkModel> worklist, Widget? child) {
                  List<WorkModel> filteredWorkList = _filterWorkList(worklist);
                  return _buildWorkListView(filteredWorkList);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () async {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddworkScreen()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: primaryGray,
      ),
    );
  }
//-----------------------------------------------------------------------------------------------------------------------------------











  List<WorkModel> _filterWorkList(List<WorkModel> worklist) {
    return worklist.where((work) {
      String name = work.name.toLowerCase();
      String location = work.location.toLowerCase();
      return name.contains(keyword) || location.contains(keyword);
    }).toList();
  }

  Widget _buildWorkListView(List<WorkModel> filteredWorkList) {
    if (filteredWorkList.isEmpty) {
      return Center(
        child: Text('No data available for the given search query'),
      );
    }
    filteredWorkList.sort((a, b) {
      DateTime dateA = DateTime.parse(a.date);
      DateTime dateB = DateTime.parse(b.date);
      return sortByDateAscending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
    });

    return ListView.separated(
      itemBuilder: (context, index) {
        WorkModel workdata = filteredWorkList[index];
        return _buildSlidableWorkItem(workdata);
      },
      itemCount: filteredWorkList.length,
      separatorBuilder: (context, index) => SizedBox(height: smallestHeight * 0.1),
    );
  }

  Widget _buildSlidableWorkItem(WorkModel workdata) {
    return Slidable(
      startActionPane: ActionPane(motion: BehindMotion(), children: [
        SlidableAction(
          icon: Icons.edit,
          onPressed: (context) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => WorkEditScreen(editwork: workdata)));
          },
          backgroundColor: Colors.green,
        ),
      ]),
      endActionPane: ActionPane(motion: DrawerMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            deliteWork(workdata.id!);
          },
          icon: Icons.delete,
          backgroundColor: Colors.red,
        )
      ]),
      child: _buildWorkItem(workdata),
    );
  }

  Widget _buildWorkItem(WorkModel workdata) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => WorkDetaileView(workdetails: workdata))),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2.0),
        padding: EdgeInsets.all(10),
        height: smallestHeight * 1.2,
        width: screenWidth,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: .2,
              offset: Offset(0, 6),
            ),
          ],
          color: tileColor,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildWorkInfoColumn(workdata),
            _buildPaymentColumn(workdata),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkInfoColumn(WorkModel workdata) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          workdata.name,
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontSize: 16),
        ),
        Text(
          workdata.apartment,
          style: TextStyle(color: Colors.white70),
        ),
        Text(
          workdata.date,
          style: TextStyle(fontSize: 11, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildPaymentColumn(WorkModel workdata) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '₹${int.parse(workdata.day) * int.parse(workdata.amount)}',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        InkWell(
          splashColor: Colors.red,
          onTap: () {
            setState(() {
              workdata.workstatus = !workdata.workstatus;
            });
            editWork(workdata);
          },
          child: Icon(
            Icons.check_circle_rounded,
            color: workdata.workstatus ? Colors.green : Color.fromARGB(255, 180, 49, 40),
          ),
        ),
      ],
    );
  }
  
}
