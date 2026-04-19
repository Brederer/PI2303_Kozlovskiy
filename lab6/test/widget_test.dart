import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab6/main.dart';

void main() {
  testWidgets('Area calculator validates input and calculates area', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Калькулятор площади'), findsOneWidget);
    expect(find.text('Ширина'), findsOneWidget);
    expect(find.text('Высота'), findsOneWidget);
    expect(find.text('S = ширина * высота = результат'), findsOneWidget);

    await tester.tap(find.text('Вычислить'));
    await tester.pump();

    expect(find.text('Пожалуйста, введите значение'), findsNWidgets(2));

    await tester.enterText(find.byType(EditableText).first, 'abc');
    await tester.enterText(find.byType(EditableText).last, '5');
    await tester.tap(find.text('Вычислить'));
    await tester.pump();

    expect(find.text('Введите числовое значение'), findsOneWidget);

    await tester.enterText(find.byType(EditableText).first, '4');
    await tester.enterText(find.byType(EditableText).last, '5');
    await tester.tap(find.text('Вычислить'));
    await tester.pump();

    expect(find.text('S = 4 * 5 = 20'), findsOneWidget);
    expect(find.text('Площадь успешно вычислена'), findsOneWidget);
  });
}
