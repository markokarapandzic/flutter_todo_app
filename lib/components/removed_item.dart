import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_test_project/models/item.dart';
import 'package:todo_app_test_project/state/items_notifier.dart';

class RemovedItem extends StatefulWidget {
  final Item item;

  const RemovedItem({Key? key, required this.item}) : super(key: key);

  @override
  State<RemovedItem> createState() => _RemovedItemState();
}

class _RemovedItemState extends State<RemovedItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          tileColor: Colors.blue[400],
          title: Text(widget.item.name),
          trailing: InkWell(
            key: const ValueKey('RestoreBtn'),
            onTap: () => restoreItem(context),
            child: Ink(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'RESTORE',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        )
      ],
    );
  }

  void restoreItem(BuildContext context) {
    ItemsNotifier itemsNotifier =
        Provider.of<ItemsNotifier>(context, listen: false);
    itemsNotifier.restoreItem(widget.item);
  }
}
