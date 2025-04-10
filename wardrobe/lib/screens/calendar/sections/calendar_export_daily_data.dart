import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/export/service/queries.dart';

class CalendarSectionExportDailyData extends StatefulWidget {
  const CalendarSectionExportDailyData({
    Key? key,
    required this.date,
  }) : super(key: key);
  final String date;

  @override
  StateCalendarSectionExportDailyDataState createState() =>
      StateCalendarSectionExportDailyDataState();
}

class StateCalendarSectionExportDailyDataState
    extends State<CalendarSectionExportDailyData> {
  ExportQueriesService? apiQuery;
  @override
  void initState() {
    super.initState();
    apiQuery = ExportQueriesService();
  }

  String convertDate(String input) {
    final inputFormat = DateFormat('dd MMM yyyy');
    final outputFormat = DateFormat('yyyy-MM-dd');
    final dateTime = inputFormat.parse(input);
    return outputFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: AtomsButton(
      type: "btn-primary",
      action: () async {
        await apiQuery?.getExportPdfCalendarDaily(
            'clothes', convertDate(widget.date));
      },
      icon: const FaIcon(
        FontAwesomeIcons.print,
        size: textMD,
        color: whiteColor,
      ),
    ));
  }
}
