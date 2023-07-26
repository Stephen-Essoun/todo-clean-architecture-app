import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/feature/todo/domain/entities/todo.dart';
import 'package:todo/feature/todo/presentation/providers/todo.provider.dart';
import 'package:todo/feature/todo/presentation/widgets/textfield.custom.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo')),
      body: StreamBuilder<List<Todo>>(
          stream: context.read<TodoProvider>().listTodo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final todo = snapshot.data!;
              return ListView.builder(
                itemCount: todo.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const StretchMotion(),
                      children: [
                        // SlidableAction(
                        //   backgroundColor: Colors.green,
                        //   onPressed: (context) {
                        //     textController.text = todo[index].text;
                        //     descriptionController.text =
                        //         todo[index].description;
                        //     editTextFields(context, todo[index].id);
                        //   },
                        //   icon: Icons.edit,
                        // ),
                        SlidableAction(
                          backgroundColor: Colors.red,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5)),
                          onPressed: (context) {
                            context
                                .read<TodoProvider>()
                                .delete(todo[index], context);
                          },
                          icon: Icons.delete,
                        ),
                      ],
                    ),
                    startActionPane: ActionPane(
                      motion: const StretchMotion(),
                      children: [
                        SlidableAction(
                          backgroundColor: Colors.green,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          onPressed: (context) {
                            textController.text = todo[index].text;
                            descriptionController.text =
                                todo[index].description;
                            editTextFields(context, todo[index].id);
                          },
                          icon: Icons.edit,
                        ),
                        // SlidableAction(
                        // borderRadius: const BorderRadius.only(
                        //     topRight: Radius.circular(5),
                        //     bottomRight: Radius.circular(5)),
                        //   backgroundColor: Colors.red,
                        //   onPressed: (context) {
                        //     context
                        //         .read<TodoProvider>()
                        //         .delete(todo[index], context);
                        //   },
                        //   icon: Icons.delete,
                        // ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(todo[index].text),
                      subtitle: Text(todo[index].description),
                    ),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('No data found'),
              );
            }
            return const Center(child: CircularProgressIndicator.adaptive());
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => textFields(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  final textController = TextEditingController();
  final descriptionController = TextEditingController();

  String generateRandomId(int length) {
    const String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final Random random = Random();
    const int maxIndex = chars.length - 1;

    String id = '';
    for (int i = 0; i < length; i++) {
      id += chars[random.nextInt(maxIndex)];
    }

    return id;
  }

  textFields(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            customTextField(
              labelText: 'Title',
              controller: textController,
            ),
            customTextField(
              labelText: 'Description',
              controller: descriptionController,
            ),
            ElevatedButton(
              onPressed: () {
                final todo = Todo(
                    id: generateRandomId(10),
                    text: textController.text,
                    description: descriptionController.text);
                context.read<TodoProvider>().add(context, todo);
              },
              child: const Text('Add Todo'),
            )
          ],
        );
      },
    );
  }

  editTextFields(
    BuildContext context,
    String id,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            customTextField(
              labelText: 'Title',
              controller: textController,
            ),
            customTextField(
              labelText: 'Description',
              controller: descriptionController,
            ),
            ElevatedButton(
              onPressed: () {
                final todo = Todo(
                  id: id,
                  text: textController.text,
                  description: descriptionController.text,
                );
                context.read<TodoProvider>().edit(todo, context);
              },
              child: const Text('Save Todo'),
            )
          ],
        );
      },
    );
  }
}
