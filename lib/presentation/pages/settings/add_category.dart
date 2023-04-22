import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udevs_todo/bloc/category_bloc/category_bloc.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/fonts/rubik_font/rubik_font.dart';
import 'package:udevs_todo/core/utils/utils.dart';
import 'package:udevs_todo/data/models/category_model/category_hive_model.dart';
import 'package:udevs_todo/data/repositories/category_repository.dart';
import 'package:udevs_todo/presentation/common/widgets/w_button.dart';
import 'package:udevs_todo/presentation/common/widgets/w_scale_animation.dart';
import 'package:udevs_todo/presentation/common/widgets/w_text_field.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  late TextEditingController catCon;
  String selectedColor = Colors.grey.shade300.value.toRadixString(16);
  int selectedIcon = 0;
  int selectedColorIndex = -1;
  int selectedIconIndex = -1;

  @override
  void initState() {
    catCon = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    catCon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 14, right: 14, top: 18),
      children: [
        Text(
          'Add Category',
          style: RubikFont.w400.copyWith(fontSize: 22, color: AppColors.cornflowerBlue.withOpacity(0.7)),
          textAlign: TextAlign.center,
        ),
        WTextField(controller: catCon),
        const SizedBox(
          height: 25,
        ),

        // color list
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: CategoryRepository.newColors.length,
            itemBuilder: (context, index) {
              var color = CategoryRepository.newColors[index];
              return WScaleAnimation(
                onTap: () {
                  setState(() {
                    selectedColorIndex = index;
                    selectedColor = color;
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyUtils.toColor(color),
                    border: index == selectedColorIndex ? Border.all(color: Colors.grey, width: 2) : null,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 25,
        ),

        // icon list
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: CategoryRepository.newCategories.length,
            itemBuilder: (context, index) {
              var category = CategoryRepository.newCategories[index];
              return WScaleAnimation(
                onTap: () {
                  selectedIconIndex = index;
                  selectedIcon = category;
                  setState(() {});
                },
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: MyUtils.toColor(selectedColor).withOpacity(0.36),
                    border: index == selectedIconIndex ? Border.all(color: Colors.grey, width: 2) : null,
                  ),
                  child: Icon(
                    IconData(category, fontFamily: 'MaterialIcons'),
                    color: MyUtils.toColor(selectedColor),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 25),
        WButton(
          onTap: () {
            if (selectedColorIndex != -1 && selectedIconIndex != -1 && catCon.text.trim().isNotEmpty) {
              BlocProvider.of<CategoryBloc>(context).add(
                AddCategoryEvent(
                  categoryModel: CategoryHiveModel(
                    color: selectedColor,
                    iconPath: '',
                    gridColor: MyUtils.toColor(selectedColor).withOpacity(0.36).value.toRadixString(16),
                    title: catCon.text,
                    id: Random().nextInt(pow(2, 31).toInt()-1),
                    intIconPath: selectedIcon,
                  ),
                ),
              );
              Navigator.of(context).pop();
            } else {
              MyUtils.getMyToast(message: 'Please fill and select!');
            }
          },
          text: 'Save',
          color: MyUtils.toColor(selectedColor),
          textStyle: RubikFont.w400.copyWith(fontSize: 22, color: AppColors.white),
        ),
        const SizedBox(height: 30)
      ],
    );
  }
}
