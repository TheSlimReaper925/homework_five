import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api_ex/data/repository/todo_repository.dart';
import 'package:rest_api_ex/logic/todo_cubit/cubit/todo_cubit.dart';

class AddScreen extends StatelessWidget {
  AddScreen({Key? key}) : super(key: key);

  static const routeName = '/add-todo';

  final _formkey = GlobalKey<FormState>();

  TextEditingController id = TextEditingController();
  TextEditingController todo = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Todo'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Card(
                    child: TextFormField(
                      controller: id,
                      decoration:
                          const InputDecoration(hintText: "Enter todo ID"),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter valid ID";
                        }
                        return null;
                      },
                    ),
                  ),
                  Card(
                    child: TextFormField(
                      controller: todo,
                      decoration: const InputDecoration(hintText: "Enter todo"),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter valid text";
                        }
                        return null;
                      },
                    ),
                  ),
                  Card(
                    child: TextFormField(
                      controller: description,
                      decoration: const InputDecoration(
                          hintText: "Enter todo description"),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter valid todo description";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            TodoRepository()
                .addTodos(int.parse(id.text), todo.text, description.text);
            Navigator.pop(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
