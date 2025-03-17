import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/stats/model/queries.dart';

Widget moleculesChartPie(List<PieData> chartData, String title) {
  return Container(
      decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.35),
              blurRadius: spaceLG,
              spreadRadius: 0.0,
              offset: const Offset(
                spaceMini,
                spaceMini,
              ),
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(roundedJumbo))),
      child: SfCircularChart(
          title: ChartTitle(
              text: title,
              textStyle: const TextStyle(
                  color: darkColor,
                  fontWeight: FontWeight.w600,
                  fontSize: textLG)),
          legend: Legend(
              isVisible: true,
              padding: spaceLG,
              position: LegendPosition.bottom,
              isResponsive: true,
              orientation: LegendItemOrientation.vertical,
              overflowMode: LegendItemOverflowMode.wrap,
              shouldAlwaysShowScrollbar: true,
              borderColor: primaryColor),
          series: <CircularSeries>[
            PieSeries<PieData, String>(
                explode: true,
                explodeIndex: 0,
                dataSource: chartData,
                xValueMapper: (PieData data, _) => data.xData,
                yValueMapper: (PieData data, _) => data.yData,
                dataLabelMapper: (PieData data, _) => '${data.yData}',
                dataLabelSettings: const DataLabelSettings(
                    isVisible: true, textStyle: TextStyle(fontSize: textXMD))),
          ]));
}
