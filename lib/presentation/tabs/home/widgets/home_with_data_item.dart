import 'package:flutter/material.dart';
import 'package:udevs_todo/presentation/tabs/home/widgets/reminder_delegate.dart';
import 'package:udevs_todo/presentation/tabs/home/widgets/todo_item.dart';

class HomeWithDataItem extends StatelessWidget {
  const HomeWithDataItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // REMINDER TODOS
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
                return TodoItem(index: index, showDay: true);
              },
              childCount: 6,
            ),
          ),
        ),
      ],
    );
  }
}
