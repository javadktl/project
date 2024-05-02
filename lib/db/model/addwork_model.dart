import 'package:hive_flutter/hive_flutter.dart';
part 'addwork_model.g.dart';
@HiveType(typeId: 2)
class WorkModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String worklist;

  @HiveField(2)
  final String stafflist;

  @HiveField(3)
  final String name;

  @HiveField(4)
  final String location;

  @HiveField(5)
  final String apartment;

  @HiveField(6)
  final String phonenumber;

  @HiveField(7)
  final String date;

  @HiveField(8)
  final String day;

  @HiveField(9)
  final String amount;

  @HiveField(10)
  bool workstatus;

  @HiveField(11)
  bool paidstatus;

  @HiveField(12)
  final String? remarks;

  WorkModel({
    this.id,
    required this.worklist,
    required this.stafflist,
    required this.name,
    required this.location,
    required this.apartment,
    required this.phonenumber,
    required this.date,
    required this.day,
    required this.amount,
    required this.workstatus,
    required this.paidstatus,
    this.remarks,
  });
}
