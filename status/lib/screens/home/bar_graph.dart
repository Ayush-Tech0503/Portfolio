import 'package:centavizers/helpers/color_helper.dart';
import 'package:centavizers/helpers/dimens_helper.dart';
import 'package:centavizers/helpers/string_helper.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../helpers/font_helper.dart';
import 'bar_charts.dart';



class BatGraphView extends StatefulWidget {
const BatGraphView({super.key});

  @override
  State<BatGraphView> createState() => _BatGraphViewState();
}

class _BatGraphViewState extends State<BatGraphView> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      padding: const EdgeInsets.symmetric(
          horizontal: DimensHelper.dimens_30,
          vertical: DimensHelper.dimens_20,
      ),

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DimensHelper.dimens_14),
          border: Border.all(color: ColorHelper.grey300)
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          simpleTextStack(
              topText: AppString.calories,
              bottomText: "500"
          ),

          const  Divider(thickness: 0.5,height: DimensHelper.dimens_40),


          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        interval: 1,
                        showTitles: true,
                        reservedSize: 80,
                        getTitlesWidget: (value, meta) {
                          final isSelected = touchedIndex == value.toInt();
                          final labels = ['21 Feb', '22 Feb', '23 Feb', '24 Feb', '25 Feb'];
                          if (value.toInt() >= 0 && value.toInt() < labels.length) {
                            return Chip(
                              padding: const EdgeInsets.symmetric(horizontal: 0),
                              labelPadding: const EdgeInsets.symmetric(horizontal: DimensHelper.dimens_6),
                              backgroundColor: isSelected
                                  ? ColorHelper.primaryColor
                                  : ColorHelper.whiteColor,
                              label: Text(
                                labels[value.toInt()],
                                style: TextStyle(
                                    color:  isSelected ? ColorHelper.whiteColor : ColorHelper.greyIcon2Color,
                                    fontSize: FontHelper.size_12,
                                    fontWeight: FontHelper.medium,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false, reservedSize: 40),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  minX: 0,
                  maxX: 4,
                  minY: 0,
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 200),  // Feb 21
                        FlSpot(1, 140),  // Feb 22
                        FlSpot(2, 500),  // Feb 23
                        FlSpot(3, 100),  // Feb 24
                        FlSpot(4, 100),  // Feb 25
                      ],

                      shadow: const Shadow(color: ColorHelper.blackColor),
                      isCurved: true,
                      color: ColorHelper.primaryColor,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              ColorHelper.primaryColor.withOpacity(0.3),
                              Colors.transparent,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )),
                      // belowBarData: BarAreaData(show: false),

                    ),
                  ],
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      // showOnTopOfTheChartBoxArea: true,
                      getTooltipColor: (group) => Colors.white,
                      tooltipBorder: const BorderSide(color: ColorHelper.grey300),
                      tooltipRoundedRadius: 8,
                      tooltipPadding: const EdgeInsets.all(DimensHelper.dimens_4),
                    ),
                    touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
                      if (touchResponse != null && touchResponse.lineBarSpots != null) {
                        // setState(() {
                        touchedIndex = touchResponse.lineBarSpots!.first.x.toInt();
                        // });
                      }
                    },
                    handleBuiltInTouches: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

