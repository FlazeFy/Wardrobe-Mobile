import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/export/service/queries.dart';

class OrganismsExportBox extends StatefulWidget {
  const OrganismsExportBox(
      {super.key,
      required this.title,
      required this.desc,
      required this.ctx,
      required this.type});
  final String title;
  final String desc;
  final String ctx;
  final String type;

  @override
  StateOrganismsExportBox createState() => StateOrganismsExportBox();
}

class StateOrganismsExportBox extends State<OrganismsExportBox> {
  late ExportQueriesService apiQuery;
  String allMsg = "";
  bool isLoadPost = false;

  @override
  void initState() {
    super.initState();
    apiQuery = ExportQueriesService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(spaceMD),
      margin: const EdgeInsets.only(bottom: spaceMD),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(roundedLG)),
          border: Border.all(width: spaceMini / 3, color: blackColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AtomsText(
              type: "content-title", text: widget.title, color: blackColor),
          AtomsText(
              type: "content-body", text: widget.desc, color: shadowColor),
          const SizedBox(height: spaceMD),
          Row(
            children: [
              AtomsButton(
                  type: 'btn-success',
                  text: "Download ${widget.type}",
                  action: () async {
                    await apiQuery.getExportExcel(widget.ctx, widget.type);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.download,
                    color: whiteColor,
                    size: spaceXMD,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
