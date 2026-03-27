import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify/main.dart';

void main() {
  testWidgets('Main app renders', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MainApp()));

    expect(find.byType(MainApp), findsOneWidget);
  });
}
