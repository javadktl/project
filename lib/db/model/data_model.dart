import 'package:hive_flutter/hive_flutter.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StaffModel {
  @HiveField(0)
  int? idDB;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String genter;

  @HiveField(4)
  final String address;

  @HiveField(5)
  final String phonenumber;

  @HiveField(6)
  final String salary;

  @HiveField(7)
  final String position;

  @HiveField(8)
  final String proimage;

  @HiveField(9)
  final String? idimage;

 


  StaffModel({
    
    required this.id,
    required this.name,
    required this.genter,
    required this.address,
    required this.phonenumber,
    required this.salary,
    required this.position,
    required this.proimage,
    this.idimage,
    this.idDB,
    
  });
}
