
import 'package:flutter_test/flutter_test.dart';
import 'package:skillbridge_ai/main.dart';

void main() {
  testWidgets('SkillBridge AI dashboard loads', (WidgetTester tester) async {
    await tester.pumpWidget(const SkillBridgeApp());

    expect(find.text('SkillBridge AI'), findsWidgets);
    expect(find.text('Welcome back, Sneha!'), findsOneWidget);
    expect(find.text('Career Readiness'), findsOneWidget);
    expect(find.text('Recommended Tasks'), findsOneWidget);
  });
}
