import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/export/service/queries.dart';

class DetailSectionClothesExportData extends StatefulWidget {
  const DetailSectionClothesExportData({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  StateDetailSectionClothesExportDataState createState() =>
      StateDetailSectionClothesExportDataState();
}

class StateDetailSectionClothesExportDataState
    extends State<DetailSectionClothesExportData> {
  ExportQueriesService? apiQuery;
  @override
  void initState() {
    super.initState();
    apiQuery = ExportQueriesService();
  }

  @override
  Widget build(BuildContext context) {
    return AtomsButton(
      type: "btn-success",
      text: "Download PDF",
      icon: const FaIcon(
        FontAwesomeIcons.download,
        color: whiteColor,
        size: textXMD,
      ),
      action: () async {
        await apiQuery?.getExportPdfClothesDetail('clothes', widget.id);
      },
    );
  }
}
