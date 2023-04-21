import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:udevs_todo/bloc/todo_bloc/todo_bloc.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/fonts/rubik_font/rubik_font.dart';
import 'package:udevs_todo/core/utils/utils.dart';
import 'package:udevs_todo/data/models/category_model/category_hive_model.dart';

class BigCategoryItem extends StatelessWidget {
  const BigCategoryItem({super.key, required this.categoryModel});

  final CategoryHiveModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            blurRadius: 11,
            color: AppColors.silver.withOpacity(0.35),
            offset: const Offset(0, 7),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
              color: MyUtils.toColor(categoryModel.gridColor),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                categoryModel.iconPath,
                height: 34,
              ),
            ),
          ),
          Text(
            categoryModel.title,
            style: RubikFont.w500.copyWith(
              fontSize: 18,
              color: AppColors.doveGray,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            '${context.read<TodoBloc>().getTodosCountByCatgory(categoryModel.id)} Task',
            style: RubikFont.w400.copyWith(
              fontSize: 10,
              color: AppColors.silverChalice,
            ),
          ),
        ],
      ),
    );
  }
}
