import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rest_api_ex/data/models/todo.dart';

class TodoRepository {
  List<Todo>? todoList = [];
  Dio dio = Dio();

  Future<List<Todo>?>? fetchTodos() async {
    final response = await dio.get('http://10.0.2.2:8080/todos');
    if (response.statusCode == 200) {
      var loadedTodo = <Todo>[];
      response.data.forEach((todo) {
        Todo todoModel = Todo.fromJson(todo);
        loadedTodo.add(todoModel);
        todoList = loadedTodo;
        return todoList;
      });
    }
    return todoList;
  }

  deleteTodos(int id) async {
    String url = 'http://10.0.2.2:8080/delete-todo/' + id.toString();
    await dio.delete(url);
  }

  addTodos(int id, String todo, String description) async {
    String url = 'http://10.0.2.2:8000/add-todo';
    print("is doing");
    await dio
        .post(url, data: {'id': id, 'todo': todo, 'description': description});
    print("DOne");
  }
}
