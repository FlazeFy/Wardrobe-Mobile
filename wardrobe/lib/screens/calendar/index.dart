import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/screens/calendar/sections/calendar_export_data.dart';
import 'package:wardrobe/screens/calendar/sections/calendar_schedule.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  StateCalendarPageState createState() => StateCalendarPageState();
}

class StateCalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding:
          const EdgeInsets.symmetric(horizontal: spaceMD, vertical: spaceJumbo),
      children: const [
        CalendarSectionExportData(year: 2025),
        CalendarSectionSchedule()
      ],
    ));
  }
}
