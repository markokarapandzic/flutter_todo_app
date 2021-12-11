// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app_test_project/models/item.dart';
import 'package:todo_app_test_project/state/items_notifier.dart';

void main() {
  group('ItemsNotifier', () {
    test('Has empty items list', () {
      ItemsNotifier testNotifier = ItemsNotifier();

      expect(testNotifier.items, []);
    });

    test('Has empty removedItems list', () {
      ItemsNotifier testNotifier = ItemsNotifier();

      expect(testNotifier.removedItems, []);
    });

    test('Should add item in items list', () {
      ItemsNotifier testNotifier = ItemsNotifier();

      var testItem = Item(name: 'Test Name', date: DateTime.now());
      testNotifier.addItem(testItem);

      expect(testNotifier.items, [testItem]);
    });

    test('Should remove item in items list and add to removedList', () {
      ItemsNotifier testNotifier = ItemsNotifier();

      var testItem = Item(name: 'Test Name', date: DateTime.now());
      var testItem2 = Item(name: 'Test Name 2', date: DateTime.now());
      testNotifier.addItem(testItem);
      testNotifier.addItem(testItem2);

      testNotifier.removeItem(testItem);

      expect(testNotifier.items, [testItem2]);
      expect(testNotifier.removedItems, [testItem]);
    });

    test('Should restore item from removedItems list and add it to items list',
        () {
      ItemsNotifier testNotifier = ItemsNotifier();

      var testItem = Item(name: 'Test Name', date: DateTime.now());
      var testItem2 = Item(name: 'Test Name 2', date: DateTime.now());
      var testItem3 = Item(name: 'Test Name 3', date: DateTime.now());
      testNotifier.addItem(testItem);
      testNotifier.addItem(testItem2);
      testNotifier.addItem(testItem3);

      testNotifier.removeItem(testItem2);
      testNotifier.removeItem(testItem3);

      testNotifier.restoreItem(testItem2);

      expect(testNotifier.items, [testItem, testItem2]);
      expect(testNotifier.removedItems, [testItem3]);
    });

    test('Should edit task name with provided new name', () {
      ItemsNotifier testNotifier = ItemsNotifier();

      Item oldItem = Item(name: 'Old Item', date: DateTime.now());

      testNotifier.addItem(oldItem);

      testNotifier.editTask(oldItem, 'New Item');

      oldItem.name = 'New Item';
      expect(testNotifier.items[0], oldItem);
    });
  });
}
