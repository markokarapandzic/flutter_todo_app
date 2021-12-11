import 'package:flutter/foundation.dart';
import 'package:todo_app_test_project/models/item.dart';

class ItemsNotifier with ChangeNotifier {
  List<Item> items = [];
  List<Item> removedItems = [];

  void addItem(Item item) {
    items.add(item);
    notifyListeners();
  }

  void removeItem(Item item) {
    removedItems.add(item);
    items.remove(item);
    notifyListeners();
  }

  void restoreItem(Item item) {
    removedItems.remove(item);
    items.add(item);
    notifyListeners();
  }

  void editTask(Item item, String name) {
    int index = items.indexOf(item);
    item.name = name;
    items[index] = item;
    notifyListeners();
  }
}
