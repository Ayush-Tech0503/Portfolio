// ignore_for_file: non_constant_identifier_names, deprecated_member_use, library_private_types_in_public_api
import 'package:citybazaronline_seller_app/Models/get_reels_model.dart';
import 'package:citybazaronline_seller_app/Widget/images/cached_images_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../Services/Seller Forms Api Services/Seller Form Submit Api Services/step_1st_form_submit_api.dart';
import '../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../Utils/Constant Size /constant_sizes.dart';
import '../../Widget/Alert Dialogs/alert_dialog_widget.dart';
import '../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../Widget/No Data Available/no_data_found.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../../Widget/Status Chip Object Color /status_chip_bg_color_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../Layouts/constant_screen_layout.dart';
import '../../../../Utils/Font Style/text_styles.dart';
import '../../../../Utils/Theme/constant_colors.dart';
import '../../../../Widget/custome_text_widget.dart';
import '../../Services/Uploaded Video Api Services/get_reels_api_services.dart';
import '../../Widget/color_box_widget.dart';
import '../../Widget/refresh_footer_message.dart';
import '../Video Screen/video_screen.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({super.key});

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {

  @override
  void initState() {
    super.initState();
    fetchGetReelsListData();
  }
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool isPullToRefreshEnabled = true;
  int currentPage = 1;
  var limit = '12';
  bool isLoading = false;
  bool isHashLoad = false;
  var baseUrls = '';

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  GetReelsModel? getReelsModel;
  List<GetReelsData>? data = [];
  Future<void> fetchGetReelsListData() async {
    try {
      if (currentPage == 1) {
        setState(() {
          isLoading = true;
          data!.clear();
          videoData!.clear();
        });
      }

      final getReelsResponse = await GetReelsApiService.fetchGetReelsData(context: context,search: '',  page: currentPage, limit: limit);

      if (getReelsResponse != null && getReelsResponse.data != null) {
        String baseUrl = getReelsResponse.baseUrl ?? ''; // Ensure to replace 'baseUrl' with the correct field name

        final dataList = getReelsResponse.data!;
        setState(() {
          for (var reelData in dataList) {
            String videoUrl = '';
            String thumbnailUrl = '';
            if (reelData.postType == 'video' && reelData.postLink != null) {videoUrl = baseUrl + reelData.postLink!;}
            if (reelData.thumbnail != null) {thumbnailUrl = baseUrl + reelData.thumbnail!;}
            Map<String, String> mapData = {
              'video': videoUrl,
              'image': thumbnailUrl,
              'mediaType': reelData.postType ?? '',
              'category': reelData.category ?? '',
              'keyword': reelData.keyword ?? '',
              'status': reelData.status == '0' ? "Deactive" : "Active" ?? '',
              'approval': reelData.feed == '0' ? 'Pending' : 'Approved'??"",
              'action': 'Delete',
              'reel_id': reelData.id ??"",
            };

            videoData.add(mapData);
          }
        });
        setState(() {
          if (currentPage == 1) {
            data = dataList;
          }
          else {
            data!.addAll(dataList);
            _refreshController.loadComplete();
          }

          isHashLoad = currentPage! > getReelsResponse.totalPages!;
          if (isHashLoad == true){
            LoadingScaffoldMessage.showSnackbar(
              context,
              "Oops!! No More Data Available...",
              ConstantColor.primaryMainColor,
              const Duration(seconds: 2),
            );
          }
          isLoading = false;
          currentPage++;
          // if (currentPage! > getReelsResponse.totalPages!) {
          //   isPullToRefreshEnabled = false;
          //   _refreshController.loadNoData();
          //   return; // Exit early to prevent unnecessary setState
          // }

        });
      } else {
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


  List<Map<String, String>> videoData = [];

  var _selectedValue = 1;


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return AppLayout(
        title: "Your Uploaded Video",
        titleStyle: ConstantTextStyle.landingScreenAppbarText,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          InkWell(
            onTap: () async => await  Navigator.pushNamed(context, '/addVideoScreen'),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              margin:  EdgeInsets.symmetric(horizontal: screenWidth/30.0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
                color: ConstantColor.primaryMainColor,),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.video_library_rounded, color: ConstantColor.primaryBackgroundMainColor,size: 16.0,), // Add video icon
                  constantWidth(context,80.0),
                  customeText(
                    text: 'Add video',
                    style: ConstantTextStyle.chipText,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          // PopupMenuButton(
          //   offset: Offset(-screenWidth/30, screenHeight/14),
          //   icon: const Icon(Icons.more_vert_rounded, color: ConstantColor.primaryBackgroundMainColor),
          //   onSelected: (newValue) {
          //     setState(() {
          //       _selectedValue = newValue;
          //       Navigator.pushNamed(context, '/addVideoScreen');
          //     });
          //   },
          //   itemBuilder: (context) => [
          //     PopupMenuItem(
          //       value: 0,
          //       child: Container(
          //         padding: const EdgeInsets.all(10.0),
          //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
          //           color: ConstantColor.primaryMainColor,),
          //         child: Row(
          //           children: [
          //             const Icon(Icons.video_library_rounded, color: ConstantColor.primaryBackgroundMainColor,size: 16.0,), // Add video icon
          //             constantWidth(context,80.0),
          //             customeText(
          //               text: 'Add video',
          //               style: ConstantTextStyle.chipText,
          //               textAlign: TextAlign.center,
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // )
        ],
        scaffoldColor: ConstantColor.primaryBackgroundMainColor,
        appBarColor: ConstantColor.loginWithOtpButtonColor,
        body: SmartRefresher(
          enablePullDown: true,
            enablePullUp: isHashLoad == false ? true: false,
          controller: _refreshController,
          footer: customFooter(),
          onRefresh: () async {
            currentPage = 1;
            // searchController.clear();
            await fetchGetReelsListData();
            _refreshController.refreshCompleted();
          },
          onLoading: () async {
            await fetchGetReelsListData();
          },
          child: (data == null && data!.isNotEmpty)
              ? noDataFound(context) :
          isLoading ? const Center(child: CircularProgressIndicator()):
          ListView.builder(
            shrinkWrap: true,
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: screenWidth/30, vertical: screenHeight/40),
            itemCount: videoData?.length ?? 0,
            itemBuilder: (context, index) {
              var data = videoData![index];
              var odStatus = data['status'].toString() == "1" ? "Active" : "Inactive";
              var odApprove = data['approval'].toString() == "1" ? "Approved" : "Pending";
              // bool isSelected = data['selected'] ?? false; // Track selection status
              return
              GestureDetector(
                onTap: () async => await
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ShowDialogVideo(url: data['video'].toString()??"");
                      },
                    ),
                child:  Slidable(
                  key: Key(data['productIDs'].toString()),
                  startActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed:(direction) async {
                          YesNoPermissionDialog.showExitConfirmationDialog(
                            context:context, title: 'Please Confirm!', content: 'Are you sure want to delete this video?',
                            actions: [
                              customButton(
                                textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                                onPressed:() async {
                                  Navigator.pop(context);
                                  await fetchSellerRegistrationBodyApi(
                                    context: context,
                                    baseUrl: '${ConstantUrls.baseUriApi}${ConstantUrls.getDeleteReelsApi}',
                                    body: {"reel_id": data['reel_id'],},
                                    onSuccess: ()  {
                                      setState(() {
                                        currentPage = 1;
                                        isLoading = true;
                                        data!.clear();
                                        videoData!.clear();
                                        fetchGetReelsListData();
                                      });
                                    },
                                  );
                                },
                                text: "Yes",
                                backgroundColor: ConstantColor.loginWithOtpButtonColor,
                                borderRadius: BorderRadius.circular(20.0),
                                elevation: 0.0,
                              ),
                              constantWidth(context, 100.0),
                              customButton(
                                textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                                onPressed:() => Navigator.pop(context),
                                text: "No",
                                backgroundColor: ConstantColor.primaryMainColor,
                                borderRadius: BorderRadius.circular(20.0),
                                elevation: 0.0,
                              ),
                            ],
                          );
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete_forever,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  // child: Dismissible(
                  //   key: Key(data['productIDs'].toString()),
                  //   direction: DismissDirection.endToStart,
                  //   background: Container(
                  //     alignment: Alignment.centerRight,
                  //     color: ConstantColor.primaryMainColor,
                  //     padding: EdgeInsets.symmetric(horizontal: screenWidth/20.0),
                  //     child:  Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         const Icon(Icons.delete_forever,
                  //             color: ConstantColor.primaryBackgroundMainColor),
                  //         customeText(text: "Delete",
                  //             style: ConstantTextStyle.loginButtonTextStyle)
                  //       ],
                  //     ),
                  //   ),
                  //   onDismissed: (direction) async {
                  //     await fetchSellerRegistrationBodyApi(
                  //       context: context,
                  //       baseUrl: '${ConstantUrls.baseUriApi}${ConstantUrls.getBulkDeleteProductsEndPoint}',
                  //       body: {"products_ids": data['productIDs'].toString()},
                  //       onSuccess: () {
                  //         setState(() {
                  //           currentPage = 1;
                  //           isLoading = true;
                  //           selectedCheckBoxs = '';
                  //           data!.clear();
                  //           // approvedPendingOdDataList!.clear();
                  //           // fetchApprovedPendingListData();
                  //         });
                  //       },
                  //     );
                  //   },
                  child:Container(
                    // color: ConstantColor.primaryBackgroundMainColor,
                    margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                    decoration: BoxDecoration(
                      color: ConstantColor.primaryBackgroundMainColor,
                      //isSelected ? Colors.grey :ConstantColor.primaryBackgroundMainColor,
                      border: Border.all(color: ConstantColor.secondtryGrayColor),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const[
                        BoxShadow(
                          color:Colors.black12,
                          //isSelected ? Colors.black26 : Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          cachedImageWidget(
                            context:context,
                            height: screenHeight / 8.0,
                            width: screenWidth/4.0,
                            imageFile: data['image'].toString()??"",
                            assetImageFit: BoxFit.fill,
                          ),
                          SizedBox(width: screenWidth/40.0),
                          // Product Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customeText(text:'Category : ${data['category'] ?? ""}', style: ConstantTextStyle.allHomeScreenAvatarText),
                                customeText(text:'Keyword : ${data['keyword'] ?? ""}', style: ConstantTextStyle.allHomeScreenAvatarText),
                                colorBoxWidget(
                                  margin: EdgeInsets.only(right: screenWidth/8.0,top: screenHeight/80.0,bottom: screenHeight/80.0),
                                  textAlign: TextAlign.center,
                                  context:context,
                                  color: ConstantColor.calendarBGHeadColor,
                                  text: 'Media Type : ${data['mediaType'].toString()??""}',
                                  style: ConstantTextStyle.tabButtonTextStyle,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(color: getStatusColor(data['status'].toString().toUpperCase()??""), borderRadius: BorderRadius.circular(5.0)),
                                        child: Center(child: Text(data['status']??"", style: ConstantTextStyle.chipText)),
                                      ),
                                    ),
                                    SizedBox(width: screenWidth/40.0),
                                    Expanded(
                                      child:
                                      Container(
                                        decoration: BoxDecoration(color: getStatusColor(data['approval'].toString().toUpperCase()), borderRadius: BorderRadius.circular(5.0)),
                                        child: Center(child: Text(data['approval']??"", style: ConstantTextStyle.chipText)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // SingleChildScrollView(
          //   scrollDirection: Axis.vertical,
          //   child:   ScrollbarTheme(
          //     data: ScrollbarThemeData(
          //       crossAxisMargin: 2.5,
          //       radius: const Radius.circular(10.0),
          //       thickness: MaterialStateProperty.all(4.0),
          //       trackBorderColor: MaterialStateProperty.all(
          //           ConstantColor.trackBGolor),
          //       thumbColor: MaterialStateProperty.all(
          //           ConstantColor.primaryMainColor),
          //       trackColor: MaterialStateProperty.all(
          //           ConstantColor.trackBGolor),
          //     ),
          //     child:Padding(
          //       padding: EdgeInsets.symmetric(horizontal: screenWidth/30, vertical: screenHeight/60),
          //       child: Scrollbar(
          //         controller: _scrollController,
          //         trackVisibility: true,
          //         thumbVisibility: true,
          //         child: SingleChildScrollView(
          //           controller: _scrollController,
          //           scrollDirection: Axis.horizontal,
          //           child:
          //           // Column(
          //           //   crossAxisAlignment: CrossAxisAlignment.start,
          //           //   children: [
          //           //     // customeText(text: "\tUploaded videos",style: ConstantTextStyle.topCategoryText4),
          //           //     Container(
          //           //       decoration: BoxDecoration(
          //           //         borderRadius: BorderRadius.circular(8.0),
          //           //         color: ConstantColor.calendarBGHeadColor,
          //           //       ),
          //           //       padding: EdgeInsets.symmetric(horizontal: screenWidth/30, vertical: screenHeight/60),
          //           //        margin: EdgeInsets.symmetric(vertical: screenHeight/60),
          //           //       child: Table(
          //           //         columnWidths: {
          //           //           0: FixedColumnWidth(screenWidth * 0.4), // Adjust column width as needed
          //           //           1: FixedColumnWidth(screenWidth * 0.4),
          //           //           2: FixedColumnWidth(screenWidth * 0.4),
          //           //           3: FixedColumnWidth(screenWidth * 0.4),
          //           //           4: FixedColumnWidth(screenWidth * 0.4),
          //           //           5: FixedColumnWidth(screenWidth * 0.4),
          //           //           6: FixedColumnWidth(screenWidth * 0.4),
          //           //           7: FixedColumnWidth(screenWidth * 0.4),
          //           //         },
          //           //         children: [
          //           //           TableRow(
          //           //             children: [
          //           //               TableCell(child: customeText(text: "Video / Image", textAlign: TextAlign.center, style: ConstantTextStyle.tabButtonTextStyle)),
          //           //               TableCell(child: Text("Thumbnail Image", textAlign: TextAlign.center, style: ConstantTextStyle.tabButtonTextStyle)),
          //           //               TableCell(child: Text("Media Type", textAlign: TextAlign.center, style: ConstantTextStyle.tabButtonTextStyle)),
          //           //               TableCell(child: Text("Category", textAlign: TextAlign.center, style: ConstantTextStyle.tabButtonTextStyle)),
          //           //               TableCell(child: Text("Keyword", textAlign: TextAlign.center, style: ConstantTextStyle.tabButtonTextStyle)),
          //           //               TableCell(child: Text("Approval",  textAlign: TextAlign.center,style: ConstantTextStyle.tabButtonTextStyle)),
          //           //               TableCell(child: Text("Status",  textAlign: TextAlign.center,style: ConstantTextStyle.tabButtonTextStyle)),
          //           //               TableCell(child: Text("Action",  textAlign: TextAlign.center,style: ConstantTextStyle.tabButtonTextStyle)),
          //           //             ],
          //           //           ),
          //           //         ],
          //           //       ),
          //           //     ),
          //           //     Table(
          //           //       columnWidths: {
          //           //         0: FixedColumnWidth(screenWidth * 0.4), // Adjust column width as needed
          //           //         1: FixedColumnWidth(screenWidth * 0.4),
          //           //         2: FixedColumnWidth(screenWidth * 0.4),
          //           //         3: FixedColumnWidth(screenWidth * 0.4),
          //           //         4: FixedColumnWidth(screenWidth * 0.4),
          //           //         5: FixedColumnWidth(screenWidth * 0.4),
          //           //         6: FixedColumnWidth(screenWidth * 0.4),
          //           //         7: FixedColumnWidth(screenWidth * 0.4),
          //           //       },
          //           //       children: [
          //           //         // TableRow(
          //           //         //   decoration: BoxDecoration(
          //           //         //     borderRadius: BorderRadius.circular(8.0),
          //           //         //     color: ConstantColor.calendarBGHeadColor,
          //           //         //   ),
          //           //         //   children: [
          //           //         //     TableCell(child: paddingText(context: context, title:"Video / Image",textAlign: TextAlign.center,)),
          //           //         //     TableCell(child: paddingText(context: context, title:"Thumbnail Image",textAlign: TextAlign.center,)),
          //           //         //     TableCell(child: paddingText(context: context, title:"Media Type",textAlign: TextAlign.center,)),
          //           //         //     TableCell(child: paddingText(context: context, title:"Category",textAlign: TextAlign.center,)),
          //           //         //     TableCell(child: paddingText(context: context, title:"Keyword",textAlign: TextAlign.center,)),
          //           //         //     TableCell(child: paddingText(context: context, title:"Approval",textAlign: TextAlign.center,)),
          //           //         //     TableCell(child: paddingText(context: context, title:"Status",textAlign: TextAlign.center,)),
          //           //         //     TableCell(child: paddingText(context: context, title:"Action",textAlign: TextAlign.center,)),
          //           //         //     // TableCell(child: Text("",  textAlign: TextAlign.center,style: ConstantTextStyle.tabButtonTextStyle)),
          //           //         //   ],
          //           //         // ),
          //           //         ...videoData!.map((data) {
          //           //           return TableRow(
          //           //             decoration: const BoxDecoration(
          //           //                 border: Border(bottom: BorderSide(color: ConstantColor.calendarBGHeadColor),)),
          //           //             children: [
          //           //               TableCell(child: Container(
          //           //                   padding:  EdgeInsets.symmetric(horizontal: screenWidth/14,vertical: screenHeight/100),
          //           //                   margin:  EdgeInsets.only(bottom: screenHeight/60.0),
          //           //                   height: screenHeight/10,
          //           //                   child: VideoApp(url: data['video'].toString(),)),
          //           //               ),
          //           //               TableCell(
          //           //                   child: Padding(
          //           //                     padding:  EdgeInsets.symmetric(horizontal: screenWidth/10,vertical: screenHeight/200),
          //           //                     child: cachedImageWidget(context:context,imageFile: data['image'] ?? "",height: screenHeight/12),
          //           //                   )),
          //           //               TableCell(
          //           //                   child: Container(
          //           //                     margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
          //           //                     child: customeText(text: data['mediaType'] ?? "", textAlign: TextAlign.center,
          //           //                         style:  ConstantTextStyle.allHomeScreenAvatarText
          //           //                     ),
          //           //                   )),
          //           //               TableCell(
          //           //                   child: Container(
          //           //                     margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0,),
          //           //                     child: customeText(text: data['category'] ?? "", textAlign: TextAlign.center,
          //           //                         style:  ConstantTextStyle.allHomeScreenAvatarText
          //           //                     ),
          //           //                   )),
          //           //               TableCell(
          //           //                   child: Container(
          //           //                     margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
          //           //                     child: customeText(text: data['keyword'] ?? "", textAlign: TextAlign.center,
          //           //                         style:  ConstantTextStyle.allHomeScreenAvatarText
          //           //                     ),
          //           //                   )),
          //           //               TableCell(
          //           //                 child: Container(
          //           //                   margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0, horizontal: screenWidth / 10.0),
          //           //                   decoration: BoxDecoration(color: getStatusColor(data['approval'].toString().toUpperCase()??""), borderRadius: BorderRadius.circular(5.0)),
          //           //                   child: customeText(text: data['approval'] ?? "", textAlign: TextAlign.center,
          //           //                       style:  ConstantTextStyle.chipText
          //           //                   ),
          //           //                 ),
          //           //               ),
          //           //               TableCell(
          //                           child: Container(
          //                             margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0, horizontal: screenWidth / 10.0),
          //                             decoration: BoxDecoration(color: getStatusColor(data['status'].toString().toUpperCase()??""), borderRadius: BorderRadius.circular(5.0)),
          //                             child: customeText(text: data['status'] ?? "", textAlign: TextAlign.center,
          //                                 style:  ConstantTextStyle.chipText
          //                             ),
          //                           ),
          //           //               ),
          //           //               TableCell(child: IconButton(onPressed: () {
          //           //                 YesNoPermissionDialog.showExitConfirmationDialog(
          //           //                   context:context, title: 'Please Confirm!', content: 'Are you sure want to delete this video?',
          //           //                   actions: [
          //           //                     customButton(
          //           //                       textStyleButton: ConstantTextStyle.landingScreenAppbarText,
          //           //                       onPressed:() async {
          //           //                         Navigator.pop(context);
          //           //                         await fetchSellerRegistrationBodyApi(
          //           //                           context: context,
          //           //                           baseUrl: '${ConstantUrls.baseUriApi}${ConstantUrls.getDeleteReelsApi}',
          //           //                           body: {"reel_id": data['reel_id'],},
          //           //                           onSuccess: ()  {
          //           //                             setState(() {
          //           //                               currentPage = 1;
          //           //                               isLoading = true;
          //           //                               data!.clear();
          //           //                               videoData!.clear();
          //           //                               fetchGetReelsListData();
          //           //                             });
          //           //                           },
          //           //                         );
          //           //                       },
          //           //                       text: "Yes",
          //           //                       backgroundColor: ConstantColor.loginWithOtpButtonColor,
          //           //                       borderRadius: BorderRadius.circular(20.0),
          //           //                       elevation: 0.0,
          //           //                     ),
          //           //                     constantWidth(context, 100.0),
          //           //                     customButton(
          //           //                       textStyleButton: ConstantTextStyle.landingScreenAppbarText,
          //           //                       onPressed:() => Navigator.pop(context),
          //           //                       text: "No",
          //           //                       backgroundColor: ConstantColor.primaryMainColor,
          //           //                       borderRadius: BorderRadius.circular(20.0),
          //           //                       elevation: 0.0,
          //           //                     ),
          //           //
          //           //                   ],
          //           //
          //           //                 );
          //           //               },
          //           //                 icon: const Card(child: Icon(Icons.delete_outlined,color: ConstantColor.primaryMainColor,)),)),
          //           //             ],
          //           //           );
          //           //         }).toList() ?? [],
          //           //       ],
          //           //
          //           //     )
          //           //   ],
          //           // ),
          //
          //
          //
          //         ),
          //       ),
          //     ),
          //   ),
          // )

        )
    );
  }
}










