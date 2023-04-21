import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/constants/app_icons.dart';
import 'package:udevs_todo/core/assets/fonts/rubik_font/rubik_font.dart';
import 'package:udevs_todo/core/utils/utils.dart';
import 'package:udevs_todo/data/models/category_model/category_hive_model.dart';
import 'package:udevs_todo/presentation/common/widgets/circle_pink_button.dart';
import 'package:udevs_todo/presentation/common/widgets/w_button.dart';
import 'package:udevs_todo/presentation/common/widgets/w_text_field.dart';
import 'package:udevs_todo/presentation/pages/tabs/widgets/add_todo_item_header_paint.dart';
import 'package:udevs_todo/presentation/pages/tabs/widgets/category_item.dart';

class EditTodoItem extends StatefulWidget {
  const EditTodoItem({super.key, required this.categories});
  final List<CategoryHiveModel> categories;

  @override
  State<EditTodoItem> createState() => _EditTodoItemState();
}

class _EditTodoItemState extends State<EditTodoItem> {
  late final TextEditingController controller;
 late DateTime pickedDate;
  late int selectedCategoryId;

  @override
  void initState() {
    controller = TextEditingController(text: 'Edited task');
    selectedCategoryId = 0;
    pickedDate = DateTime.now();
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
                      "Edit task",
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
                        widget.categories.length,
                        (index) => CategoryItem(
                          category: widget.categories[index],
                          isSelected: widget.categories[index].id == selectedCategoryId,
                          onPressed: () => setState(
                            () {
                              selectedCategoryId = widget.categories[index].id;
                            },
                          ),
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
                            if (dateTime != null) {
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
                        const SizedBox(width: 15),
                        Text(
                          "${DateFormat.MMMMd().format(pickedDate)} ${DateFormat.Hm().format(pickedDate)} ",
                          style: RubikFont.w500.copyWith(
                            fontSize: 13,
                            color: AppColors.charcoal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  WButton(
                    onTap: () {
                      if (controller.text == '') {
                        MyUtils.getMyToast(message: 'Please fill the field');
                      } else if (pickedDate.difference(DateTime.now()).inMinutes <= 0) {
                        MyUtils.getMyToast(message: 'Task time must be in the future');
                      } else {
                        Navigator.of(context).pop();
                        // here edit task and some changes
                      }
                    },
                    height: 53,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 26),
                    gradientColors: AppColors.blueGradient,
                    borderRadius: 5,
                    text: 'Save task',
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
