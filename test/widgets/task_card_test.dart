import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/domain/models/task_card_info.dart';
import 'package:flutter_internship_v2/presentation/constants/my_themes_colors.dart';
import 'package:flutter_internship_v2/presentation/views/all_tasks_page/task_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('Страница выбранной ветки задач', () {

    final taskID1 = 'id1';
    final taskID2 = 'id2';
    final branchID = 'brId1';

    final stepTextTask1 = '0 из 2';
    final stepTextTask2 = '1 из 2';

    final task1 = TaskCardInfo(taskID1, 'title1', 0, 2, false);
    final task2 = TaskCardInfo(taskID2, 'title2', 1, 2, true);


    final taskList = {
      taskID1 : task1,
      taskID2 : task2,
    };

    testWidgets('Разные состояния чекбокса при разных входных данных', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskList(
              isFiltred: false,
              theme: themes[0],
              taskList: taskList,
              branchID: branchID,
              updateBranchesInfo: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byWidgetPredicate((widget) => widget is CircularCheckBox && widget.value), findsOneWidget);
      expect(find.byWidgetPredicate((widget) => widget is CircularCheckBox && !widget.value), findsOneWidget);
    });

    testWidgets('Разные состояния карточки таска (информации о её внутренних'
        'задачах) при разных входных данных', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskList(
              isFiltred: false,
              theme: themes[0],
              taskList: taskList,
              branchID: branchID,
              updateBranchesInfo: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text(stepTextTask1), findsOneWidget);
      expect(find.text(stepTextTask2), findsOneWidget);
    });

  });

}