import 'package:flutter_test/flutter_test.dart';
import 'package:full_stack_app/app.dart';

void main() {
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('T'), findsOneWidget);
    expect(find.text('M'), findsOneWidget);
  });
}