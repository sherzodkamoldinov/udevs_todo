import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/constants/app_icons.dart';
import 'package:udevs_todo/core/assets/fonts/rubik_font/rubik_font.dart';
import 'package:udevs_todo/data/models/todo_model/todo_hive_model.dart';

class ReminderDelegate extends SliverPersistentHeaderDelegate {
  final TodoHiveModel reminderTodo;
  ReminderDelegate({required this.reminderTodo});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: 132,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 13,
        horizontal: 18,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.appBarGradient,
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: [
            // REMINDER REMOVE BUTTON
            Positioned(
              top: -5,
              right: -5,
              child: IconButton(
                onPressed: () {
                  // here close reminder
                },
                icon: SvgPicture.asset(
                  AppIcons.xNoteIcon,
                  height: 15,
                ),
              ),
            ),

            // REMINDER INFO
            Positioned(
              left: 16,
              top: 21,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today Reminder",
                    style: RubikFont.w500.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    reminderTodo.title,
                    style: RubikFont.w400.copyWith(color: AppColors.whiteSmoke, fontSize: 11),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat.Hm().format(reminderTodo.dateTime),
                    style: RubikFont.w400.copyWith(color: AppColors.whiteSmoke, fontSize: 11),
                  )
                ],
              ),
            ),

            // REMINDER ICON
            Positioned(
              top: 17,
              right: 21,
              child: Image.asset(
                AppIcons.bellImg,
                height: 66,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 132;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
