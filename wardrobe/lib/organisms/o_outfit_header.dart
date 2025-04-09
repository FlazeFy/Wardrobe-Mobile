import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/clothes/model/queries.dart';
import 'package:wardrobe/modules/helpers/converter.dart';

class OrganismsOutfitBox extends StatefulWidget {
  const OrganismsOutfitBox({super.key, required this.data});
  final OutfitModel? data;
  @override
  StateOrganismsOutfitBox createState() => StateOrganismsOutfitBox();
}

class StateOrganismsOutfitBox extends State<OrganismsOutfitBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(spaceMD),
          margin: const EdgeInsets.only(bottom: spaceMD),
          width: Get.width,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(roundedLG)),
              color: lightInfoBG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AtomsText(
                  type: "content-title",
                  text: "${widget.data?.outfitName}",
                  color: blackColor),
              widget.data?.outfitNote != null
                  ? AtomsText(
                      type: "content-body",
                      text: "${widget.data?.outfitNote}",
                      color: blackColor)
                  : const AtomsText(
                      type: "no-data",
                      text: "No Notes Provided",
                      color: darkColor,
                    ),
              const SizedBox(height: spaceSM),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AtomsText(
                          type: "content-sub-title",
                          text: "Total Used",
                          color: blackColor),
                      AtomsText(
                          type: "content-sub-title",
                          text: "${widget.data?.totalUsed}",
                          color: shadowColor),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const AtomsText(
                          type: "content-sub-title",
                          text: "Last Used",
                          color: blackColor),
                      AtomsText(
                          type: "content-sub-title",
                          text: widget.data?.lastUsed != null
                              ? convertDatetimeBasedLocal(
                                  widget.data?.lastUsed ?? "_")
                              : "-",
                          color: shadowColor),
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
