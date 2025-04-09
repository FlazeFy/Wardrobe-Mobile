import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/clothes/model/queries.dart';
import 'package:wardrobe/modules/helpers/converter.dart';

class DetailSectionSchedule extends StatefulWidget {
  const DetailSectionSchedule({Key? key, required this.schedule})
      : super(key: key);
  final List<ScheduleModel> schedule;

  @override
  StateDetailSectionScheduleState createState() =>
      StateDetailSectionScheduleState();
}

class StateDetailSectionScheduleState extends State<DetailSectionSchedule> {
  late ScheduleDataSource scheduleDataSource;
  @override
  void initState() {
    super.initState();
    scheduleDataSource = ScheduleDataSource(widget.schedule);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: greyColor,
            borderRadius: BorderRadius.all(Radius.circular(roundedLG))),
        padding: const EdgeInsets.all(spaceXMD),
        margin: const EdgeInsets.only(bottom: spaceMD),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const AtomsText(
              type: "content-title", text: "Schedule", color: blackColor),
          const AtomsText(
              type: "content-sub-title",
              text:
                  "You can set weekly schedule for a clothes, so we can remind you night before the day of use."),
          const SizedBox(
            height: spaceMD,
          ),
          SfDataGrid(
            source: scheduleDataSource,
            columns: [
              GridColumn(
                  columnName: 'day',
                  label: const Padding(
                      padding: EdgeInsets.all(spaceSM),
                      child: AtomsText(type: "input-label", text: "Day"))),
              GridColumn(
                  columnName: 'note',
                  label: const Padding(
                    padding: EdgeInsets.all(spaceSM),
                    child: AtomsText(type: "input-label", text: "Notes"),
                  )),
              GridColumn(
                columnName: 'createdAt',
                label: Container(
                  padding: const EdgeInsets.all(spaceSM),
                  alignment: Alignment.center,
                  child:
                      const AtomsText(type: "input-label", text: "Created At"),
                ),
              ),
              GridColumn(
                columnName: 'delete',
                label: Container(
                  padding: const EdgeInsets.all(spaceSM),
                  alignment: Alignment.center,
                  child: const AtomsText(type: "input-label", text: "Delete"),
                ),
              ),
            ],
            columnWidthMode: ColumnWidthMode.fill,
          ),
        ]));
  }
}

class ScheduleDataSource extends DataGridSource {
  late List<DataGridRow> _rows;

  ScheduleDataSource(List<ScheduleModel> schedules) {
    _rows = schedules.map((schedule) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'day', value: schedule.day),
        DataGridCell<String>(
            columnName: 'note', value: schedule.scheduleNote ?? '-'),
        DataGridCell<String>(
            columnName: 'createdAt',
            value: convertDatetimeBasedLocal(schedule.createdAt)),
        const DataGridCell<Widget>(
            columnName: 'delete',
            value: AtomsButton(
              type: "btn-icon",
              color: dangerBG,
              icon: FaIcon(
                FontAwesomeIcons.trash,
                color: whiteColor,
                size: textSM,
              ),
            )),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _rows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        return Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child:
              cell.value is Widget ? cell.value : Text(cell.value.toString()),
        );
      }).toList(),
    );
  }
}
