import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/export/service/queries.dart';

class CalendarSectionExportData extends StatefulWidget {
  const CalendarSectionExportData({
    Key? key,
    required this.year,
  }) : super(key: key);
  final int year;

  @override
  StateCalendarSectionExportDataState createState() =>
      StateCalendarSectionExportDataState();
}

class StateCalendarSectionExportDataState
    extends State<CalendarSectionExportData> {
  ExportQueriesService? apiQuery;
  @override
  void initState() {
    super.initState();
    apiQuery = ExportQueriesService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(spaceLG),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(roundedXLG)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [infoBG, primaryLightBG],
          ),
        ),
        child: Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AtomsText(
                  type: "content-sub-title",
                  text: "Export Data",
                  color: whiteColor),
              const SizedBox(
                height: spaceMini,
              ),
              AtomsButton(
                type: "btn-success",
                text: "Download Excel",
                action: () async {
                  await apiQuery
                      ?.getExportExcelCalendar(widget.year); // for now
                },
                icon: const FaIcon(
                  FontAwesomeIcons.download,
                  size: textMD,
                  color: whiteColor,
                ),
              )
            ],
          )
        ]));
  }
}
