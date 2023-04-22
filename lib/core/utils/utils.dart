import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';

class MyUtils {
  // message
  static getMyToast({required String message}) => Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.primaryColor,
        textColor: AppColors.white,
        fontSize: 18,
      );

  // date time
  static Future<DateTime?> getDateTime({required BuildContext context, DateTime? newInitialDate}) async {
    DateTime initialDate = DateTime.now();
    if (newInitialDate != null) {
      initialDate = newInitialDate;
    }
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(initialDate.year),
      lastDate: DateTime(initialDate.year + 1),
    );

    // ignore: use_build_context_synchronously
    TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (date == null || timeOfDay == null) return null;

    return DateTime(
      date.year,
      date.month,
      date.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }

  static Color toColor(String hex) {
    var hexString = hex;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static bool isEqualDate({required DateTime fstDate, required DateTime secDate}) => DateTime(fstDate.year, fstDate.month, fstDate.day) == DateTime(secDate.year, secDate.month, secDate.day);
}
