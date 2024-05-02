
// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box serviceBox;
//late Box workBox;

ValueNotifier<List<dynamic>>serviceNotifier=ValueNotifier([]);

void addServices(String service){

  serviceNotifier.value.add(service);
  serviceBox.put(service,service);
 
  serviceNotifier.notifyListeners();
}
void updateSercvices(){
  serviceNotifier.value.clear();
serviceNotifier.value.addAll(serviceBox.values);
  
  serviceNotifier.notifyListeners();
}



void deleteServices(int index) {
  
  serviceBox.deleteAt(index);
  updateSercvices();

}





// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';

//  Box? serviceDB;

// ValueNotifier<List<String>>serviceNotifier=ValueNotifier([]);



// Future <void> addServices(String service)async{
//    serviceDB= await Hive.openBox('services');

//    serviceNotifier.value.add(service);
//   serviceDB?.put('services', serviceNotifier.value);
//      serviceNotifier.notifyListeners();
// }
