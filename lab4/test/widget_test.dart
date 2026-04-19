import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab4/main.dart';

void main() {
  testWidgets('Campus page shows layout and handles actions', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Верстка интерфейса'), findsOneWidget);
    expect(find.text('Студенческий городок Кубанского ГАУ'), findsOneWidget);
    expect(find.text('Позвонить'), findsOneWidget);
    expect(find.text('Маршрут'), findsOneWidget);
    expect(find.text('Поделиться'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.text('41'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.text('42'), findsOneWidget);

    await tester.tap(find.text('Позвонить'));
    await tester.pump();

    expect(find.text('Выбрано действие: Позвонить'), findsOneWidget);
  });
}
