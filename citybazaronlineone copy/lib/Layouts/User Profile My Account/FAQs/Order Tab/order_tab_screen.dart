import 'dart:convert';
import 'package:Citybazar_app/Util/constaint_textstyle.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Models/FAQ Model/faq_model.dart';
import '../../../../Util/Constant APi Url/api_urls.dart';
import '../../../../Util/constant_color.dart';
import '../../../../Widgets/landing_screen_slider.dart';
class OrderTabScreen extends StatefulWidget {
  const OrderTabScreen({super.key});

  @override
  State<OrderTabScreen> createState() => _OrderTabScreenState();
}
class _OrderTabScreenState extends State<OrderTabScreen> {
  bool isExpanded = false;
var userId;
var tokenAccess;
  FAQList? faqList;
  List<Data> data = [];
  bool isLoading = false;
  fetchAllProductList() async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      isLoading = true;
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.faqApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.data.toString());
        FAQList faqList = FAQList.fromJson(responseData);
        data.addAll(faqList.data ?? []);
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to fetch data $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAllProductList();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return isLoading
        ? const Center(
            child: SpinKitCircle(
              color: ConstantColor.primaryMainColor,
              size: 30.0,
            ),
          )
        : ListView.builder(
            physics: const ScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.only(top: screenHeight / 50),
                child: faqExpansionTile(
                  backgroundColor: ConstantColor.circleAvatar2,
                  collapsedBackgroundColor: ConstantColor.secondoryCardeColors,
                  collapsedShapeBoarder: BorderRadius.circular(10.0),
                  headText: data[index].question??"",
                  headStyle: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal),
                  subText: data[index].answer.toString(),
                  subTextContainerBoarder: BorderRadius.circular(10.0),
                  subTextContainerColor: ConstantColor.secondoryCardeColors,
                  onExpansionChanged: (value) {
                    setState(() {
                      isExpanded = value;
                    });
                  },
                ),
              );
            },
          );
  }
}
