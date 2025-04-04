import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/organisms/o_bottom_bar.dart';
import 'package:wardrobe/screens/profile/index.dart';

void main() {
  testWidgets('TC-QU-001 - User Can Send Question in "Ask A Question" section',
      (WidgetTester tester) async {
    // Step 1: After Signed In. In the Navbar, Tap the menu button that contain Profile Icon to open the Profile Page
    await tester.pumpWidget(const GetMaterialApp(home: OrganismsBottomBar()));
    await tester.pump();
    await tester.tap(find.byWidgetPredicate(
      (widget) => widget is FaIcon && widget.icon == FontAwesomeIcons.user,
    ));
    await tester.pump();
    expect(find.byType(ProfilePage), findsOneWidget);

    // Step 2: In the "Ask A Question" section, user can see form question
    expect(find.text("Ask A Question"), findsOneWidget);

    // Step 3: Enter a question in the input field
    await tester.enterText(find.byKey(const Key('question-body-input')),
        "How does this app work?");
    await tester.pump();

    // Step 4: Tap the "Send Question" button
    await tester.tap(find.widgetWithText(AtomsButton, "Send Question"));
    await tester.pump();

    // Step 5: A Pop Up Success will appear. Then tap "OK"
    // check again
    await tester.pump(const Duration(seconds: 5));
    expect(find.byKey(const Key('success-add-question-popup')), findsOneWidget);
    expect(find.textContaining("Success").first, findsOneWidget,
        reason: "question created");
    await tester.tap(find.widgetWithText(InkWell, "OK"));
    await tester.pumpAndSettle();
  });
}
