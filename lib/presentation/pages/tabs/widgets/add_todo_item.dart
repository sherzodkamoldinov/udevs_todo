import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:udevs_todo/bloc/category_bloc/category_bloc.dart';
import 'package:udevs_todo/bloc/todo_bloc/todo_bloc.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/constants/app_icons.dart';
import 'package:udevs_todo/core/assets/fonts/rubik_font/rubik_font.dart';
import 'package:udevs_todo/data/models/category_model/category_hive_model.dart';
import 'package:udevs_todo/presentation/common/widgets/circle_pink_button.dart';
import 'package:udevs_todo/presentation/common/widgets/w_button.dart';
import 'package:udevs_todo/presentation/common/widgets/w_text_field.dart';
import 'package:udevs_todo/presentation/pages/tabs/widgets/add_todo_item_header_paint.dart';
import 'package:udevs_todo/presentation/pages/tabs/widgets/category_item.dart';

import '../../../../core/utils/utils.dart';

class AddTodoItem extends StatefulWidget {
  const AddTodoItem({super.key});

  @override
  State<AddTodoItem> createState() => _AddTodoItemState();
}

class _AddTodoItemState extends State<AddTodoItem> {
  late final TextEditingController controller;
  late final List<CategoryHiveModel> categories;
  int selectedCategoryId = -1;
  DateTime? pickedDate;

  @override
  void initState() {
    controller = TextEditingController();
    categories = BlocProvider.of<CategoryBloc>(context).state.categories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 400,
        width: 375,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CustomPaint(
              size: const Size(375, 400),
              painter: AddTodoItemHeaderPaint(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 43),
                  Center(
                    child: Text(
                      "Add new task",
                      style: RubikFont.w500.copyWith(
                        fontSize: 13,
                        color: AppColors.charcoal,
                      ),
                    ),
                  ),
                  WTextField(controller: controller),
                  const SizedBox(height: 17.5),
                  SizedBox(
                    height: 30,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 15.5),
                      children: List.generate(
                        categories.length,
                        (index) => CategoryItem(
                          category: categories[index],
                          isSelected: categories[index].id == selectedCategoryId,
                          onPressed: () => setState(() {
                            selectedCategoryId = categories[index].id;
                          }),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 13.5),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21.5),
                    child: Divider(
                      color: AppColors.veryLightGrey,
                      height: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        WButton(
                          onTap: () async {
                            DateTime? dateTime = await MyUtils.getDateTime(
                              context: context,
                            );
                            if (dateTime == null) {
                              MyUtils.getMyToast(
                                message: 'Please choose date and time',
                              );
                            } else {
                              setState(() {
                                pickedDate = dateTime;
                              });
                            }
                          },
                          text: "Choose date",
                          textStyle: RubikFont.w400.copyWith(
                            fontSize: 13,
                            color: AppColors.white,
                          ),
                          width: MediaQuery.of(context).size.width / 2,
                          borderRadius: 5,
                          color: AppColors.cornflowerBlue,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          pickedDate == null ? 'Not Selected Yet' : "${DateFormat.MMMMd().format(pickedDate!)} ${DateFormat.Hm().format(pickedDate!)} ",
                          style: RubikFont.w500.copyWith(
                            fontSize: 13,
                            color: AppColors.charcoal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),

                  // add todo to cache
                  WButton(
                    onTap: () {
                      BlocProvider.of<TodoBloc>(context).add(AddTodoEvent(
                        title: controller.text,
                        selectedCategoryId: selectedCategoryId,
                        dateTime: pickedDate,
                        context: context,
                        id: DateTime.now().millisecondsSinceEpoch,
                      ));
                      
                    },
                    height: 53,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 26),
                    gradientColors: AppColors.blueGradient,
                    borderRadius: 5,
                    text: 'Add task',
                    textStyle: RubikFont.w500.copyWith(
                      fontSize: 18,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: -26.5,
              child: CirclePinkButton(
                iconPath: AppIcons.xNoteIcon,
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
