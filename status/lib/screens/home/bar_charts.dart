import 'package:centavizers/helpers/color_helper.dart';
import 'package:centavizers/helpers/dimens_helper.dart';
import 'package:centavizers/helpers/string_helper.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../helpers/font_helper.dart';


class TabBarViewUi extends StatelessWidget {
  const TabBarViewUi({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 340,
      padding:  const EdgeInsets.all(DimensHelper.dimens_10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DimensHelper.dimens_14),
        border: Border.all(color: ColorHelper.grey300)
      ),
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(DimensHelper.dimens_4),
              margin: const EdgeInsets.symmetric(vertical:  DimensHelper.dimens_8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
                color: ColorHelper.grey200,
              ),
              // elevation: 0.1,
              child: TabBar(
                // automaticIndicatorColorAdjustment: false,
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                indicatorPadding: const EdgeInsets.all(DimensHelper.dimens_6),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(DimensHelper.dimens_8),
                    color:ColorHelper.primaryColor),
                dividerColor: Colors.transparent,
                dividerHeight: 0.0,
                labelStyle: const TextStyle(color:  ColorHelper.whiteColor,
                  fontSize: FontHelper.size_14,
                  fontWeight: FontHelper.bold
                ),
                unselectedLabelStyle: const TextStyle(color: ColorHelper.greyIcon2Color,
                    fontSize: FontHelper.size_14,
                    fontWeight: FontHelper.bold
                ),

                tabs: const [
                  Tab(text: AppString.weekly),
                  Tab(text: AppString.month),
                  Tab(text: AppString.year)
                ],
              ),
            ),
             Container(
               color: Colors.white,
               padding: const EdgeInsets.all(8.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  simpleTextStack(),
                  simpleTextStack(topText: AppString.thisWeek),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      circleText(title: AppString.steps),
                      circleText(color: ColorHelper.secondaryColor,
                      title: AppString.calorie),

                    ],
                  ),
                  // simpleTextStack(),
                ],
                         ),
             ),

            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(DimensHelper.dimens_20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: WeeklyBarChart(),
                  ),
                  // StepsChartScreen(),
                  // const Center(child: Text('Monthly Data')),
                  const Center(child: Text('Yearly Data'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }




  Widget dotTextStack({
    String topText = AppString.lastWeek,
    String bottomText = '0 Steps',
  }) {
    return Column(
      children: [
        Text(
          topText,
          style: const TextStyle(
            color: ColorHelper.greyIcon2Color,
            fontSize: FontHelper.size_12,
            fontWeight: FontHelper.medium,
          ),
        ),
        Text(
          bottomText,
          style: const TextStyle(
            color: ColorHelper.primaryColor,
            fontSize: FontHelper.size_14,
            fontWeight: FontHelper.bold,
          ),
        ),
      ],
    );
  }


}

class WeeklyBarChart extends StatelessWidget {
  final List<List<double>> weeklyData = [
    [500, 1000],  // 1000 steps
    [300, 800],   // Tuesday
    [700, 1400],  // Wednesday
    [200, 600],   // Thursday
    [600, 1200],  // Friday
    [400, 900],   // Saturday
    [800, 2000],  // Sunday
  ];

   WeeklyBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 2000,
          barGroups: List.generate(7, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: weeklyData[index][0],
                  color: ColorHelper.primaryColor,
                  width: DimensHelper.dimens_12,

                ),
                BarChartRodData(
                  toY: weeklyData[index][1], // Steps
                  color: ColorHelper.secondaryColor,
                  width: DimensHelper.dimens_12
                ),
              ],
              barsSpace: 3,
            );
          }),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return rowText('0');
                    case 100:
                      return rowText ('100');
                    case 500:
                      return rowText('500');
                    case 1000:
                      return rowText('1000');
                      case 1500:
                      return rowText('1500');
                    case 2000:
                      return rowText('2000');
                    default:
                      return rowText('');
                  }
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                  return Text(days[value.toInt()],
                  style: const TextStyle(
                      color:  ColorHelper.greyIcon2Color,
                      fontSize: FontHelper.size_12,
                      fontWeight: FontHelper.medium,
                    height: DimensHelper.dimens_2
                  ),);
                },
              ),
            ),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: true),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
                getTooltipColor: (group) => Colors.white,
              tooltipBorder: const BorderSide(color: ColorHelper.grey300),
              tooltipRoundedRadius: 8,
              tooltipPadding: const EdgeInsets.all(DimensHelper.dimens_4)
            ),
          ),

        ),
      );
  }





}



Widget simpleTextStack({
  String topText = AppString.lastWeek,
  String bottomText = '0 Steps',
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        topText,
        style: const TextStyle(
          color: ColorHelper.greyIcon2Color,
          fontSize: FontHelper.size_12,
          fontWeight: FontHelper.medium,
        ),
      ),
      Text(
        bottomText,
        style: const TextStyle(
          color: ColorHelper.primaryColor,
          fontSize: FontHelper.size_14,
          fontWeight: FontHelper.bold,
        ),
      ),
    ],
  );
}


Widget rowText(title){
  return Text(title??0,
      textAlign: TextAlign.start,
      style: const TextStyle(
          color:  ColorHelper.greyIcon2Color,
          fontSize: FontHelper.size_12,
          fontWeight: FontHelper.medium,
          height: DimensHelper.dimens_2
      ));
}


Widget circleText({color, title}){
  return Row(
    children: [
      CircleAvatar(
        backgroundColor: color ?? ColorHelper.primaryColor,
        radius: DimensHelper.dimens_6,
      ),
      SizedBox(width: DimensHelper.dimens_6),
      rowText(title ?? "")

    ],
  );
}