import 'package:centavizers/components/common_image_widget.dart';
import 'package:centavizers/cubits/Upcoming_challenges/upcoming_challenges_cubit.dart';
import 'package:centavizers/cubits/Upcoming_challenges/upcoming_challenges_state.dart';
import 'package:centavizers/helpers/color_helper.dart';
import 'package:centavizers/helpers/dimens_helper.dart';
import 'package:centavizers/utils/globle_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../components/app_buttons.dart';
import '../../cubits/HealthCubit/get_health_date_cubit/get_health_date_cubit.dart';
import '../../cubits/HealthCubit/get_health_date_cubit/get_health_date_state.dart';
import '../../cubits/HealthCubit/health_cubit.dart';
import '../../cubits/HealthCubit/health_state.dart';
import '../../helpers/font_helper.dart';
import '../../helpers/string_helper.dart';
import '../../routes/routes_name.dart';
import '../../utils/loading_indicator.dart';
import 'bar_charts.dart';
import 'bar_graph.dart';
import 'build_banner_content.dart';
import 'circle_chart_ui.dart';
// import 'package:timeago/timeago.dart' as timeago;



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? lastApiCallTime;
  String timeAgoText = "No API call yet";

  @override
  void initState() {
    // Timer.periodic(const Duration(seconds: 30), (timer) {
    //   if (lastApiCallTime != null) {
    //     setState(() {
    //       timeAgoText = timeago.format(lastApiCallTime!);
    //     });
    //   }
    // });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<GetHealthDateCubit>().getHealthDate(showLoader: true);
      context.read<UpcomingChallengesCubit>().getUpcomingChallengesData();
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DimensHelper.dimens_20),
        child:

        Column(
          children: [

            buildBannerSection(context, 1),

            BlocBuilder<HealthCubit, HealthState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return SizedBox(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: ColorHelper.primaryColor,width: DimensHelper.dimens_1)
                    // ),
                    height: DimensHelper.dimens_60,
                    child: loadingButton(color: ColorHelper.primaryColor),
                  );
                }
                return CommonButton(
                    onPress: () => context.read<HealthCubit>().fetchCurrentMonthData(context),
                    //   onPress: ()  { Navigator.push(context, MaterialPageRoute(builder: (context) =>  StepsChartScreen()));},
                    // onPress: ()  { Navigator.push(context, MaterialPageRoute(builder: (context) => const StepsScreen()));},
                    buttonMargin: EdgeInsets.symmetric(
                        horizontal: context.globalSize.width / DimensHelper.dimens_20,
                        vertical: context.globalSize.height / DimensHelper.dimens_30
                    ),
                    buttonText: AppString.syncYourData
                  // buttonText: AppString.pairYourDevice
                );
              },
            ),




            BlocBuilder<GetHealthDateCubit, GetHealthDateState>(
              builder: (context, state) {
                if (state is GetHealthDateLoading) return const CircularProgress();
                if (state is GetHealthDateError) return const CircularProgress();
                if (state is GetHealthDateLoaded) {
                  final healthData = state.healthFilterModel.data ?? [];
                  final stepItem = healthData.firstWhere((e) => e.steps != null,);
                  return CircularProgressLoaded(loadedData: stepItem);
                  // return CircularProgressLoaded(loadedData: state.postSyncDataModel.data?.recordsData?[0].value ?? 00);
                }
                return const SizedBox();
              },
            ),


            //-------------

            BlocBuilder<GetHealthDateCubit, GetHealthDateState>(
              builder: (context, state) {
                if (state is GetHealthDateLoading) return commonBoxShimmer();
                if (state is GetHealthDateError) return const Center(child: Text("Error fetching data"));
                if (state is GetHealthDateLoaded) {
                  final healthData = state.healthFilterModel.data ?? [];
                  final stepItem = healthData.firstWhere((e) => e.steps != null,);
                  final distanceItem = healthData.firstWhere((e) => e.distanceKm != null,);
                  final sleepItem = healthData.firstWhere((e) => e.sleepHours != null,);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        // height: context.globalSize.height / DimensHelper.dimens_12,
                        child: commonBox(
                          titleText: stepItem.steps?.toString() ?? "----",
                          subTitleText: stepItem.type ?? "Steps",
                        ),
                      ),
                      Flexible(
                        // height: context.globalSize.height / DimensHelper.dimens_12,
                        child: commonBox(
                          titleText: distanceItem.distanceKm?.toStringAsFixed(2) ?? "----",
                          subTitleText: distanceItem.type ?? "Distance",
                          bgColor: ColorHelper.primaryColor,
                          titleColor: ColorHelper.whiteColor,
                          subTitleTextColor: ColorHelper.whiteColor,
                        ),
                      ),
                      Flexible(
                        // height: context.globalSize.height / DimensHelper.dimens_12,
                        child: commonBox(
                          titleText: sleepItem.sleepHours?.toString() ?? "----",
                          subTitleText: sleepItem.type ?? "Sleep",
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),

            const SizedBox(height: DimensHelper.dimens_40),

            const TabBarViewUi(),

            const SizedBox(height: DimensHelper.dimens_40),

            const BatGraphView(),

            const SizedBox(height: DimensHelper.dimens_30),

            const Align(
                alignment: Alignment.centerLeft,
                child: Text(AppString.upcomingChallenge,
                  style: TextStyle(
                    fontSize: DimensHelper.dimens_14,
                    color: ColorHelper.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                )),

            const SizedBox(height: DimensHelper.dimens_30),


            buildBannerSection(context, 2),

            // const SizedBox(height: DimensHelper.dimens_30),
            // buildBannerSection(context, () {}),

          ],
        ),

      ),
    );
  }
}


Widget buildBannerSection(BuildContext context, indexVal) {
  return BlocBuilder<UpcomingChallengesCubit, UpcomingChallengesState>(
    builder: (context, state) {
      if (state is UpcomingChallengesLoading) return const Center(child: CircularProgressIndicator());
      if (state is UpcomingChallengesError) return const Center(child: Text("Something went wrong!"));
      if (state is UpcomingChallengesLoaded) {
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: indexVal == 1 ? 1 : state.upcomingChallengeModel.data?.length??0,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final challenge = state.upcomingChallengeModel.data?[index];
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, RouteName.challengeDetail,
                arguments:  challenge?.id??""),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildBannerImage(image : challenge?.challengeImage??""),
                  _buildGradientOverlay(),
                  buildBannerContent(
                    context,
                    title: challenge?.title ?? "No Title",
                      days : challenge?.goal??"",
                      counts: challenge?.totalParticipants??0,
                      profileList : challenge?.userProfile??[]
                    // days: challenge?.remainingDays ?? "No days info",
                    // counts: challenge?.participantCount ?? 0,
                    // profileList: challenge?.profileList ?? [],
                  ),
                ],
              ),
            );
          },
        );
      }
      return const SizedBox();
    },
  );
}



Widget _buildBannerImage({String? image}) {
  return customNetworkImage(
    bgColor: Colors.transparent,
    imgUrl:  image,
    height: 160,
    width: double.maxFinite,
    radius: DimensHelper.dimens_12,
    fit: BoxFit.fill,
  );
}

Widget _buildGradientOverlay() {
  return Container(
    width: double.maxFinite,
    height: 160,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          ColorHelper.blackColor.withOpacity(0.95),
          ColorHelper.greyIcon2Color.withOpacity(0.0),
        ],
        stops: const [0.0, 1.0],
      ),
    ),
  );
}


Widget commonBox({titleColor, bgColor, titleText, subTitleText, subTitleTextColor, padding}) {
  return Container(
    alignment: Alignment.center,
    padding: padding ?? const EdgeInsets.all(DimensHelper.dimens_8),
    margin: const EdgeInsets.symmetric(horizontal: DimensHelper.dimens_6),
    width: DimensHelper.dimens_100,
    // double.maxFinite,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
      color: bgColor ?? ColorHelper.whiteColor,
      border: Border.all(color: ColorHelper.greyIcon2Color),
      boxShadow: [
        BoxShadow(
          color: ColorHelper.greyColor.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 3,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(titleText ?? "----",
          style: TextStyle(
            color: titleColor ?? ColorHelper.primaryColor,
            fontSize: FontHelper.size_18,
            fontWeight: FontHelper.bold,
          ),),

        Text(subTitleText ?? "Total",
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: subTitleTextColor ?? ColorHelper.greyIcon2Color,
            fontSize: FontHelper.size_12,
            fontWeight: FontHelper.medium,
          ),),
      ],
    ),
  );
}


//----shimmer data ----

Widget commonBoxShimmer({scrollDirection, itemCount, gapPadding, padding, height}) {
  return SizedBox(
    height: height ?? DimensHelper.dimens_60,
    child: ListView.builder(
      scrollDirection: scrollDirection ?? Axis.horizontal,
      itemCount: itemCount ?? 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: gapPadding ?? const EdgeInsets.symmetric(horizontal: 5.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            direction: ShimmerDirection.ltr,
            child: commonBox(
              padding: padding ?? const EdgeInsets.all(DimensHelper.dimens_8),
              titleText: "",
              subTitleText: "",
              bgColor: ColorHelper.whiteColor,
            ),
          ),
        );
      },
    ),
  );
}


class DatePickerScreen extends StatefulWidget {
  @override
  _DatePickerScreenState createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  String selectedDate = "Select a date";
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedDate,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: Colors.blue,
                  colorScheme: ColorScheme.light(primary: Colors.blue),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                    ),
                  ),
                ),
                child: CalendarDatePicker(
                  initialDate: now,
                  firstDate: firstDayOfMonth,
                  lastDate: lastDayOfMonth,
                  onDateChanged: (DateTime date) {
                    setState(() {
                      selectedDate = "${date.day}-${date.month}-${date.year}";
                    });
                  },
                  // Custom builder to hide month/year header
                  // builder: (context, child) {
                  //   return Column(
                  //     children: [
                  //       // Only show the weekday headers and dates
                  //       SizedBox(
                  //         child: child,
                  //       ),
                  //     ],
                  //   );
                  // },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}