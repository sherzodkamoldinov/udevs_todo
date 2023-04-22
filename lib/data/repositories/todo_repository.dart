import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:udevs_todo/core/assets/constants/storage_keys.dart';
import 'package:udevs_todo/data/models/todo_model/todo_hive_model.dart';

class TodoRepository {
  var todoBox = Hive.box<TodoHiveModel>(StorageKeys.todoBox);

  Future<void> addTodo({required TodoHiveModel todo}) async {
    await todoBox.add(todo);
    debugPrint('Added Datas Count: ${todoBox.length}');
  }

  List<TodoHiveModel> getTodos() {
    debugPrint('Got Datas Count: ${todoBox.values.toList().length}');
    // first sort
    List<TodoHiveModel> values = todoBox.values.toList();
    values.sort((a, b) => a.dateTime.millisecondsSinceEpoch.compareTo(b.dateTime.millisecondsSinceEpoch));
    values.forEach((element) {
      debugPrint(element.id.toString());
    });
    return values.cast<TodoHiveModel>();
  }

  Future<void> updateTodo(TodoHiveModel todo) async {
    int index = -1;
    List<TodoHiveModel> values = todoBox.values.toList();
    index = values.indexWhere((element) => element.id == todo.id);
    await todoBox.putAt(index, todo);
  }

  Future<void> deleteTodo(int id) async{
    int index = -1;
    List<TodoHiveModel> values = todoBox.values.toList();
    index = values.indexWhere((element) => element.id == id);
    await todoBox.deleteAt(index);
  }

  Future<void> deleteAllTodos() async{
    await todoBox.deleteAll(todoBox.keys);
  }
}
