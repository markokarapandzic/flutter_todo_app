import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_test_project/components/removed_item.dart';
import 'package:todo_app_test_project/models/item.dart';
import 'package:todo_app_test_project/state/items_notifier.dart';

class DeletedItemsScreen extends StatefulWidget {
  const DeletedItemsScreen({Key? key}) : super(key: key);

  @override
  State<DeletedItemsScreen> createState() => _DeletedItemsScreenState();
}

class _DeletedItemsScreenState extends State<DeletedItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deleted Items'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<ItemsNotifier>(
          builder: (context, tasks, child) => ListView.builder(
              itemCount: tasks.removedItems.length,
              itemBuilder: (context, index) {
                Item removedItem = tasks.removedItems[index];
                return RemovedItem(key: UniqueKey(), item: removedItem);
              }),
        ),
      )),
    );
  }
}
