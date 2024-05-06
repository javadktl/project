// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:work_force/db/model/addwork_model.dart';
import 'package:work_force/db/model/data_model.dart';

ValueNotifier<List<WorkModel>> worklistNotifier = ValueNotifier([]);

Future<void> addwork(WorkModel value) async {
  final workDB = await Hive.openBox<WorkModel>('work_db');
  value.id = await workDB.add(value);
  // workDB.put(value.id, value);
  log(value.id.toString());
  worklistNotifier.value.add(value);
  worklistNotifier.notifyListeners();
  print(value.toString());
}



Future<void> getAllWork() async {
  final workDB = await Hive.openBox<WorkModel>('work_db');
  worklistNotifier.value.clear();
  worklistNotifier.value.addAll(workDB.values);
  worklistNotifier.notifyListeners();
}

Future<void> deliteWork(int id) async {
  log(id.toString());
  final workDB = await Hive.openBox<WorkModel>('work_db');
  await workDB.delete(id);
  getAllWork();
}

Future<List<String>> getAllNameAsynctoWork() async {
  final staffDB = await Hive.openBox<StaffModel>('staff_db');
  final List<String> names = staffDB.values.map((staff) => staff.name).toList();
  print("from db $names");
  return names;
}


Future<WorkModel> editWork(WorkModel value) async {
  log(value.id.toString());
  final WorkDB = await Hive.openBox<WorkModel>('work_db');
  await WorkDB.put(value.id, value);
  await getAllWork();
  return value;

}
Future<int>getAllRevenue()async{
  final WorkDB = await Hive.openBox<WorkModel>('work_db');
    var total=0;
    var revenue=WorkDB.values.where((element) => element.paidstatus).toList();
    for(WorkModel i in revenue){
       total=total+(int.parse(i.amount)*int.parse(i.day));
       print(total);
    }

    return total;
}
Future<int>getEstimatedRevenue()async{
  final WorkDB = await Hive.openBox<WorkModel>('work_db');
    var total=0;
    for(WorkModel i in WorkDB.values){
       total=total+(int.parse(i.amount)*int.parse(i.day));
       print(total);
    }

    return total;
}
Future<int>getALlWork([bool completed=true])async{
    final WorkDB = await Hive.openBox<WorkModel>('work_db');
  int completedWork=0;
  int pendingWork=0;
  for(WorkModel i in WorkDB.values){
    if(i.workstatus)completedWork++;
    else pendingWork++;
  }
  if(!completed)return pendingWork;
  return completedWork;
}




