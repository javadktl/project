import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:work_force/db/functions/service/workservice.dart';
import 'package:work_force/db/model/addwork_model.dart';
import 'package:work_force/db/model/data_model.dart';
import 'package:work_force/db/functions/service/service.dart';
import 'package:work_force/splash_screen/splashpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
 serviceBox=await Hive.openBox('services');
 workBox=await Hive.openBox('work_services');
  if (!Hive.isAdapterRegistered(StaffModelAdapter().typeId)) {
    Hive.registerAdapter(StaffModelAdapter());
    Hive.registerAdapter(WorkModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(title: 'WorkForce',
    theme:ThemeData(primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFF4E4D5), ),
      debugShowCheckedModeBanner: false,
      home: WorkForce(),
    );
  }
}
