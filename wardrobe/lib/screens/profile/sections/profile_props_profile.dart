import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/helpers/converter.dart';

class ProfileSectionPropsProfile extends StatelessWidget {
  final String createdAt;
  final String? updatedAt;

  const ProfileSectionPropsProfile(
      {super.key, required this.createdAt, this.updatedAt});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(spaceLG),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(roundedXLG)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [infoBG, primaryLightBG],
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          AtomsText(
              type: "content-title",
              text: convertDatetimeBasedLocal(createdAt),
              color: blackColor),
          const SizedBox(width: spaceXXSM),
          const Row(
            children: [
              AtomsText(type: "content-title-main", text: "Joined"),
              SizedBox(width: spaceXXSM),
              AtomsText(
                  type: "content-title-main", text: "Since", color: blackColor),
            ],
          ),
        ]),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AtomsText(
                  type: "content-title-main", text: "Last", color: blackColor),
              SizedBox(width: spaceMini),
              AtomsText(type: "content-title-main", text: "Updated"),
            ],
          ),
          const SizedBox(width: spaceXXSM),
          AtomsText(
              type: "content-title",
              text: updatedAt != null
                  ? convertDatetimeBasedLocal(updatedAt ?? "")
                  : "-",
              color: blackColor),
        ])
      ]),
    );
  }
}
