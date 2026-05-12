import 'package:flutter_test/flutter_test.dart';
import 'package:deenapp/app/app.dart';

void main() {
  testWidgets('DeenApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DeenApp());
  });
}
