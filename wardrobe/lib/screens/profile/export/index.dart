import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/molecules/m_top_bar.dart';
import 'package:wardrobe/screens/profile/export/sections/export_data.dart';

class ExportMyDataPage extends StatefulWidget {
  const ExportMyDataPage({Key? key}) : super(key: key);

  @override
  StateExportMyDataPageState createState() => StateExportMyDataPageState();
}

class StateExportMyDataPageState extends State<ExportMyDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: MoleculesTopBar(title: "Export My Data")),
        body: ListView(
          padding: const EdgeInsets.symmetric(
              horizontal: spaceMD, vertical: spaceSM),
          children: const [ExportSectionData()],
        ));
  }
}
