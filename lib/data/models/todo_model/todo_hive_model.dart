// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'todo_hive_model.g.dart';

@HiveType(typeId: 0)
class TodoHiveModel extends HiveObject {

  @HiveField(0)
  int categoryId;
  @HiveField(1)
  String title;
  @HiveField(2)
  DateTime dateTime;
  @HiveField(3)
  bool isDone;
  @HiveField(5)
  int id;

  TodoHiveModel({
    required this.categoryId,
    required this.title,
    required this.dateTime,
    required this.isDone,
    required this.id,
  });
}
