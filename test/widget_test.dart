import 'package:flutter_test/flutter_test.dart';
import 'package:tanora_app/main.dart'; // Change 'tanora_app' if your project name is different

void main() {
  testWidgets('TanOra Load Test', (WidgetTester tester) async {
    await tester.pumpWidget(const TanOraApp());
    expect(find.byType(TanOraApp), findsOneWidget);
  });
}