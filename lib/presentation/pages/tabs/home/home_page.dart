import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:udevs_todo/bloc/category_bloc/category_bloc.dart';
import 'package:udevs_todo/bloc/todo_bloc/todo_bloc.dart';
import 'package:udevs_todo/core/assets/colors/app_colors.dart';
import 'package:udevs_todo/presentation/pages/tabs/home/widgets/home_empty_item.dart';
import 'package:udevs_todo/presentation/pages/tabs/home/widgets/reminder_delegate.dart';
import 'package:udevs_todo/presentation/pages/tabs/home/widgets/todo_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.aliceBlue,
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state.todoStatus.isSubmissionInProgress || BlocProvider.of<CategoryBloc>(context).state.categoryStatus.isSubmissionInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.todoStatus.isSubmissionSuccess) {
            if (state.todos.isNotEmpty) {
              return CustomScrollView(
                slivers: [
                  // REMINDER TODOs
                  SliverPersistentHeader(
                    delegate: ReminderDelegate(),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          var todos = state.todos;
                          var categories = BlocProvider.of<CategoryBloc>(context).state.categories;
                          // debugPrint('INDEX ${index} : ${todos[index].dateTime.difference(todos[index - 1].dateTime).inDays}');
                          return TodoItem(
                            todo: todos[index],
                            showDay: index == 0 || todos[index].dateTime.day != todos[index-1].dateTime.day,
                            categories: categories,
                          );
                        },
                        childCount: state.todos.length,
                      ),
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
