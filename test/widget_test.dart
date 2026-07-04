import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prm393_biopestcontrol/shared/widgets/custom_button.dart';

void main() {
  testWidgets('CustomButton renders and triggers onPressed', (WidgetTester tester) async {
    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            text: 'Test Button',
            icon: Icons.send,
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    expect(find.text('Test Button'), findsOneWidget);
    expect(find.byIcon(Icons.send), findsOneWidget);

    await tester.tap(find.text('Test Button'));
    await tester.pump();

    expect(pressed, isTrue);
  });
}
