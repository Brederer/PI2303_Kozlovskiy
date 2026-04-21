import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab12/main.dart';

void main() {
  testWidgets('Coffee machine follows updated lab 12 layout', (tester) async {
    final binding = tester.binding;
    await binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => binding.setSurfaceSize(null));

    await tester.pumpWidget(const MyApp());

    expect(find.text('Coffee Machine'), findsOneWidget);
    expect(find.text('Coffee Maker'), findsOneWidget);
    expect(find.text('Your money: 0'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).first, '100');
    await tester.tap(find.byIcon(Icons.attach_money));
    await tester.pump();

    expect(find.text('Your money: 100'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.play_arrow_rounded));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('espresso is ready. Price: 100'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.local_shipping_outlined).first);
    await tester.pumpAndSettle();

    expect(find.text('Resources:'), findsOneWidget);
    expect(find.text('put milk'), findsOneWidget);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), '-1');
    await tester.enterText(fields.at(1), '10');
    await tester.enterText(fields.at(2), '10');
    await tester.enterText(fields.at(3), '10');

    await tester.tap(find.text('+'));
    await tester.pump();

    expect(find.text('Enter a non-negative number'), findsOneWidget);
  });
}
