import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/stats/model/queries.dart';
import 'package:wardrobe/modules/api/stats/services/queries.dart';
import 'package:wardrobe/modules/helpers/converter.dart';

class HomeSectionClothesSummary extends StatefulWidget {
  const HomeSectionClothesSummary({super.key});

  @override
  State<HomeSectionClothesSummary> createState() =>
      _HomeSectionClothesSummaryState();
}

class _HomeSectionClothesSummaryState extends State<HomeSectionClothesSummary> {
  QueriesStatsService? apiService;

  @override
  void initState() {
    super.initState();
    apiService = QueriesStatsService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiService?.getClothesSummary(),
        builder:
            (BuildContext context, AsyncSnapshot<ClothesSummary?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            ClothesSummary? contents = snapshot.data;

            return _buildListView(contents);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildListView(ClothesSummary? data) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(spaceLG),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(roundedXLG)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [darkInfoBG, infoBG],
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Column(
            children: [
              Row(
                children: [
                  AtomsText(
                      type: "content-title",
                      text: data != null ? "${data.totalClothes}" : "...",
                      color: blackColor),
                  const SizedBox(width: spaceXXSM),
                  const AtomsText(
                      type: "content-title",
                      text: "Variety",
                      color: whiteColor),
                ],
              ),
              Row(
                children: [
                  AtomsText(
                      type: "content-title",
                      text: data != null ? "${data.sumClothesQty}" : "...",
                      color: blackColor),
                  const SizedBox(width: spaceMini),
                  const AtomsText(
                      type: "content-title",
                      text: "Quantity",
                      color: whiteColor),
                ],
              )
            ],
          ),
          const SizedBox(width: spaceXXSM),
          const Row(
            children: [
              AtomsText(
                  type: "content-title-main", text: "Total", color: blackColor),
              SizedBox(width: spaceXXSM),
              AtomsText(type: "content-title-main", text: "Clothes"),
            ],
          ),
        ]),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AtomsText(
                  type: "content-title-main", text: "The", color: blackColor),
              SizedBox(width: spaceMini),
              AtomsText(type: "content-title-main", text: "Price"),
            ],
          ),
          const SizedBox(width: spaceXXSM),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AtomsText(
                      type: "content-title",
                      text: data != null
                          ? data.avgPrice == null
                              ? "0"
                              : formatCurrency(data.maxPrice.toDouble())
                          : "...",
                      color: blackColor),
                  const SizedBox(width: spaceXXSM),
                  const AtomsText(
                      type: "content-title",
                      text: "Most Expensive",
                      color: whiteColor),
                ],
              ),
              Row(
                children: [
                  AtomsText(
                      type: "content-title",
                      text: data != null
                          ? data.avgPrice == null
                              ? "0"
                              : formatCurrency(data.avgPrice.toDouble())
                          : "...",
                      color: blackColor),
                  const SizedBox(width: spaceXXSM),
                  const AtomsText(
                      type: "content-title",
                      text: "Average",
                      color: whiteColor),
                ],
              )
            ],
          ),
        ])
      ]),
    );
  }
}
