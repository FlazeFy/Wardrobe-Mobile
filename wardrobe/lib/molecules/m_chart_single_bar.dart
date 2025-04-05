import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/stats/model/queries.dart';

Widget moleculesChartSingleBar(List<SingleLineData> chartData, String? title,
    String? extra, String lineOne) {
  return Container(
    decoration: BoxDecoration(
      color: whiteColor,
      boxShadow: [
        BoxShadow(
          color: shadowColor.withOpacity(0.35),
          blurRadius: spaceLG,
          spreadRadius: 0.0,
          offset: const Offset(spaceMini, spaceMini),
        )
      ],
      borderRadius: const BorderRadius.all(Radius.circular(roundedJumbo)),
    ),
    child: SfCartesianChart(
      title: title != null
          ? ChartTitle(
              text: title,
              textStyle: const TextStyle(
                color: darkColor,
                fontWeight: FontWeight.w600,
                fontSize: textLG,
              ),
            )
          : ChartTitle(),
      legend: Legend(
        position: LegendPosition.bottom,
        isVisible: true,
        textStyle: const TextStyle(color: darkColor),
      ),
      primaryXAxis: CategoryAxis(
        labelStyle: const TextStyle(color: darkColor),
      ),
      primaryYAxis: NumericAxis(
        labelStyle: const TextStyle(color: darkColor),
      ),
      series: <CartesianSeries>[
        BarSeries<SingleLineData, String>(
          dataSource: chartData,
          xValueMapper: (SingleLineData data, _) => data.xData,
          yValueMapper: (SingleLineData data, _) => data.yData,
          name: lineOne,
          dataLabelMapper: (SingleLineData data, _) => data.yData != 0
              ? '${extra ?? ''}${double.parse(data.yData.toStringAsFixed(2))}'
              : null,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(
              fontSize: textSM,
              fontWeight: FontWeight.w500,
              color: darkColor,
            ),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(roundedSM),
            topRight: Radius.circular(roundedSM),
          ),
        ),
      ],
    ),
  );
}
