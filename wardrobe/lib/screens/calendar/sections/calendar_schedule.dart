import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/stats/model/queries.dart';
import 'package:wardrobe/modules/api/stats/services/queries.dart';
import 'package:wardrobe/screens/calendar/sections/calendar_export_daily_data.dart';

class CalendarSectionSchedule extends StatefulWidget {
  const CalendarSectionSchedule({super.key});

  @override
  StateCalendarSectionSchedule createState() => StateCalendarSectionSchedule();
}

class StateCalendarSectionSchedule extends State<CalendarSectionSchedule> {
  late StatsQueriesService apiQuery;
  List<CalendarModel> dt = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    apiQuery = StatsQueriesService();
    loadData();
  }

  Future<void> loadData() async {
    DateTime now = DateTime.now();
    int month = now.month;
    int year = now.year;

    setState(() {
      isLoading = true;
    });
    var data = await apiQuery.getCalendar(month, year);
    setState(() {
      dt = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading
          ? const Center(child: CircularProgressIndicator(color: primaryColor))
          : _buildListView(dt),
    );
  }

  Widget _buildListView(List<CalendarModel> data) {
    if (data.isNotEmpty) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: data.map((dt) {
            List<CalendarClothesModel> allSchedules = [
              ...(dt.usedHistory ?? [])
                  .map((e) => e.copyWith(typeSchedule: 'Used History')),
              ...(dt.weeklySchedule ?? [])
                  .map((e) => e.copyWith(typeSchedule: 'Weekly Schedule')),
              ...(dt.washSchedule ?? [])
                  .map((e) => e.copyWith(typeSchedule: 'Wash Schedule')),
              ...(dt.buyedHistory ?? [])
                  .map((e) => e.copyWith(typeSchedule: 'Buyed History')),
              ...(dt.addWardrobe ?? [])
                  .map((e) => e.copyWith(typeSchedule: 'Add Wardrobe')),
            ];

            return Container(
              height: allSchedules.isNotEmpty ? 220 : 55,
              width: Get.width,
              decoration: const BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.all(Radius.circular(roundedLG))),
              padding: const EdgeInsets.symmetric(
                  vertical: spaceMD, horizontal: spaceSM),
              margin: const EdgeInsets.only(bottom: spaceMD),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      AtomsText(
                          type: "content-title",
                          text: dt.date,
                          color: blackColor),
                      const Spacer(),
                      allSchedules.isNotEmpty
                          ? SizedBox(
                              width: 140,
                              child: Row(
                                children: [
                                  const Expanded(
                                      child: AtomsButton(
                                    type: "btn-warning",
                                    icon: FaIcon(
                                      FontAwesomeIcons.penToSquare,
                                      size: textMD,
                                      color: whiteColor,
                                    ),
                                  )),
                                  const SizedBox(width: spaceMini),
                                  CalendarSectionExportDailyData(date: dt.date)
                                ],
                              ),
                            )
                          : const AtomsText(
                              type: "no-data",
                              text: "No Clothes Found",
                              color: darkColor,
                            )
                    ],
                  ),
                  allSchedules.isNotEmpty
                      ? Column(children: [
                          const SizedBox(height: spaceXXSM),
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: allSchedules.length,
                              itemBuilder: (context, index) {
                                final item = allSchedules[index];
                                return Container(
                                  margin: const EdgeInsets.only(right: spaceSM),
                                  width: 120,
                                  padding: const EdgeInsets.all(spaceXXSM),
                                  decoration: const BoxDecoration(
                                      color: hoverBG,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(roundedLG))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AtomsText(
                                        type: "content-body",
                                        text: item.typeSchedule ?? "-",
                                        color: blackColor,
                                        align: TextAlign.center,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: item.clothesImage != null
                                            ? Image.network(
                                                item.clothesImage!,
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                'assets/images/default_clothes.png',
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      const SizedBox(height: spaceMini),
                                      AtomsText(
                                        type: "content-body",
                                        text: item.clothesName,
                                        color: blackColor,
                                        align: TextAlign.center,
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ])
                      : const SizedBox()
                ],
              ),
            );
          }).toList());
    } else {
      return const Text("Unknown error, please contact the admin");
    }
  }
}
