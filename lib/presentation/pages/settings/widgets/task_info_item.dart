import 'package:flutter/material.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/fonts/rubik_font/rubik_font.dart';

class TaskInfoItem extends StatelessWidget {
  const TaskInfoItem({Key? key, required this.text, required this.isLeft}) : super(key: key);
  final String text;
  final bool isLeft;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 50,
        margin: isLeft ? const EdgeInsets.only(right: 15) : const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.cornflowerBlue),
        child: Center(
          child: Text(
            text,
            style: RubikFont.w400.copyWith(fontSize: 16, color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
