import 'package:flutter_test/flutter_test.dart';

import 'package:lab12/main.dart';

void main() {
  testWidgets('Coffee machine makes coffee and updates resources', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Кофемашина'), findsOneWidget);
    expect(find.text('Ресурсы'), findsOneWidget);
    expect(find.text('Кофе'), findsOneWidget);
    expect(find.text('Сервис'), findsOneWidget);

    await tester.tap(find.text('Кофе'));
    await tester.pumpAndSettle();

    expect(find.text('Эспрессо'), findsOneWidget);
    await tester.tap(find.text('Эспрессо'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Эспрессо готов. Цена: 100'), findsOneWidget);

    await tester.tap(find.text('Ресурсы'));
    await tester.pumpAndSettle();

    expect(find.text('Дисплей ресурсов'), findsOneWidget);
    expect(find.text('100 руб.'), findsOneWidget);

    await tester.tap(find.text('Сервис'));
    await tester.pumpAndSettle();

    expect(find.text('Обслуживание'), findsOneWidget);
    expect(find.text('Забрать деньги'), findsOneWidget);
  });
}
