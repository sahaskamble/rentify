import 'package:flutter_test/flutter_test.dart';

import 'package:rentify/main.dart';

void main() {
  testWidgets('Rentify app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const RentifyApp());
    expect(find.text('Rentify'), findsOneWidget);
  });
}
