import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app_test_project/components/todo_item.dart';
import 'package:todo_app_test_project/models/item.dart';

void main() {
  testWidgets('Should render on screen', (WidgetTester tester) async {
    DateTime date = DateTime.now();
    Item testItem = Item(name: 'Test Item', date: date);

    await tester.pumpWidget(MaterialApp(home: TodoItem(item: testItem)));

    final taskName = find.text(testItem.name);
    final taskDate = find.text(testItem.date.toString());

    expect(taskName, findsOneWidget);
    expect(taskDate, findsOneWidget);
  });
}
