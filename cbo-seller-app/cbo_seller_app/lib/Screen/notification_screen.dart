import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../Layouts/constant_screen_layout.dart';
import '../Models/Notification Model/notification_models.dart';
import '../Services/notification_api_services.dart';
import '../Utils/Constant Size /constant_sizes.dart';
import '../Utils/Font Style/text_styles.dart';
import '../Utils/Theme/constant_colors.dart';
import '../Widget/No Data Available/no_data_found.dart';
import '../Widget/custome_text_widget.dart';
import '../Widget/refresh_footer_message.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}


class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    super.initState();
    fetchNotificationListData();
  }
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool isPullToRefreshEnabled = true;
  int currentPage = 1;
  bool isLoading = false;
  var limit = "12";

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  NotificationModels? notificationModels;
  List<Data>? data = [];
  Future<void> fetchNotificationListData() async {
    try {
      if (currentPage == 1) {
        setState(() {
          isLoading = true;
          data!.clear();
        });
      }

      final notificationResponse = await ApiService.fetchNotificationData(
        context: context,
        page: currentPage,
        limit: limit,
      );

      if (notificationResponse != null && notificationResponse.data != null) {
        final dataList = notificationResponse.data!;

        setState(() {
          if (currentPage == 1) {
            data = dataList;
          } else {
            data!.addAll(dataList);
            _refreshController.loadComplete();
          }

          isLoading = false;
          currentPage++;

          if (currentPage! > notificationResponse.totalPages!) {
            // Disable pull-to-refresh when on the last page
            isPullToRefreshEnabled = false;
            _refreshController.loadNoData();
            return; // Exit early to prevent unnecessary setState
          }
        });
      }
      else {
        // No more data available
        setState(() {
          isLoading = false;
          _refreshController.loadNoData();
          isPullToRefreshEnabled = false; // Disable pull-to-refresh
        });
      }
    } catch (e) {
      setState(() {
        _refreshController.loadNoData();
        isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return  AppLayout(
      title: "Notifications",
      titleStyle: ConstantTextStyle.landingScreenAppbarText,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
        onPressed: () => Navigator.pop(context),
      ),
      scaffoldColor: ConstantColor.primaryBackgroundMainColor,
      appBarColor: ConstantColor.loginWithOtpButtonColor,
        body:isLoading
            ? const Center(child: CircularProgressIndicator())
            : (data != null && data!.isNotEmpty && data!.toString().isNotEmpty)
        ? CupertinoScrollbar(
          child: SmartRefresher(
          enablePullDown: false,
          enablePullUp: true,
          controller: _refreshController,
          footer: customFooter(),
            // onRefresh: () async {
            //   currentPage = 1;
            //   await fetchNotificationListData();
            //   _refreshController.refreshCompleted();
            // },
          onLoading: () async {
            await fetchNotificationListData();
          },
            child: AnimationLimiter(
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: screenWidth/30),
                scrollDirection: Axis.vertical,
                itemCount: data!.length??0,
                itemBuilder: (BuildContext context, int index) {
                  var notification = data![index];
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 300),
                    columnCount: 2,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: Center(
                          child: Card(
                            elevation: 0,
                            margin:  EdgeInsets.symmetric(vertical: screenHeight/100),
                            color: ConstantColor.notificationListColor,
                            child: ListTile(
                              horizontalTitleGap: screenWidth/60,
                              contentPadding: EdgeInsets.symmetric(vertical: screenHeight/200, horizontal: screenWidth/80),
                              dense: true,
                              leading: const Card(
                                elevation: 0,
                                color: ConstantColor.primaryBackgroundMainColor,
                                child: Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Icon(Icons.notifications_none_outlined,color: ConstantColor.primaryMainColor,),
                                ),
                              ),
                              title:  customeText(
                                text: notification.title!.toUpperCase()??"",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style:ConstantTextStyle.secodHearText,
                              ),
                              subtitle:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customeText(
                                    text: notification.msg??"",
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: ConstantTextStyle.secondorGrayText,
                                  ),
                                  customeText(
                                    text: notification.insertDate??"",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: ConstantTextStyle.secondorGrayText,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ) : Column(
          children: [
            constantHeight(context, 10.0),
            noDataFound(context),
          ],
        ),
    );
  }
}