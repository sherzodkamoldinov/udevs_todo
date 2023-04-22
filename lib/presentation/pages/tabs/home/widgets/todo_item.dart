import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:udevs_todo/bloc/todo_bloc/todo_bloc.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/constants/app_icons.dart';
import 'package:udevs_todo/core/assets/fonts/rubik_font/rubik_font.dart';
import 'package:udevs_todo/core/utils/utils.dart';
import 'package:udevs_todo/data/models/category_model/category_hive_model.dart';
import 'package:udevs_todo/data/models/todo_model/todo_hive_model.dart';
import 'package:udevs_todo/presentation/common/widgets/w_checkbox.dart';
import 'package:udevs_todo/presentation/common/widgets/w_scale_animation.dart';
import 'package:udevs_todo/presentation/pages/tabs/widgets/edit_todo_item.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.showDay,
    required this.todo,
    required this.categories,
  });

  final bool showDay;
  final TodoHiveModel todo;
  final List<CategoryHiveModel> categories;

  @override
  Widget build(BuildContext context) {
    var todoCategory = categories.where((element) => element.id == todo.categoryId).first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showDay)
          Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 5),
            child: Text(
              MyUtils.isEqualDate(fstDate: todo.dateTime, secDate: DateTime.now()) ? "Today" : DateFormat.MMMEd().format(todo.dateTime),
              style: RubikFont.w500.copyWith(fontSize: 13, color: AppColors.shipCove),
            ),
          ),
        // left slidable
        Slidable(
          key: ValueKey(todo.dateTime.millisecondsSinceEpoch),
          startActionPane: ActionPane(
            extentRatio: 0.23,
            motion: const ScrollMotion(),
            children: [
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: MyUtils.toColor(todoCategory.gridColor),
                ),
                child: Center(
                  child: todoCategory.iconPath.isNotEmpty
                  ? SvgPicture.asset(
                    todoCategory.iconPath,
                    color: MyUtils.toColor(todoCategory.color),
                    height: 16,
                  ): Icon(
                    IconData(todoCategory.intIconPath, fontFamily: 'MaterialIcons'),
                    color: MyUtils.toColor(todoCategory.color),
                  ),
                ),
              ),
            ],
          ),
          endActionPane: ActionPane(
            extentRatio: 0.4,
            motion: const ScrollMotion(),
            children: [
              // update todo slidable button
              WScaleAnimation(
                onTap: () {
                  showModalBottomSheet(
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => EditTodoItem(
                      categories: categories,
                      todo: todo,
                    ),
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

              // delete todo slidable button
              WScaleAnimation(
                onTap: () {
                  // here delete todo forever
                  BlocProvider.of<TodoBloc>(context).add(DeleteTodoEvent(id: todo.id));
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
                // category color
                Container(
                  height: 55,
                  width: 4,
                  decoration: BoxDecoration(
                    color: MyUtils.toColor(categories.where((element) => element.id == todo.categoryId).toList()[0].color),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                ),

                // all info
                Expanded(
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    child: Row(
                      children: [
                        // change todo's done
                        WCheckBox(
                          isSelected: todo.isDone,
                          onChanged: (v) {
                            // here update todo's done
                            BlocProvider.of<TodoBloc>(context).add(
                              UpdateTodoEvent(
                                isCheckBoxPressed: true,
                                isUpdateDate: false,
                                todoModel: todo.copyWith(isDone: v, isReminding: !v),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 11),

                        // date
                        Text(
                          DateFormat.Hm().format(todo.dateTime),
                          style: RubikFont.w400.copyWith(
                            fontSize: 11,
                            color: AppColors.ghost,
                          ),
                        ),
                        const SizedBox(width: 13),

                        // title
                        Expanded(
                          child: Text(
                            todo.title,
                            style: RubikFont.w500.copyWith(
                              decorationColor: AppColors.gainsboro,
                              decoration: todo.isDone ? TextDecoration.underline : null,
                              fontSize: 14,
                              color: todo.isDone ? AppColors.gainsboro : AppColors.victoria,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const Spacer(),

                        // change reminder event
                        IconButton(
                          onPressed: () {
                            debugPrint("MYTODO: ${todo.isReminding}");
                            if (!todo.isDone) {
                              BlocProvider.of<TodoBloc>(context).add(
                                UpdateTodoEvent(
                                  isBellPressed: true,
                                  isUpdateDate: false,
                                  todoModel: todo.copyWith(isReminding: todo.isReminding ? false : true),
                                ),
                              );
                            } else {
                              MyUtils.getMyToast(message: 'Task must be active!');
                            }
                          },
                          style: IconButton.styleFrom(padding: EdgeInsets.zero),
                          icon: SvgPicture.asset(
                            AppIcons.bell,
                            color: todo.isReminding ? Colors.orange : null,
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
