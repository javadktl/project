

// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
late Box workBox;

ValueNotifier<List<dynamic>>workNotifier=ValueNotifier([]);


void addWorkService(String work){

  workNotifier.value.add(work);
  workBox.put(work, work);
  workNotifier.notifyListeners();
}


void updateSercvice(){
  workNotifier.value.clear();
  workNotifier.value.addAll(workBox.values);
  
  workNotifier.notifyListeners();
}

void deleteService(int index){
  workBox.deleteAt(index);
  updateSercvice();
}






// void deleteService(int index) {
  
//   serviceBox.deleteAt(index);
//   updateSercvices();

// }
