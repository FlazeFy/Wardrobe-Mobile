import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/molecules/m_top_bar.dart';
import 'package:wardrobe/screens/profile/export/view_excel/sections/view_excel_table.dart';

class ViewExportedExcelPage extends StatefulWidget {
  final String filePath;

  const ViewExportedExcelPage({Key? key, required this.filePath})
      : super(key: key);

  @override
  StateViewExportedExcelPageState createState() =>
      StateViewExportedExcelPageState();
}

class StateViewExportedExcelPageState extends State<ViewExportedExcelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: MoleculesTopBar(title: "View Exported Excel")),
        body: ListView(
          padding: const EdgeInsets.symmetric(
              horizontal: spaceMD, vertical: spaceSM),
          children: [ViewExcelSectionTable(filePath: widget.filePath)],
        ));
  }
}
