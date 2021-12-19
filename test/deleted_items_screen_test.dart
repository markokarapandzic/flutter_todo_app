import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_test_project/main.dart';
import 'package:todo_app_test_project/state/items_notifier.dart';

void main() {
  group('Deleted Items Screen', () {
    testWidgets('Should go to deleted items screen',
        (WidgetTester tester) async {
      final goToDeletedItemsBtn =
          find.byKey(const ValueKey('GoToDeletedItemsBtn'));

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => ItemsNotifier(),
          child: const MaterialApp(
            home: MyHome(),
          ),
        ),
      );

      await tester.tap(goToDeletedItemsBtn);
      await tester.pumpAndSettle();

      final deletedItemsText = find.text('Deleted Items');

      expect(deletedItemsText, findsOneWidget);
    });

    testWidgets('Should show deleted item on Deleted Items screen',
        (WidgetTester tester) async {
      final goToDeletedItemsBtn =
          find.byKey(const ValueKey('GoToDeletedItemsBtn'));
      final deleteBtn = find.byKey(const ValueKey('DeleteBtn'));
      final input = find.byKey(const ValueKey('ItemInput'));
      final addBtn = find.byKey(const ValueKey('AddBtn'));

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => ItemsNotifier(),
          child: const MaterialApp(
            home: MyHome(),
          ),
        ),
      );

      await tester.enterText(input, 'Test Item');
      await tester.tap(addBtn);
      await tester.pump();
      await tester.tap(deleteBtn);

      await tester.tap(goToDeletedItemsBtn);
      await tester.pumpAndSettle();

      final deletedItemText = find.text('Test Item');

      expect(deletedItemText, findsOneWidget);
    });

    testWidgets('Should show restored item back in Items List',
        (WidgetTester tester) async {
      final goToDeletedItemsBtn =
          find.byKey(const ValueKey('GoToDeletedItemsBtn'));
      final deleteBtn = find.byKey(const ValueKey('DeleteBtn'));
      final input = find.byKey(const ValueKey('ItemInput'));
      final addBtn = find.byKey(const ValueKey('AddBtn'));
      final restoreBtn = find.byKey(const ValueKey('RestoreBtn'));

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => ItemsNotifier(),
          child: const MaterialApp(
            home: MyHome(),
          ),
        ),
      );

      await tester.enterText(input, 'Test Item');
      await tester.tap(addBtn);
      await tester.pump();
      await tester.tap(deleteBtn);

      await tester.tap(goToDeletedItemsBtn);
      await tester.pumpAndSettle();

      final deletedItemOnDeletedScreen = find.text('Test Item');

      await tester.tap(restoreBtn);
      await tester.pageBack();
      await tester.pumpAndSettle();

      final deletedItemText = find.text('Test Item');

      expect(deletedItemOnDeletedScreen, findsOneWidget);
      expect(deletedItemText, findsOneWidget);
    });
  });
}
