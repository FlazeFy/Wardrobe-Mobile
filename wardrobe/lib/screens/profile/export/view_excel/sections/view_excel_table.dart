import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';

class ViewExcelSectionTable extends StatefulWidget {
  final String filePath;

  const ViewExcelSectionTable({Key? key, required this.filePath})
      : super(key: key);

  @override
  State<ViewExcelSectionTable> createState() => _ViewExcelSectionTableState();
}

class _ViewExcelSectionTableState extends State<ViewExcelSectionTable> {
  List<DataGridRow> rows = [];
  List<String> columns = [];
  late TableDataSource _dataSource;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadExcelData();
  }

  void _loadExcelData() {
    final bytes = File(widget.filePath).readAsBytesSync();
    final excel = Excel.decodeBytes(bytes);

    final sheet = excel.tables[excel.tables.keys.first];
    if (sheet == null) return;

    columns =
        sheet.rows.first.map((cell) => cell?.value.toString() ?? '').toList();

    rows = sheet.rows.skip(1).map((row) {
      return DataGridRow(
        cells: List.generate(columns.length, (index) {
          final value =
              index < row.length ? row[index]?.value.toString() ?? '' : '';
          return DataGridCell<String>(columnName: columns[index], value: value);
        }),
      );
    }).toList();

    _dataSource = TableDataSource(rows: rows);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : SfDataGrid(
            source: _dataSource,
            columnWidthMode: ColumnWidthMode.auto,
            columns: columns.map((col) {
              return GridColumn(
                columnName: col,
                label: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(spaceSM),
                  child: AtomsText(
                      type: "content-sub-title", text: col, color: blackColor),
                ),
              );
            }).toList(),
          );
  }
}

class TableDataSource extends DataGridSource {
  final List<DataGridRow> _dataGridRows;

  TableDataSource({required List<DataGridRow> rows}) : _dataGridRows = rows;

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((dt) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(spaceSM),
          child: AtomsText(
              type: "content-body",
              text: dt.value.toString(),
              color: blackColor),
        );
      }).toList(),
    );
  }
}
