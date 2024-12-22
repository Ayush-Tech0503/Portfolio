// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Models/subscription_plan_model.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../../Widget/Status Chip Object Color /status_chip_bg_color_widget.dart';
import '../../Widget/custome_text_widget.dart';
import '../../demo.dart';

class PaymentHistoryScreen extends StatefulWidget {
  final List<AllSubsData>? allSubsData;

  const PaymentHistoryScreen({super.key, this.allSubsData});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {

  @override
  void initState() {
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ConstantColor.primaryBackgroundMainColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: ConstantColor.calendarBGHeadColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: screenWidth/30, vertical: screenHeight/60),
                child: Table(
                  columnWidths: {
                    0: FixedColumnWidth(screenWidth * 0.4), // Adjust column width as needed
                    1: FixedColumnWidth(screenWidth * 0.4),
                    2: FixedColumnWidth(screenWidth * 0.4),
                    3: FixedColumnWidth(screenWidth * 0.4),
                    4: FixedColumnWidth(screenWidth * 0.4),
                    5: FixedColumnWidth(screenWidth * 0.4),
                    6: FixedColumnWidth(screenWidth * 0.4),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(child: customeText(text: "Order Id", textAlign: TextAlign.center, style: ConstantTextStyle.tabButtonTextStyle)),
                        TableCell(child: Text("Subscription Start Date", textAlign: TextAlign.center, style: ConstantTextStyle.tabButtonTextStyle)),
                        TableCell(child: Text("Subscription End Date", textAlign: TextAlign.center, style: ConstantTextStyle.tabButtonTextStyle)),
                        TableCell(child: Text("Subscription Date", textAlign: TextAlign.center, style: ConstantTextStyle.tabButtonTextStyle)),
                        TableCell(child: Text("Payment Status", textAlign: TextAlign.center, style: ConstantTextStyle.tabButtonTextStyle)),
                        TableCell(child: Text("Order Amount",  textAlign: TextAlign.center,style: ConstantTextStyle.tabButtonTextStyle)),
                        TableCell(child: Text("Invoice",  textAlign: TextAlign.center,style: ConstantTextStyle.tabButtonTextStyle)),
                      ],
                    ),
                  ],
                ),
              ),
              Table(
                columnWidths: {
                  0: FixedColumnWidth(screenWidth * 0.4), // Adjust column width as needed
                  1: FixedColumnWidth(screenWidth * 0.4),
                  2: FixedColumnWidth(screenWidth * 0.4),
                  3: FixedColumnWidth(screenWidth * 0.4),
                  4: FixedColumnWidth(screenWidth * 0.4),
                  5: FixedColumnWidth(screenWidth * 0.4),
                  6: FixedColumnWidth(screenWidth * 0.4),
                },
                children: widget.allSubsData?.map((data) {
                  return TableRow(
                      decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: ConstantColor.calendarBGHeadColor),)),
                    children: [
                      TableCell(child: Text(data.orderId ?? "", textAlign: TextAlign.center, style: ConstantTextStyle.allHomeScreenAvatarText)),
                      TableCell(child: Text(data.sbuscriptionStartDate ?? "", textAlign: TextAlign.center, style: ConstantTextStyle.allHomeScreenAvatarText)),
                      TableCell(child: Text(data.sbuscriptionEndDate ?? "", textAlign: TextAlign.center, style: ConstantTextStyle.allHomeScreenAvatarText)),
                      TableCell(child: Text(data.sbuscriptionDate ?? "", textAlign: TextAlign.center, style: ConstantTextStyle.allHomeScreenAvatarText)),
                      TableCell(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0, horizontal: screenWidth / 10.0),
                          decoration: BoxDecoration(color: getStatusColor(data.paymentStatus.toString().toUpperCase()??""), borderRadius: BorderRadius.circular(5.0)),
                          child: customeText(text: data.paymentStatus ?? "", textAlign: TextAlign.center,
                              style:  ConstantTextStyle.chipText
                          ),
                        ),
                      ),
                      TableCell(child: Text(data.orderAmt ?? "", textAlign: TextAlign.center, style: ConstantTextStyle.allHomeScreenAvatarText)),
                      TableCell(
                        child: InkWell(
                          onTap: () async {
                              if (await canLaunch(data.sellerInvoice??"")) {
                                await launch(data.sellerInvoice??"");
                              }
                              else {
                                LoadingScaffoldMessage.showSnackbar(
                                  context, 'Could not launch ${data.sellerInvoice??""}',
                                  ConstantColor.primaryMainColor,
                                  const Duration(seconds: 2),
                                );
                              }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0, horizontal: screenWidth / 10.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),border: Border.all(color: ConstantColor.loginWithOtpButtonColor)),
                            child: customeText(text:"📥  Invoice",
                                textAlign: TextAlign.center,
                                style:  ConstantTextStyle.allHomeScreenAvatarText
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList() ?? [], // Provide an empty list as a fallback if allSubsData is null
              ),
            ],
          ),
        ),
      ),
    );
  }
}


