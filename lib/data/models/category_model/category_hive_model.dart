import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'category_hive_model.g.dart';

@HiveType(typeId: 1)
class CategoryHiveModel extends HiveObject {

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String color;
  @HiveField(2)
  final String gridColor;
  @HiveField(3)
  final String iconPath;
  @HiveField(4)
  final String title;
  @HiveField(5)
  final int intIconPath;

  CategoryHiveModel( {
    required this.intIconPath,
    required this.color,
    required this.gridColor,
    required this.iconPath,
    required this.id,
    required this.title,
  });
}
