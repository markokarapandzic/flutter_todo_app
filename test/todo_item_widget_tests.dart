import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_test_project/components/todo_item.dart';
import 'package:todo_app_test_project/models/item.dart';
import 'package:todo_app_test_project/screens/home.dart';
import 'package:todo_app_test_project/state/items_notifier.dart';

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

  testWidgets('Should add a new todo to list', (WidgetTester tester) async {
    final input = find.byKey(const ValueKey('ItemInput'));
    final addBtn = find.byKey(const ValueKey('AddBtn'));

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ItemsNotifier(),
        child: const MaterialApp(
          home: Scaffold(
            body: HomeScreen(),
          ),
        ),
      ),
    );

    await tester.enterText(input, 'Test Item');
    await tester.tap(addBtn);
    await tester.pump();

    final taskName = find.text('Test Item');

    expect(taskName, findsOneWidget);
  });
}
