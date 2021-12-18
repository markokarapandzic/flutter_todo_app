import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_test_project/components/todo_item.dart';
import 'package:todo_app_test_project/models/item.dart';
import 'package:todo_app_test_project/screens/home.dart';
import 'package:todo_app_test_project/state/items_notifier.dart';

void main() {
  group('ListItems Screen', () {
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

    testWidgets('Should delete added task', (WidgetTester tester) async {
      final input = find.byKey(const ValueKey('ItemInput'));
      final addBtn = find.byKey(const ValueKey('AddBtn'));
      final deleteBtn = find.byKey(const ValueKey('DeleteBtn'));

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

      await tester.tap(deleteBtn);
      await tester.pump();

      final taskName = find.text('Test Item');

      expect(taskName, findsNothing);
    });

    testWidgets('Should not show edit modal when not activated',
        (WidgetTester tester) async {
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

      final editModalTitle = find.text('Change task name');

      expect(editModalTitle, findsNothing);
    });

    testWidgets('Should show edit modal', (WidgetTester tester) async {
      final input = find.byKey(const ValueKey('ItemInput'));
      final addBtn = find.byKey(const ValueKey('AddBtn'));
      final editBtn = find.byKey(const ValueKey('EditBtn'));

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

      await tester.tap(editBtn);
      await tester.pumpAndSettle();

      final editModalTitle = find.text('Change task name');

      expect(editModalTitle, findsOneWidget);
    });

    testWidgets('Should edit created task', (WidgetTester tester) async {
      final input = find.byKey(const ValueKey('ItemInput'));
      final addBtn = find.byKey(const ValueKey('AddBtn'));
      final editBtn = find.byKey(const ValueKey('EditBtn'));
      final changeModalBtn = find.byKey(const ValueKey('ChangeModalBtn'));
      final modalChangeInput = find.byKey(const ValueKey('ModalChangeInput'));

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

      await tester.tap(editBtn);
      await tester.pumpAndSettle();

      await tester.enterText(modalChangeInput, 'New Task Name');
      await tester.tap(changeModalBtn);
      await tester.pumpAndSettle();

      final changedTaskName = find.text('New Task Name');

      expect(changedTaskName, findsOneWidget);
    });
  });
}
