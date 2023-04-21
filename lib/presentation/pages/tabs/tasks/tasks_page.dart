import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:udevs_todo/bloc/category_bloc/category_bloc.dart';
import 'package:udevs_todo/bloc/setting_bloc/setting_bloc.dart';
import 'package:udevs_todo/bloc/todo_bloc/todo_bloc.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/core/assets/fonts/rubik_font/rubik_font.dart';
import 'package:udevs_todo/presentation/common/widgets/w_scale_animation.dart';
import 'package:udevs_todo/presentation/pages/tabs/home/widgets/home_empty_item.dart';
import 'package:udevs_todo/presentation/pages/tabs/home/widgets/reminder_delegate.dart';
import 'package:udevs_todo/presentation/pages/tabs/tasks/widgets/big_category_item.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.aliceBlue,
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state.categoryStatus.isSubmissionInProgress || BlocProvider.of<TodoBloc>(context).state.todoStatus.isSubmissionInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.categoryStatus.isSubmissionSuccess) {
            if (state.categories.isNotEmpty) {
              return CustomScrollView(
                slivers: [
                  // REMINDER TODOs
                  if (BlocProvider.of<SettingBloc>(context, listen: true).state.isReminderShow &&
                      BlocProvider.of<TodoBloc>(context, listen: true).state.todos.where((element) => !element.isDone).toList().isNotEmpty)
                    SliverPersistentHeader(
                      delegate: ReminderDelegate(reminderTodo: BlocProvider.of<TodoBloc>(context, listen: true).state.todos[0]),
                    ),
                  SliverPadding(
                    padding: const EdgeInsets.only(left: 18, top: 10),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Projects',
                        style: RubikFont.w500.copyWith(
                          fontSize: 13,
                          color: AppColors.shipCove,
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 13,
                    ),
                    sliver: SliverGrid.builder(
                      itemCount: state.categories.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 19, mainAxisSpacing: 23.5),
                      itemBuilder: (context, index) {
                        return BigCategoryItem(
                          categoryModel: state.categories[index],
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const HomeEmptyItem();
            }
          }
          return const Center(
            child: Text('ERROR STATE'),
          );
        },
      ),
    );
  }
}
