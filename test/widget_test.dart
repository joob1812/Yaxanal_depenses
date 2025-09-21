import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaxanal_depenses/main.dart';

void main() {
  testWidgets('L\'application se lance correctement', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Yaxanal Dépenses'), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
  });
}
