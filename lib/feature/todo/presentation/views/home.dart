import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/feature/todo/presentation/providers/todo.provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo')),
      body: const Center(child: Text('va')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => WidgetsBinding.instance.addPostFrameCallback((v) {
          context.read<TodoProvider>().add(context);
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
