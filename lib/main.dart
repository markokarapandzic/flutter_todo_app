import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_test_project/state/items_notifier.dart';

import 'screens/deleted.dart';
import 'screens/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ItemsNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DeletedItemsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.list),
          )
        ],
      ),
      body: const HomeScreen(),
    );
  }
}
