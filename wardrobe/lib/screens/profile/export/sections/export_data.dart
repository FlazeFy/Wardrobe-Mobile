import 'package:flutter/material.dart';
import 'package:wardrobe/organisms/o_export_box.dart';

class ExportSectionData extends StatefulWidget {
  const ExportSectionData({super.key});

  @override
  State<ExportSectionData> createState() => _ExportSectionDataState();
}

class _ExportSectionDataState extends State<ExportSectionData> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        OrganismsExportBox(
            title: "Clothes Data",
            desc:
                "All clothes data are separated into 2 section. The active clothes and the deleted clothes",
            ctx: "clothes",
            type: "excel"),
        OrganismsExportBox(
          title: "Clothes Used History Data",
          desc: "This also show history of deleted clothes",
          ctx: "clothes_used",
          type: "excel",
        ),
        OrganismsExportBox(
          title: "Wash History Data",
          desc: "This also show history of deleted clothes",
          ctx: "wash",
          type: "excel",
        ),
        OrganismsExportBox(
          title: "Apps History Data",
          desc: "All your activity within this apps",
          ctx: "history",
          type: "excel",
        ),
      ],
    );
  }
}
