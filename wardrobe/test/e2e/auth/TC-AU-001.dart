import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/screens/home/index.dart';
import 'package:wardrobe/screens/landing/index.dart';

void main() {
  String username = "flazefy";
  String password = "nopass123";

  testWidgets('TC-AU-001 - User Can Login With Valid Credential',
      (WidgetTester tester) async {
    // Step 1: Visit Login Page
    await tester.pumpWidget(const GetMaterialApp(home: LoginPage()));
    await tester.pump();

    // Step 2: Fill in Login form
    expect(find.text("Username"), findsOneWidget);
    await tester.enterText(find.byKey(const Key('username-input')), username);
    expect(find.text("Password"), findsOneWidget);
    await tester.enterText(find.byKey(const Key('password-input')), password);
    await tester.pump();

    // Step 3: Tap Submit button and after validation success you will be redirected to Dashboard Screen
    await tester.tap(find.widgetWithText(AtomsButton, "Sign In"));
    await tester.pump(const Duration(milliseconds: 3000));
    // Expected Result
    expect(find.byType(HomePage), findsOneWidget);
  });
}
