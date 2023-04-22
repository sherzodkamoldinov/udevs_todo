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

class DeleteAllTodosEvent extends TodoEvent {}

class UpdateTodoEvent extends TodoEvent {
  const UpdateTodoEvent({required this.isUpdateDate, required this.todoModel,this.isCheckBoxPressed = false, this.isBellPressed = false});

  final TodoHiveModel todoModel;
  final bool isUpdateDate;
  final bool isCheckBoxPressed;
  final bool isBellPressed;

  @override
  List<Object?> get props => [
        isCheckBoxPressed,
        isBellPressed,
        todoModel,
        isUpdateDate,
      ];
}

class AddTodoEvent extends TodoEvent {
  const AddTodoEvent({
    required this.selectedCategoryId,
    required this.categoryTitle,
    required this.title,
    this.dateTime,
    required this.id,
    
  });
  final int id;
  final String title;
  final String categoryTitle;
  final int selectedCategoryId;
  final DateTime? dateTime;

  @override
  List<Object?> get props => [
        id,
        title,
        categoryTitle,
        selectedCategoryId,
        dateTime,
      ];
}
