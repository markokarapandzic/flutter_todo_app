import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_test_project/models/item.dart';
import 'package:todo_app_test_project/state/items_notifier.dart';

class InputControl extends StatefulWidget {
  const InputControl({
    Key? key,
  }) : super(key: key);

  @override
  State<InputControl> createState() => _InputControlState();
}

class _InputControlState extends State<InputControl> {
  final TextEditingController taskInputController = TextEditingController();

  @override
  void dispose() {
    taskInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: TextFormField(
            key: const ValueKey('ItemInput'),
            controller: taskInputController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter a Task',
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          key: const ValueKey('AddBtn'),
          onTap: () {
            onTaskCreate(context);
          },
          child: Ink(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              'ADD',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    );
  }

  void onTaskCreate(BuildContext context) {
    if (taskInputController.text == '') {
      return;
    }

    ItemsNotifier itemsNotifier =
        Provider.of<ItemsNotifier>(context, listen: false);

    Item newItem = Item(
      name: taskInputController.text,
    );
    itemsNotifier.addItem(newItem);

    taskInputController.text = '';
  }
}
