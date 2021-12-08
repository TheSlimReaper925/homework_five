import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rest_api_ex/data/models/todo.dart';
import 'package:rest_api_ex/data/repository/todo_repository.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  final todoRepository = TodoRepository();

  Future<void> fetchTodos() async {
    emit(TodoInitial());
    try {
      var todoList = await todoRepository.fetchTodos();
      emit(TodoLoaded(todoList!));
    } catch (e) {
      emit(
        TodoLoadingError(e.toString()),
      );
    }
  }

  Future<void> deleteDotos(int id) async {
    emit(TodoInitial());
    try {
      await todoRepository.deleteTodos(id);
      var todoList = await todoRepository.fetchTodos();
      emit(TodoLoaded(todoList!));
    } catch (e) {
      emit(
        TodoLoadingError(e.toString()),
      );
    }
  }

  Future<void> storeTodos(int id, String todo, String description) async {
    emit(TodoInitial());
    try {
      await todoRepository.addTodos(id, todo, description);
      var todoList = await todoRepository.fetchTodos();
      emit(TodoLoaded(todoList!));
    } catch (e) {
      emit(
        TodoLoadingError(e.toString()),
      );
    }
  }
}
