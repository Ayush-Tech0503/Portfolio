import 'package:Citybazar_app/Widgets/custome_text.dart';
import 'package:flutter/material.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../../Widgets/Famous Market Widget/store_details_widget.dart';
import '../../Widgets/Send Enquiry dialogBox/alert_dialog_box.dart';
import '../../Widgets/custome_button_.dart';
import '../../Widgets/custome_richtext.dart';
import '../../Widgets/famous_market_card_widget.dart';

class ReviewAndRatingScreen extends StatefulWidget {
  const ReviewAndRatingScreen({super.key});

  @override
  State<ReviewAndRatingScreen> createState() => _ReviewAndRatingScreenState();
}

class _ReviewAndRatingScreenState extends State<ReviewAndRatingScreen> {

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: ConstantColor.primaryMainColor,
      child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: ConstantColor.primaryMainColor,
              elevation: 0.0,
              title: Text(
                  'Review',
                  style: ConstantTextStyle.topCategoryText3,
                  overflow: TextOverflow.ellipsis,
                ),
              titleSpacing: 0.0,
            ),
            extendBody: true,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: ConstantColor.primaryBackgroundMainColor,
              child: SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: customRichText(
                        TextAlign: TextAlign.start,
                        text1: "Review & rating ".toUpperCase(),
                        style1: ConstantTextStyle.secodHearText,
                      ),

                      minVerticalPadding : screenWidth/20,
/*---------------------------------Write a Review button dialog box start------------------------------------*/
                      trailing: customeButton(
                          textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return alertReviewDialogBox(
                                      dialogBoxborderShap: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0)),
                                      context:context,
                                      titleText: "Write a Review",
                                      titleTextAlign: TextAlign.center,
                                      titleStyle: ConstantTextStyle.allHomeScreenAvatarText,
                                      descriptionText: "",
                                      // descriptionTextStyle:ConstantTextStyle.secondorGrayText,
                                      buttonText: "Submit".toUpperCase(),
                                      submitButton: () {
                                        Navigator.of(ctx).pop();
                                      },
                                    );
                                }
                            );
                          },
                          text: "Write a Review",
                          backgroundColor: ConstantColor.primaryMainColor,
                          borderRadius:
                          BorderRadius.circular(8.0),
                          minimumSize: Size(screenWidth / 3.5,
                              screenHeight / 25.0),
                        ),
                    ),
/*---------------------------------Write a Review button and dialog box end----------------------------------*/
/*---------------------------------Rich text Rating section start --------------------------------------------*/
                    Container(
                      padding: EdgeInsets.only(
                        top: screenHeight/100,
                        left: screenWidth/20,
                        right: screenWidth/30,
                      ),
                      child: Row(
                        children: [
                          Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customeText(
                                text: "5.00".toUpperCase(),
                                style: ConstantTextStyle.ratingBigTextSize,
                              ),
                              ratingsStar(
                                width: screenWidth /5,
                                height: screenHeight / 30,
                                bgColor: ConstantColor.transparent1,
                                initialRating: 3.5,
                                itemSize: 16.0,
                                minRating: 1.0,
                                allowHalfRating: true,
                                itemCount: 5,
                                onRatingUpdate: (rating) {},
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: ConstantColor.starRatingColor,
                                ),
                              ),
                              customeText(
                                text: "1 Ratings",
                                style: ConstantTextStyle.cardbottumText,
                              ),
                            ],
                          ),
/*---------------------------------Rich text Rating section end --------------------------------------------*/
/*----------------------Grid view section two Text and progressIndicator start--------------------*/
                          Expanded(
                            child:  GridView.builder(
                              padding: EdgeInsets.only(
                                right: screenWidth / 10,
                                left: screenWidth / 40,
                              ),
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 5,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: (2 / 2),
                                  mainAxisSpacing: 1,
                                  mainAxisExtent: 30),
                              itemBuilder:
                                  (BuildContext context, index) {
                                 return ListTile(
                                   leading: customRichText(
                                     TextAlign: TextAlign.start,
                                     text1: "Excellent",
                                     style1: ConstantTextStyle
                                         .subRatingText,
                                   ),
/*----------------------------------LinearProgressIndicator Start----------------------------*/
                                   title:  progressIndicator(
                                     borderRadius:
                                     BorderRadius.circular(8.0),
                                     height: screenHeight / 120,
                                     width: screenWidth / 5.4,
                                     value: 1.0, // percent filled
                                     valueColor:
                                     const AlwaysStoppedAnimation(
                                         ConstantColor
                                             .filedContainerColor),
                                     backgroundColor: ConstantColor
                                         .primaryBackgroundMainColor,
                                   ),
/*----------------------------------LinearProgressIndicator end----------------------------*/
                                   trailing: customRichText(
                                     TextAlign: TextAlign.start,
                                     text1: "10",
                                     style1:
                                     ConstantTextStyle.ratingText2,
                                   ),
                                 );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
/*----------------------Grid view section two Text and progressIndicator end--------------------*/
          SizedBox(height: screenHeight/40,),
                       Padding(
                         padding:  EdgeInsets.symmetric(horizontal: screenWidth/30),
                         child: ListTile(
                           contentPadding: EdgeInsets.zero,
                           leading: customRichText(
                             TextAlign: TextAlign.start,
                             text1: "Recent Reviews",
                             style1: ConstantTextStyle.storeDetailsText3,
                           ),
                           title: Padding(
                             padding:  EdgeInsets.only(left: screenWidth/5),
                             child: const Icon(Icons.filter_list_outlined),
                           ),
                             trailing:customRichText(
                               TextAlign: TextAlign.start,
                               text1: "New to Older",
                               style1: ConstantTextStyle.subRatingText,
                             ),
                         ),
                       ),
/*-----------------------------------------------------------------------------*/
                    SizedBox(
                      height: screenHeight/2,
                      child: ListView.builder(
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: const Icon(Icons.person_outline_rounded,size: 40,),
                              title: customRichText(
                                TextAlign: TextAlign.start,
                                text1: "Profile name",
                                style1: ConstantTextStyle.subRatingText,
                              ),
                              subtitle:SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: startRating(
                                  width: screenWidth /3,
                                  height: screenHeight / 30,
                                  context: context,
                                  color: ConstantColor.transparent1,
                                  text2: "4.5/5.0",
                                  style2: ConstantTextStyle.allHomeScreenAvatarText,
                                  initialRating: 3.5,
                                  itemSize: 14.0,
                                  minRating: 1.0,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  onRatingUpdate: (rating) {},
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: ConstantColor.starRatingColor,
                                  ),
                                ),
                              ),

                            );
                          }
                      ),
                    ),
/*-----------------------------------------------------------------------------*/


                  ],
                ),
              ),

            ),


/*----------------------------------------------------------------------------*/
          ),
        ),
    );
  }
}
