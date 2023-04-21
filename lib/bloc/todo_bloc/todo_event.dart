part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}


class GetTodosEvent extends TodoEvent {}

class DeleteTodoEvent extends TodoEvent {
  const DeleteTodoEvent({required this.id});
  final int id;

  @override
  List<Object?> get props => [id];
}

class UpdateTodoEvent extends TodoEvent {
  const UpdateTodoEvent({
    required this.todoModel,
  });

  final TodoHiveModel todoModel;

  @override
  List<Object?> get props => [
        todoModel,
      ];
}

class AddTodoEvent extends TodoEvent {
  const AddTodoEvent({
    required this.selectedCategoryId,
    required this.title,
    this.dateTime,
    required this.context,
    required this.id,
  });
  final int id;
  final String title;
  final int selectedCategoryId;
  final DateTime? dateTime;
  final BuildContext context;

  @override
  List<Object?> get props => [
    id,
        title,
        selectedCategoryId,
        dateTime,
        context,
      ];
}
