import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:udevs_todo/core/assets/constants/storage_keys.dart';
import 'package:udevs_todo/core/utils/utils.dart';
import 'package:udevs_todo/data/models/todo_hive_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<RemoveReminderEvent>(
      (event, emit) {
        emit(state.copyWith(showReminder: false));
      },
    );
    on<AddTodoEvent>(
      (event, emit) async {
        if (event.title == '') {
          MyUtils.getMyToast(message: 'Please, fill the field');
        } else if (event.selectedCategoryId == -1) {
          MyUtils.getMyToast(message: 'Please, select project');
        } else if (event.dateTime == null) {
          MyUtils.getMyToast(message: 'Please, choose the date');
        } else if (event.dateTime!.difference(DateTime.now()).inMinutes <= 0) {
          MyUtils.getMyToast(message: 'Task time must be in the future');
        } else {
          Navigator.of(event.context).pop();
          // add todo
          emit(state.copyWith(todoStatus: FormzStatus.submissionInProgress));
          try {
            var todoBox = Hive.box<TodoHiveModel>(StorageKeys.todoBox);
            TodoHiveModel todo = TodoHiveModel(categoryId: event.selectedCategoryId, title: event.title, dateTime: event.dateTime!, isDone: false);
            await todoBox.add(todo);
            // TODO: here add natifation with schedule

            add(GetTodosEvent());
            emit(state.copyWith(todoStatus: FormzStatus.submissionSuccess));
          } catch (e) {
            emit(state.copyWith(todoStatus: FormzStatus.submissionFailure, errMessage: e.toString()));
          }
        }
      },
    );
    on<GetTodosEvent>(
      (event, emit) {
        emit(state.copyWith(todoStatus: FormzStatus.submissionInProgress));
        List<TodoHiveModel> todos = [];
        // here ger todos from hive
        emit(state.copyWith(todos: todos, todoStatus: FormzStatus.submissionSuccess));
      },
    );
    on<DeleteTodoEvent>(
      (event, emit) {
        // here delete todo
        // here cancel notification service
      },
    );
    on<UpdateTodoEvent>(
      (event, emit) {
        // here update todo
      },
    );
  }

  int getTaskCountByCatgory(int categoryId) {
    int count = 0;
    List<TodoHiveModel> todos = state.todos;
    for (var todo in todos) {
      if (todo.categoryId == categoryId) count++;
    }
    return count;
  }
}
