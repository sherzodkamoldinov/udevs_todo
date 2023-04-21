part of 'todo_bloc.dart';

class TodoState extends Equatable {
  const TodoState({
    this.todoStatus = FormzStatus.pure,
    this.todos = const [],
    this.errMessage = '',
  });

  final FormzStatus todoStatus;
  final List<TodoHiveModel> todos;
  final String errMessage;

  TodoState copyWith({
    FormzStatus? todoStatus,
    bool? showReminder,
    List<TodoHiveModel>? todos,
    String? errMessage,
  }) =>
      TodoState(
        errMessage: errMessage ?? this.errMessage,
        todos: todos ?? this.todos,
        todoStatus: todoStatus ?? this.todoStatus,
      );

  @override
  List<Object?> get props => [todoStatus, todos, errMessage];
}
