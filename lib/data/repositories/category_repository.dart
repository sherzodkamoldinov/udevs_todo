import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:udevs_todo/core/assets/constants/storage_keys.dart';
import 'package:udevs_todo/data/models/category_model/category_hive_model.dart';

class CategoryRepository {
  var categoryBox = Hive.box<CategoryHiveModel>(StorageKeys.categoryBox);
  static List<int> newCategories = [
    Icons.access_alarm.codePoint,
    Icons.account_circle_rounded.codePoint,
    Icons.accessible.codePoint,
    Icons.healing.codePoint,
    Icons.sports_baseball.codePoint,
    Icons.add_location.codePoint,
    Icons.airplane_ticket.codePoint,
    Icons.apartment_sharp.codePoint,
    Icons.work_rounded.codePoint,
    Icons.weekend_rounded.codePoint,
    Icons.smart_display.codePoint,
  ];
  static List<String> newColors = [
    Colors.orange.value.toRadixString(16),
    Colors.blueAccent.value.toRadixString(16),
    Colors.yellow.value.toRadixString(16),
    Colors.lightGreen.value.toRadixString(16),
    Colors.pink.value.toRadixString(16),
    Colors.tealAccent.value.toRadixString(16),
    Colors.indigo.value.toRadixString(16),
    Colors.purple.value.toRadixString(16),
    Colors.green.value.toRadixString(16),
    Colors.red.value.toRadixString(16),
  ];
  List<CategoryHiveModel> categories = [
    CategoryHiveModel(
      color: const Color(0xFFFFD506).value.toRadixString(16),
      gridColor: const Color(0xFFFFEE9B).withOpacity(0.36).value.toRadixString(16),
      iconPath: 'assets/icons/categories/user.svg',
      id: 0,
      title: 'Personal',
      intIconPath: -1,
    ),

    // Work
    CategoryHiveModel(
      color: const Color(0xFF5DE61A).value.toRadixString(16),
      gridColor: const Color(0xFFB5FF9B).withOpacity(0.36).value.toRadixString(16),
      iconPath: 'assets/icons/categories/briefcase.svg',
      id: 1,
      title: 'Work',
      intIconPath: -1,
    ),

    // Meeting
    CategoryHiveModel(
      color: const Color(0xFFD10263).value.toRadixString(16),
      gridColor: const Color(0xFFFF9BCD).withOpacity(0.36).value.toRadixString(16),
      iconPath: 'assets/icons/categories/presentation.svg',
      id: 2,
      title: 'Meeting',
      intIconPath: -1,
    ),

    // Meeting
    CategoryHiveModel(
      color: const Color(0xFFF29130).value.toRadixString(16),
      gridColor: const Color(0xFFFFD09B).withOpacity(0.36).value.toRadixString(16),
      iconPath: 'assets/icons/categories/shopping_basket.svg',
      id: 3,
      title: 'Shopping',
      intIconPath: -1,
    ),

    // Party
    CategoryHiveModel(
      color: const Color(0xFF3044F2).value.toRadixString(16),
      gridColor: const Color(0xFF9BFFF8).withOpacity(0.36).value.toRadixString(16),
      iconPath: 'assets/icons/categories/confetti.svg',
      id: 4,
      title: 'Party',
      intIconPath: -1,
    ),

    // Study
    CategoryHiveModel(
      color: const Color(0xFFBF0080).value.toRadixString(16),
      gridColor: const Color(0xFFF59BFF).withOpacity(0.36).value.toRadixString(16),
      iconPath: 'assets/icons/categories/molecule.svg',
      id: 5,
      title: 'Study',
      intIconPath: -1,
    ),
  ];

  Future<void> firstInit() async {
    // ignore: avoid_function_literals_in_foreach_calls
    categories.forEach((element) async {
      await categoryBox.add(element);
    });

    debugPrint('Added Category Datas Count: ${categoryBox.length}');
  }

  Future<void> addCategory({required CategoryHiveModel category}) async {
    await categoryBox.put(category.id, category);
    debugPrint('Added Category Datas Count: ${categoryBox.length}');
  }

  Future<void> deleteCategory({required int id}) async {
    await categoryBox.delete(id);
    debugPrint('Added Category Datas Count: ${categoryBox.length}');
  }

  List<CategoryHiveModel> getCategory() {
    var categoryBox = Hive.box<CategoryHiveModel>(StorageKeys.categoryBox);
    debugPrint('Got Category Datas Count: ${categoryBox.values.toList().length}');
    return categoryBox.values.toList().cast<CategoryHiveModel>();
  }
}
