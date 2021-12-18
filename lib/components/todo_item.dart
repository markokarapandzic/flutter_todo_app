import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_test_project/models/item.dart';
import 'package:todo_app_test_project/state/items_notifier.dart';

class TodoItem extends StatefulWidget {
  final Item item;

  const TodoItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  final TextEditingController taskNameInputController = TextEditingController();

  @override
  void dispose() {
    taskNameInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.list),
            title: Text(widget.item.name),
            subtitle: Text(widget.item.date.toString()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                key: const ValueKey('EditBtn'),
                child: const Text('EDIT'),
                onPressed: () =>
                    showEditModal(context, taskNameInputController),
              ),
              const SizedBox(width: 8),
              TextButton(
                key: const ValueKey('DeleteBtn'),
                child: const Text('DELETE'),
                onPressed: () => removeItem(context),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }

  void removeItem(BuildContext context) {
    ItemsNotifier itemsNotifier =
        Provider.of<ItemsNotifier>(context, listen: false);
    itemsNotifier.removeItem(widget.item);
  }

  Future<dynamic> showEditModal(
      BuildContext context, TextEditingController taskNameInputController) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Wrap(
            children: [
              TextFormField(
                key: const ValueKey('ModalChangeInput'),
                controller: taskNameInputController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Change task name',
                ),
              ),
              const SizedBox(
                height: 80.0,
              ),
              Center(
                child: InkWell(
                  key: const ValueKey('ChangeModalBtn'),
                  onTap: () => editItem(context, taskNameInputController),
                  child: Ink(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      'CHANGE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void editItem(
      BuildContext context, TextEditingController taskNameInputController) {
    ItemsNotifier itemsNotifier =
        Provider.of<ItemsNotifier>(context, listen: false);
    itemsNotifier.editTask(widget.item, taskNameInputController.text);
    Navigator.pop(context);
  }
}
