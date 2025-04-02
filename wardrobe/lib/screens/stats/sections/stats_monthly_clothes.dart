import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/stats/model/queries.dart';
import 'package:wardrobe/modules/api/stats/services/queries.dart';
import 'package:wardrobe/molecules/m_chart_two_line.dart';

class StatsSectionMonthlyClothes extends StatefulWidget {
  const StatsSectionMonthlyClothes({super.key});

  @override
  State<StatsSectionMonthlyClothes> createState() =>
      _StatsSectionMonthlyClothesState();
}

class _StatsSectionMonthlyClothesState
    extends State<StatsSectionMonthlyClothes> {
  List<TwoLineData> chartData = [];
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
        future: apiService?.getMonthlyClothesPerMonth('2025'),
        builder: (BuildContext context,
            AsyncSnapshot<List<StatsMonthlyClothesModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<StatsMonthlyClothesModel> contents = snapshot.data ?? [];
            chartData.clear();

            for (var content in contents) {
              String label = content.ctx;
              int totalBuyed = content.totalBuyed;
              int totalCreated = content.totalCreated;
              TwoLineData lineData =
                  TwoLineData(label, totalBuyed, totalCreated);
              chartData.add(lineData);
            }

            return _buildListView(chartData);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildListView(List<TwoLineData> contents) {
    return Container(
        margin: const EdgeInsets.all(spaceSM),
        child: moleculesChartTwoLine(chartData, 'Clothes Monthly Activity',
            null, 'Total Buyed', 'Total Created'));
  }
}
