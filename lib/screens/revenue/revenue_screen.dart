import 'package:flutter/material.dart';
import 'package:work_force/db/functions/work_functions/work_function.dart';
import 'package:work_force/db/model/addwork_model.dart';
import 'package:work_force/globalfuntion/variables.dart';
import 'package:work_force/screens/Work_screen/work_detaile_view.dart';
import 'package:work_force/screens/home_screen/home_screen.dart';
import 'package:work_force/screens/settings_/settings_screen.dart';

class RevenuePage extends StatefulWidget {
  const RevenuePage({super.key});

  @override
  State<RevenuePage> createState() => _RevenuePageState();
}

class _RevenuePageState extends State<RevenuePage> {
  DateTime? fromDate;
  DateTime? toDate;

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
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SetingsScreen()),
                  );
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ))
          ],
          title: Text(
            'Revenue',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ExpansionTile(title: Text('Date Range Overview'), children: [
              ListTile(
                title: Text('From date'),
                subtitle: Text(fromDate != null
                    ? '${fromDate!.day}/${fromDate!.month}/${fromDate!.year}'
                    : 'Select start date'),
              ),
              IconButton(
                onPressed: () {
                  selectDateTimeRange();
                },
                icon: Icon(Icons.calendar_month),
                iconSize: 30,
              ),
              ListTile(
                title: Text('To date'),
                subtitle: Text(toDate != null
                    ? '${toDate!.day}/${toDate!.month}/${toDate!.year}'
                    : 'Select end date'),
              ),
            ]),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: smallestHeight * 0.1,
                    ),
                    Text(
                      '   Total Revenue:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      '  ₹$revenue',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: Colors.green),
                    ),
                  ]),
            ),
            Divider(),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: worklistNotifier,
                builder: (BuildContext ctx, List<WorkModel> worklist,
                    Widget? child) {
                  List<WorkModel> data = worklist
                      .where((element) => element.paidstatus == true)
                      .toList();

                  // data=data.where((element) =>DateTime.parse(element.date). ).toList();
                  data = data.where((element) {
                    if (fromDate != null && toDate != null) {
                      return (int.parse(element.date.split('-').toList()[0]) >=
                                  fromDate!.year &&
                              int.parse(element.date.split('-').toList()[1]) >=
                                  fromDate!.month &&
                              int.parse(element.date.split('-').toList()[2]) >=
                                  fromDate!.day) &&
                          (int.parse(element.date.split('-').toList()[0]) <=
                                  toDate!.year &&
                              int.parse(element.date.split('-').toList()[1]) <=
                                  toDate!.month &&
                              int.parse(element.date.split('-').toList()[2]) <=
                                  toDate!.day);
                    }
                    return element.paidstatus;
                  }).toList();

                  return RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 2));
                      getALlWork();
                      setState(() {
                        fromDate = null;
                        toDate = null;
                      });
                    },
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        WorkModel workdata = data[index];
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => WorkDetaileView(
                                        workdetails: data[index]))),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        workdata.name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
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
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: data.length,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void selectDateTimeRange() async {
    final selectedDateRange = await showDateRangePicker(
      context: context,
      saveText: "Select",
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              // primary: MyColors.primary,
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            //.dialogBackgroundColor:Colors.blue[900],
          ),
          child: child!,
        );
      },
    );
    if (selectedDateRange == null) {
      return;
    }

    setState(() {
      fromDate = selectedDateRange.start;
      toDate = selectedDateRange.end;
    });
  }
}
