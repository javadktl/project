

// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:work_force/db/model/data_model.dart';

ValueNotifier<List<StaffModel>> staffListNotifier = ValueNotifier([]);

Future <void> addStaff(StaffModel value) async{ 
 final staffDB= await Hive.openBox<StaffModel>('staff_db');
 
value.idDB= await staffDB.add(value);
staffDB.put(value.idDB, value);
 staffListNotifier.value.add(value);
 
  staffListNotifier.notifyListeners();
}
Future<List<StaffModel>>getAllStaffs()async{
  final staffDB= await Hive.openBox<StaffModel>('staff_db');
 return staffDB.values.toList();
}
Future <void>gettAllStaff()async{
  
  final staffDB = await Hive.openBox<StaffModel>('staff_db');
  staffListNotifier.value.clear();

  staffListNotifier.value.addAll(staffDB.values);
  staffListNotifier.notifyListeners();
}

Future <void> deliteStaff(int idDB)async{
  final staffDB= await Hive.openBox<StaffModel>('staff_db');
  await staffDB.delete(idDB);
  gettAllStaff();
}

Future <void> editStaff(StaffModel value)async{
 final staffDB= await Hive.openBox<StaffModel>('staff_db');
 await staffDB.put(value.idDB,value);
 gettAllStaff();
 
}

Future<List<String>> getAllNameAsync() async {
  final staffDB = await Hive.openBox<StaffModel>('staff_db');
  final List<String> names = staffDB.values.map((staff) => staff.name).toList();
  print("from db $names");
  return names;
}


Future<int> getCompletedStaffCount() async {
  final staffDB = await Hive.openBox<StaffModel>('staff_db');
  int totalstaf = staffDB.values.length;
  return totalstaf;
}
