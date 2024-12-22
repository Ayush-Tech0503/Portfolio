// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Util/Const Toster/toster.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../Util/Validation/validation_data.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../custome_button_.dart';

class ReviewRatingScreen extends StatefulWidget {
  final sellersId;
  const ReviewRatingScreen({super.key, this.sellersId}); // Corrected constructor

  @override
  _ReviewRatingScreenState createState() => _ReviewRatingScreenState();
}

class _ReviewRatingScreenState extends State<ReviewRatingScreen> {
  //---------------review and rating api start -----------------------
  bool reviewLoader = false;
  TextEditingController sellerRatingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
   var tokenAccess;
  String rating = "";

  fetchReviewRating({tokenAccess}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      tokenAccess = preference.getString("access-token");
      setState(() {
        reviewLoader = true;
      });
      final body = {
        "seller_id": widget.sellersId,
        "rate_val": rating,
        "review": sellerRatingController.text.toString(),
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.getSellerReviewsRating}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.data);
        if (responseData["status"] == "success") {
          LoadingScaffoldMessage.showSnackbar(
            context,
            responseData['msg'],
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          );
        }
        else{
          LoadingScaffoldMessage.showSnackbar(
            context,
            responseData['msg'],
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          );
        }
        Navigator.pop(context);
      }
      setState(() {
        reviewLoader = false;
      });
    } catch (error) {
      setState(() {
        reviewLoader = false;
      });
    }
  }

//---------------review and rating api end -----------------------

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: AlertDialog(
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
          title:  Text("Write a Review",style:  ConstantTextStyle.topCategoryText4,textAlign: TextAlign.center,),
          content:  TextFormField(
            controller: sellerRatingController,
            validator: validateReviewRating,
            cursorColor: ConstantColor.filedContainerColor,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: ConstantColor.secondtryGrayColor),
              ),
              labelText: 'Write your review',
              labelStyle: TextStyle(
                  color: ConstantColor.filedContainerColor
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: ConstantColor.secondtryGrayColor
                ),
              ),
            ),
          ),
          actions: [
            Center(
              child: RatingBar.builder(
                initialRating: 0.0,
                itemSize: 40.0,
                minRating: 1.0,
                ignoreGestures: false,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: ConstantColor.starRatingColor,
                ),
                onRatingUpdate: (newRating) {
                  rating = newRating.toString();
                },
              ),
            ),
            SizedBox( height: MediaQuery.of(context).size.height /50,),
            Center(
              child: customeButton(
                // textStyleButton: textStyleButton,
                onPressed:(){
                  if (rating.isNotEmpty) {
                    fetchReviewRating(tokenAccess: tokenAccess);
                  }else{
                    LoadingScaffoldMessage.showSnackbar(
                      context,"Please provide a rating",
                      ConstantColor.primaryMainColor,
                      const Duration(seconds: 2),
                    );
                  }
                },
                text: "Submit".toUpperCase(),
                backgroundColor: ConstantColor.primaryMainColor,
                borderRadius: BorderRadius.circular(8.0),
                minimumSize: Size(MediaQuery.of(context).size.width / 3.5,
                    MediaQuery.of(context).size.height / 25.0),
              ),
            ),
          ]
      )
    );
  }
}