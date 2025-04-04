import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/stats/model/queries.dart';
import 'package:wardrobe/modules/api/stats/services/queries.dart';

class LandingSectionWelcoming extends StatefulWidget {
  const LandingSectionWelcoming({super.key});

  @override
  State<LandingSectionWelcoming> createState() =>
      _LandingSectionWelcomingState();
}

class _LandingSectionWelcomingState extends State<LandingSectionWelcoming> {
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
        future: apiService?.getWelcomingStats(),
        builder:
            (BuildContext context, AsyncSnapshot<WelcomeStatsModel?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            WelcomeStatsModel? contents = snapshot.data;

            return _buildListView(contents);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildListView(WelcomeStatsModel? data) {
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const AtomsText(
          type: "content-title-main",
          text: "Effortless style",
          color: blackColor,
        ),
        const AtomsText(
            type: "content-title-main", text: "Decision and Organize"),
        const AtomsText(
            type: "content-sub-title",
            text:
                "Wardrobe is your ultimate clothing assistant, helping you organize outfits, track history, manage schedules, and plan weekly looks",
            color: blackColor,
            align: TextAlign.center),
        const SizedBox(height: spaceLG),
        Row(
          children: [
            const SizedBox(width: spaceXLG),
            Column(
              children: [
                AtomsText(
                    type: "content-title-main",
                    text: "${data?.totalUser} +",
                    color: blackColor,
                    align: TextAlign.center,
                    key: const Key("total-user-text"),
                    marginBottom: spaceMini),
                const AtomsText(
                    type: "content-title",
                    text: "Active User",
                    color: darkColor,
                    align: TextAlign.center),
                const SizedBox(height: spaceLG),
                AtomsText(
                    type: "content-title-main",
                    text: "${data?.totalSchedule} +",
                    color: blackColor,
                    align: TextAlign.center,
                    key: const Key("total-schedule-text"),
                    marginBottom: spaceMini),
                const AtomsText(
                    type: "content-title",
                    text: "Schedule Reminder",
                    color: darkColor,
                    align: TextAlign.center),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                AtomsText(
                    type: "content-title-main",
                    text: "${data?.totalOutfitDecision} +",
                    color: blackColor,
                    align: TextAlign.center,
                    key: const Key("total-outfit-text"),
                    marginBottom: spaceMini),
                const AtomsText(
                    type: "content-title",
                    text: "Outfit Decision",
                    color: darkColor,
                    align: TextAlign.center),
                const SizedBox(height: spaceLG),
                AtomsText(
                    type: "content-title-main",
                    text: "${data?.totalClothes} +",
                    color: blackColor,
                    align: TextAlign.center,
                    key: const Key("total-clothes-text"),
                    marginBottom: spaceMini),
                const AtomsText(
                    type: "content-title",
                    text: "Clothes",
                    color: darkColor,
                    align: TextAlign.center),
              ],
            ),
            const SizedBox(width: spaceXLG),
          ],
        ),
      ]),
    );
  }
}
