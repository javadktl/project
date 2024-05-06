import 'package:flutter/material.dart';
import 'package:work_force/db/functions/work_functions/work_function.dart';
import 'package:work_force/db/model/addwork_model.dart';
import 'package:work_force/globalfuntion/variables.dart';
import 'package:work_force/screens/settings_/settings_screen.dart';


class RevenuePage extends StatefulWidget {
  const RevenuePage({super.key});

  @override
  State<RevenuePage> createState() => _RevenuePageState();
}

class _RevenuePageState extends State<RevenuePage> {
  DateTime? fromDate; // Variable to store the selected start date
  DateTime? toDate; // Variable to store the selected end date

  @override
  void initState() {
    super.initState();
    getAllWork();
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
            ),
          )
        ],
        title: Text(
          'Revenue',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ExpansionTile(
              title: Text('Date Range Overview'),
              children: [
                ListTile(
                  title: Text('From date'),
                  subtitle: Text(fromDate?.toString() ?? 'Select start date'),
                  trailing: IconButton(
                    onPressed: selectStartDate,
                    icon: Icon(Icons.calendar_today),
                  ),
                ),
                ListTile(),
                ListTile(
                  title: Text('To date'),
                  subtitle: Text(toDate?.toString() ?? 'Select end date'),
                  trailing: IconButton(
                    onPressed: selectEndDate,
                    icon: Icon(Icons.calendar_today),
                  ),
                ),
                ElevatedButton(
                  onPressed: filterByDateRange,
                  child: Text('Apply Filter'),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: smallestHeight * 0.1),
                  Text(
                    '   Total Revenue:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    '  ₹5000.00',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: worklistNotifier,
                builder: (BuildContext ctx, List<WorkModel> worklist, Widget? child) {
                  // Filter the list of WorkModel based on the selected date range
                  List<WorkModel> filteredData = worklist.where((work) {
                    if (fromDate == null || toDate == null) return true; // No filter applied
                    DateTime workDate = DateTime.parse(work.date); // Assuming date format is "yyyy-MM-dd"
                    return workDate.isAfter(fromDate!) && workDate.isBefore(toDate!);
                  }).toList();
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      WorkModel workdata = filteredData[index];
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: tileColor,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 4,
                                blurRadius: .2,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    workdata.name,
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    workdata.date,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Text(
                                '₹${int.parse(workdata.day) * int.parse(workdata.amount)}',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: filteredData.length,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void selectStartDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        fromDate = selectedDate;
      });
    }
  }

  void selectEndDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        toDate = selectedDate;
      });
    }
  }

  void filterByDateRange() {
    // Perform any specific actions when applying the date range filter
    // For example, you can update the UI or trigger a data fetch
  }
}