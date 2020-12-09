import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/domain/models/all_branch_info.dart';
import 'package:flutter_internship_v2/presentation/views/branches_page/all_branch_card.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  
  group('Карточка всех задач', () {

    final allBranchesInfo = AllBranchesInfo(1, 2);

    testWidgets('Корректное отображение карточки с информацией'
        'о всех ветках', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AllBranchCard(
              allBranchesProgressInfo: allBranchesInfo,
            ),
          ),
        )
      );
      expect(find.text('Завершено 1 задач из 3'), findsOneWidget);
    });
    
  });
  
}