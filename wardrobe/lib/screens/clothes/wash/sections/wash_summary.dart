import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/stats/model/queries.dart';
import 'package:wardrobe/modules/api/stats/services/queries.dart';
import 'package:wardrobe/modules/helpers/converter.dart';

class WashSectionSummary extends StatefulWidget {
  const WashSectionSummary({super.key});

  @override
  State<WashSectionSummary> createState() => _WashSectionSummaryState();
}

class _WashSectionSummaryState extends State<WashSectionSummary> {
  StatsQueriesService? apiService;

  @override
  void initState() {
    super.initState();
    apiService = StatsQueriesService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiService?.getWashSummary(),
        builder:
            (BuildContext context, AsyncSnapshot<WashSummaryModel?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            WashSummaryModel? contents = snapshot.data;

            return _buildListView(contents);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildListView(WashSummaryModel? data) {
    int hour = data?.avgWashDurPerClothes ?? 0;
    int days = (hour / 24).floor();
    int hours = hour % 24;

    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(spaceLG),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(roundedXLG)),
          color: greyColor),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const AtomsText(
          type: "content-title-main",
          text: "Wash Summary",
          color: blackColor,
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AtomsText(
                  type: "content-title",
                  text: "Avg. Wash / Week",
                  color: blackColor,
                  marginBottom: spaceMini,
                ),
                Row(
                  children: [
                    AtomsText(
                      type: "content-title-main",
                      text: "${data?.avgWashPerWeek}",
                    ),
                    const SizedBox(width: spaceMini),
                    const AtomsText(
                      type: "content-title",
                      text: "Clothes",
                      color: shadowColor,
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AtomsText(
                  type: "content-title",
                  text: "Total Wash",
                  color: blackColor,
                  marginBottom: spaceMini,
                ),
                Row(
                  children: [
                    AtomsText(
                      type: "content-title-main",
                      text: "${data?.totalWash}",
                    ),
                    const SizedBox(width: spaceMini),
                    const AtomsText(
                      type: "content-title",
                      text: "Clothes",
                      color: shadowColor,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
        const AtomsText(
          type: "content-title",
          text: "Avg. Wash Duration / Clothes",
          color: blackColor,
          marginBottom: spaceMini,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AtomsText(
              type: "content-title-main",
              text: "$days Days",
            ),
            const SizedBox(width: spaceMini),
            AtomsText(
              type: "content-title",
              text: "$hours Hr",
              color: shadowColor,
            ),
          ],
        ),
        const AtomsText(
          type: "content-title",
          text: "Most Wash",
          color: blackColor,
          marginBottom: spaceMini,
        ),
        AtomsText(
          type: "content-title-main",
          text: "${data?.mostWash}",
        ),
        const AtomsText(
          type: "content-title",
          text: "Last Wash",
          color: blackColor,
          marginBottom: spaceMini,
        ),
        AtomsText(
          type: "content-title-main",
          text: "${data?.lastWashClothes}",
          marginBottom: 0,
        ),
        AtomsText(
          type: "content-title",
          text: "On ${convertDatetimeBasedLocal(data?.lastWashDate ?? "")}",
          color: shadowColor,
        ),
      ]),
    );
  }
}
