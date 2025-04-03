import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/history/model/queries.dart';
import 'package:wardrobe/modules/helpers/converter.dart';

class OrganismsHistoryBox extends StatelessWidget {
  final HistoryModel item;

  const OrganismsHistoryBox({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.only(bottom: spaceMD),
      decoration: BoxDecoration(
          color: greyColor,
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.25),
              blurRadius: spaceLG,
              spreadRadius: 0.0,
              offset: const Offset(
                spaceMini,
                spaceMini,
              ),
            )
          ],
          borderRadius: const BorderRadius.all(Radius.circular(roundedLG))),
      padding: const EdgeInsets.all(spaceMD),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AtomsText(
                  type: "content-title",
                  text: "${item.historyType} ${item.historyContext}"),
              AtomsText(
                  type: "content-sub-title",
                  text: "At ${convertDatetimeBasedLocal(item.createdAt)}")
            ],
          )
        ],
      ),
    );
  }
}
