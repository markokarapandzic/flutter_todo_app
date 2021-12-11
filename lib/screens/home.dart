import 'package:flutter/material.dart';
import 'package:todo_app_test_project/components/list_of_items.dart';

import '../components/input_control.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            InputControl(),
            SizedBox(
              height: 20,
            ),
            Text(
              'Todo List:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListOfItems()
          ],
        ),
      ),
    );
  }
}
