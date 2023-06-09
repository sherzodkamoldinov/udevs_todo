import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:udevs_todo/core/utils/utils.dart';
import 'package:udevs_todo/data/models/todo_model/todo_hive_model.dart';
import 'package:udevs_todo/data/repositories/todo_repository.dart';
import 'package:udevs_todo/services/notif_service.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoRepository todoRepository = TodoRepository();
  TodoBloc() : super(const TodoState()) {
    on<AddTodoEvent>(
      (event, emit) async {
        // add todo
        emit(state.copyWith(todoStatus: FormzStatus.submissionInProgress));
        try {
          // add todo to cache
          TodoHiveModel todo = TodoHiveModel(
            categoryId: event.selectedCategoryId,
            title: event.title,
            dateTime: event.dateTime!,
            isDone: false,
            id: event.id,
            isReminding: true,
            categoryTitle: event.categoryTitle,
          );
          await todoRepository.addTodo(todo: todo);

          //  add natifation with schedule
          LocalNotificationService.localNotificationService.scheduleNotification(
            todoModel: todo,
          );

          add(GetTodosEvent());
        } catch (e) {
          debugPrint('Error in add: ${e.toString()}');
          emit(state.copyWith(todoStatus: FormzStatus.submissionFailure, errMessage: e.toString()));
        }
      },
    );

    on<GetTodosEvent>(
      (event, emit) {
        emit(state.copyWith(todoStatus: FormzStatus.submissionInProgress));
        // here get todos from hive
        try {
          var todos = todoRepository.getTodos();

          emit(state.copyWith(todos: todos, todoStatus: FormzStatus.submissionSuccess));
        } catch (e) {
          emit(state.copyWith(todoStatus: FormzStatus.submissionFailure, errMessage: e.toString()));
        }
      },
    );

    on<UpdateTodoEvent>(
      (event, emit) async {
        // here update todo
        emit(state.copyWith(todoStatus: FormzStatus.submissionInProgress));
        try {
          await todoRepository.updateTodo(event.todoModel);

          // update notification
          if (event.isUpdateDate) {
            LocalNotificationService.localNotificationService.cancelNotificationById(event.todoModel.categoryId);
            //  add natifation with schedule
            LocalNotificationService.localNotificationService.scheduleNotification(
              todoModel: event.todoModel,
            );
          }

          /// it works when onPressed [checkBox]
          if (event.isCheckBoxPressed) {
            _cancelOrActiveNotif(event.todoModel.isDone, event.todoModel,);
          }

          /// it works when onPressed [bell icon]
          if (event.isBellPressed) {
            _cancelOrActiveNotif(!event.todoModel.isReminding, event.todoModel, );
          }

          add(GetTodosEvent());
        } catch (e) {
          emit(state.copyWith(todoStatus: FormzStatus.submissionInProgress, errMessage: e.toString()));
        }
      },
    );

    on<DeleteTodoEvent>(
      (event, emit) async {
        // here delete all todo info
        emit(state.copyWith(todoStatus: FormzStatus.submissionInProgress));
        try {
          // delete todo from cache
          await todoRepository.deleteTodo(event.id);

          // cancel and delete notif
          LocalNotificationService.localNotificationService.cancelNotificationById(event.id);
          add(GetTodosEvent());
        } catch (e) {
          emit(state.copyWith(todoStatus: FormzStatus.submissionInProgress, errMessage: e.toString()));
        }
      },
    );

    on<DeleteAllTodosEvent>(
      (event, emit) async {
        emit(state.copyWith(todoStatus: FormzStatus.submissionInProgress));
        try {
          // delete all todos from cache
          await todoRepository.deleteAllTodos();

          // cancel and delete all notif
          LocalNotificationService.localNotificationService.cancelAllNotifications();
          MyUtils.getMyToast(message: 'All Todos is Deleted 😞');
          add(GetTodosEvent());
        } catch (e) {
          emit(state.copyWith(todoStatus: FormzStatus.submissionInProgress, errMessage: e.toString()));
        }
      },
    );
  }

  int getTodosCountByCatgory(int categoryId) {
    int count = 0;
    List<TodoHiveModel> todos = state.todos;
    for (var todo in todos) {
      if (todo.categoryId == categoryId) count++;
    }
    return count;
  }

  int getTodosCountByNotDone() {
    int count = 0;
    List<TodoHiveModel> todos = state.todos;
    for (var todo in todos) {
      if (!todo.isDone) count++;
    }
    return count;
  }

  int getTodosCountByDone() {
    int count = 0;
    List<TodoHiveModel> todos = state.todos;
    for (var todo in todos) {
      if (todo.isDone) count++;
    }
    return count;
  }

  getTodosByCategory(int categoryId) {
    List<TodoHiveModel> todosByCategory = [];
    List<TodoHiveModel> todos = state.todos;
    for (var todo in todos) {
      if (todo.categoryId == categoryId) todosByCategory.add(todo);
    }
    return todosByCategory;
  }

  _cancelOrActiveNotif(bool cancel, TodoHiveModel todo) {
    if (cancel) {
      LocalNotificationService.localNotificationService.cancelNotificationById(todo.id);
    } else {
      LocalNotificationService.localNotificationService.scheduleNotification(
        todoModel: todo,
      );
    }
  }
}
