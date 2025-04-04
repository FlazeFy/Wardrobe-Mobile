import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wardrobe/screens/home/index.dart';
import 'package:wardrobe/screens/landing/index.dart';

void main() {
  testWidgets('TC-ST-003 - User Can See Summary Of Apps',
      (WidgetTester tester) async {
    // Step 1: Visit Login Page
    await tester.pumpWidget(const GetMaterialApp(home: LoginPage()));
    await tester.pump();

    // Step 2: At the section with title "Effortless style" (Motto), Find title "Active User", "Outfit Decision", "Clothes", and "Schedule Reminder"
    expect(find.text("Effortless style"), findsOneWidget);
    List<String> summaryHolder = [
      "Active User",
      "Outfit Decision",
      "Clothes",
      "Schedule Reminder"
    ];
    for (var dt in summaryHolder) {
      expect(find.text(dt), findsOneWidget);
    }
    List<String> summaryValueKeyHolder = [
      "total-user-text",
      "total-schedule-text",
      "total-outfit-text",
      "total-clothes-text"
    ];
    // Validate the valid total
    for (var dt in summaryValueKeyHolder) {
      final finder = find.byKey(Key(dt));
      expect(finder, findsOneWidget);

      final textWidget = tester.widget<Text>(finder);
      final rawText = textWidget.data ?? '';
      final cleanText = rawText.replaceAll(' +', '');
      final value = int.tryParse(cleanText);

      expect(value != null && value >= 0, isTrue);
    }

    // Expected Result
    expect(find.byType(HomePage), findsOneWidget);
  });
}
