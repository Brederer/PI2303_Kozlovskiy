import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab5/main.dart';

void main() {
  testWidgets('Lists app shows all list variants', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Работа со списками'), findsOneWidget);
    expect(find.text('Простой'), findsOneWidget);
    expect(find.text('Строки'), findsOneWidget);
    expect(find.text('Степени'), findsOneWidget);
    expect(find.text('Первая строка простого списка'), findsOneWidget);
    expect(find.text('Вторая строка простого списка'), findsOneWidget);
    expect(find.text('Третья строка простого списка'), findsOneWidget);

    await tester.tap(find.text('Строки'));
    await tester.pumpAndSettle();

    expect(find.text('Строка 1'), findsOneWidget);
    expect(find.text('Индекс элемента: 0'), findsOneWidget);

    await tester.tap(find.text('Степени'));
    await tester.pumpAndSettle();

    expect(find.text('2 ^ 0 = 1'), findsOneWidget);
    expect(find.text('Степень числа 2: 0'), findsOneWidget);
  });
}
