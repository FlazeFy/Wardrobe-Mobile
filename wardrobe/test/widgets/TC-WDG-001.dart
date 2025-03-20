import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/organisms/o_bottom_bar.dart';
import 'package:wardrobe/screens/calendar/index.dart';
import 'package:wardrobe/screens/clothes/index.dart';
import 'package:wardrobe/screens/home/index.dart';
import 'package:wardrobe/screens/profile/index.dart';
import 'package:wardrobe/screens/stats/index.dart';

void main() {
  testWidgets('TC-WDG-001 - Validate The Menu List For A Signed User',
      (WidgetTester tester) async {
    // Step 1: Visit the Home screen
    await tester.pumpWidget(
      const GetMaterialApp(
        home: OrganismsBottomBar(),
      ),
    );

    await tester.pump();

    // Step 2: Check if navbar exists
    expect(find.byType(OrganismsBottomBar), findsOneWidget);

    // Step 3: Validate menu items
    expect(find.byType(HomePage), findsOneWidget);
    await tester.tap(find.byWidgetPredicate(
      (widget) => widget is FaIcon && widget.icon == FontAwesomeIcons.shirt,
    ));

    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byType(ClothesPage), findsOneWidget);

    await tester.tap(find.byWidgetPredicate(
      (widget) => widget is FaIcon && widget.icon == FontAwesomeIcons.calendar,
    ));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byType(CalendarPage), findsOneWidget);

    await tester.tap(find.byWidgetPredicate(
      (widget) =>
          widget is FaIcon && widget.icon == FontAwesomeIcons.chartSimple,
    ));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byType(StatsPage), findsOneWidget);

    await tester.tap(find.byWidgetPredicate(
      (widget) => widget is FaIcon && widget.icon == FontAwesomeIcons.user,
    ));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byType(ProfilePage), findsOneWidget);
  });
}
