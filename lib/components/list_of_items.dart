import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_test_project/components/todo_item.dart';
import 'package:todo_app_test_project/state/items_notifier.dart';

class ListOfItems extends StatefulWidget {
  const ListOfItems({
    Key? key,
  }) : super(key: key);

  @override
  State<ListOfItems> createState() => _ListOfItemsState();
}

class _ListOfItemsState extends State<ListOfItems> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ItemsNotifier>(
        builder: (context, tasks, child) => ListView.builder(
          itemCount: tasks.items.length,
          itemBuilder: (context, index) {
            var item = tasks.items[index];
            return TodoItem(
              key: UniqueKey(),
              item: item,
            );
          },
        ),
      ),
    );
  }
}
