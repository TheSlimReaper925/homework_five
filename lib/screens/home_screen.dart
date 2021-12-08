import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api_ex/data/repository/todo_repository.dart';
import 'package:rest_api_ex/logic/todo_cubit/cubit/todo_cubit.dart';
import 'package:rest_api_ex/screens/screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        bloc: context.read<TodoCubit>()..fetchTodos(),
        builder: (context, state) {
          if (state is TodoInitial) {
            return const CircularProgressIndicator();
          } else if (state is TodoLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  confirmDismiss: (direction) => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Are you sure?"),
                      content:
                          const Text("Do you really want to delete this app?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("no"),
                        ),
                        TextButton(
                          onPressed: () {
                            context
                                .read<TodoCubit>()
                                .deleteDotos(state.todoList[index].id!);
                            Navigator.pop(context);
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  ),
                  child: ListTile(
                    title: Text(state.todoList[index].todo!),
                    subtitle: Text(state.todoList[index].description!),
                    trailing: CircleAvatar(
                      child: Text(
                        state.todoList[index].id.toString(),
                      ),
                    ),
                  ),
                );
              },
              itemCount: state.todoList.length,
            );
          } else {
            return Center(
              child: Text((state as TodoLoadingError).errorMessage),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddScreen.routeName)
              .then((_) => context.read<TodoCubit>().fetchTodos());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
