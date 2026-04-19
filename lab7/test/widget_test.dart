import 'package:flutter_test/flutter_test.dart';

import 'package:lab7/main.dart';

void main() {
  testWidgets('App navigates to question screen and returns selected answer', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Первый экран'), findsOneWidget);
    expect(find.text('Перейти ко второму экрану'), findsOneWidget);

    await tester.tap(find.text('Перейти ко второму экрану'));
    await tester.pumpAndSettle();

    expect(find.text('Второй экран'), findsOneWidget);
    expect(find.text('Да'), findsOneWidget);
    expect(find.text('Нет'), findsOneWidget);

    await tester.tap(find.text('Да'));
    await tester.pumpAndSettle();

    expect(find.text('Первый экран'), findsOneWidget);
    expect(find.text('Ваш выбор: Да'), findsOneWidget);
  });
}
