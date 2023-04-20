import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/constants/icons/app_icons.dart';
import 'package:udevs_todo/core/assets/fonts/rubik_font/rubik_font.dart';
import 'package:udevs_todo/data/models/category_model.dart';
import 'package:udevs_todo/presentation/common/widgets/w_checkbox.dart';
import 'package:udevs_todo/presentation/common/widgets/w_scale_animation.dart';
import 'package:udevs_todo/presentation/tabs/widgets/edit_todo_item.dart';

class TodoItem extends StatelessWidget {
   const TodoItem({
    super.key,
    required this.showDay,
    required this.index,
  });

  final bool showDay;
  final int index;

 

  @override
  Widget build(BuildContext context) {
     List<CategoryModel> categories = [
    CategoryModel(
      color: const Color(0xFFFFD506),
      gridColor: const Color(0xFFFFEE9B).withOpacity(0.36),
      iconPath: 'assets/icons/categories/user.svg',
      id: 0,
      title: 'Personal',
    ),

    // Work
    CategoryModel(
      color: const Color(0xFF5DE61A),
      gridColor: const Color(0xFFB5FF9B).withOpacity(0.36),
      iconPath: 'assets/icons/categories/briefcase.svg',
      id: 1,
      title: 'Work',
    ),

    // Meeting
    CategoryModel(
      color: const Color(0xFFD10263),
      gridColor: const Color(0xFFFF9BCD).withOpacity(0.36),
      iconPath: 'assets/icons/categories/presentation.svg',
      id: 2,
      title: 'Meeting',
    ),

    // Meeting
    CategoryModel(
      color: const Color(0xFFF29130),
      gridColor: const Color(0xFFFFD09B).withOpacity(0.36),
      iconPath: 'assets/icons/categories/shopping_basket.svg',
      id: 3,
      title: 'Shopping',
    ),

    // Party
    CategoryModel(
      color: const Color(0xFF3044F2),
      gridColor: const Color(0xFF9BFFF8).withOpacity(0.36),
      iconPath: 'assets/icons/categories/confetti.svg',
      id: 4,
      title: 'Party',
    ),

    // Study
    CategoryModel(
      color: const Color(0xFFBF0080),
      gridColor: const Color(0xFFF59BFF).withOpacity(0.36),
      iconPath: 'assets/icons/categories/molecule.svg',
      id: 5,
      title: 'Study',
    ),
  ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showDay)
          Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 5),
            child: Text(
              DateTime.now().difference(DateTime.now().add(Duration(days: index))).inDays == 0 ? "Today" : DateFormat.MMMEd().format(DateTime.now()),
              style: RubikFont.w500.copyWith(fontSize: 13, color: AppColors.shipCove),
            ),
          ),
        Slidable(
          key: ValueKey(index),
          endActionPane: ActionPane(
            extentRatio: 0.4,
            motion: const ScrollMotion(),
            children: [
              WScaleAnimation(
                onTap: () {
                  showModalBottomSheet(
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => const EditTodoItem(),
                  );
                },
                child: Container(
                  height: 35,
                  width: 35,
                  margin: const EdgeInsets.only(left: 12, right: 6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.paleCornflowerBlue,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppIcons.commentIcon,
                      height: 16,
                    ),
                  ),
                ),
              ),
              WScaleAnimation(
                onTap: () {
                  // here delete forever
                },
                child: Container(
                  height: 35,
                  width: 35,
                  margin: const EdgeInsets.only(left: 12, right: 6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.pink,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppIcons.trashIcon,
                      height: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 7),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(blurRadius: 9, offset: const Offset(0, 9), color: AppColors.black.withOpacity(0.05)),
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: 55,
                  width: 4,
                  decoration: BoxDecoration(
                    color: categories.where((element) => element.id == index).toList()[0].color,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    child: Row(
                      children: [
                        WCheckBox(
                          isSelected: false,
                          onChanged: (v) {
                            // here update todo
                          },
                        ),
                        const SizedBox(width: 11),
                        Text(
                          DateFormat.Hm().format(DateTime.now()),
                          style: RubikFont.w400.copyWith(
                            fontSize: 11,
                            color: AppColors.ghost,
                          ),
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Text(
                            'Nigga',
                            style: RubikFont.w500.copyWith(
                              decorationColor: AppColors.gainsboro,
                              decoration: index.isEven ? TextDecoration.underline : null,
                              fontSize: 14,
                              color: index.isEven ? AppColors.gainsboro : AppColors.victoria,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
