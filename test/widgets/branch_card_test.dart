import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/constants/my_themes_colors.dart';
import 'package:flutter_internship_v2/domain/models/one_branch_info.dart';
import 'package:flutter_internship_v2/presentation/views/branches_page/one_branch_card.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  
  group('Карточка ветки задач', () {
    
    final id = 'id1';
    final title = 'title1';
    final countCompleted = 1;
    final countUncompleted = 2;
    final completedColor = themes[0].keys.toList().first;
    final backgroundColor = themes[0].values.toList().first;
    final branchInfo = OneBranchInfo(
        id,
        title, 
        countCompleted, 
        countUncompleted,
        completedColor, 
        backgroundColor
    );
    
    testWidgets('Корректное отображение количества задач', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OneBranchCard(
              branchInfo: branchInfo,
            ),
          ),
        )
      );
      await tester.pumpAndSettle();
      expect(find.text(title), findsOneWidget);
      expect(find.text('${countCompleted+countUncompleted} задач(и)'), findsOneWidget);
      expect(find.text('$countCompleted сделано'), findsOneWidget);
      expect(find.text('$countUncompleted осталось'), findsOneWidget);
    });
    
  });
  
}