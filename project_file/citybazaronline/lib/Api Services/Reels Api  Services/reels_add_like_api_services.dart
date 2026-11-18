// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, empty_catches, library_private_types_in_public_api, deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Util/Const Toster/toster.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../Util/constant_color.dart';

class AddLikeApi {
  static  fetchAddLikedReels({required BuildContext context, reel_id,tokenAccess}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      tokenAccess = preference.getString("access-token");
      final body = {"reel_id": reel_id};
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi2}${ConstantUrls.addLikedReels}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );
      if (response.statusCode == 200) {
          _showLoveIcon(context);
      }
    } catch (e) {
      String errorMessage = "Oops! We couldn't report the issue. Please give it another shot later.";
      if (e is DioError && e.response != null) {
        errorMessage += " status code: ${e.response!.statusCode}";
      }
      LoadingScaffoldMessage.showSnackbar(
        context,
        errorMessage,
        ConstantColor.primaryMainColor,
        const Duration(seconds: 5),
      );
    }
  }

  static void _showLoveIcon(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return  const AlertDialog(
          elevation: 0,
          backgroundColor: ConstantColor.transparent1,
          content:AnimatedLoveIcon(),
        );
      },
    );
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }


}



class AnimatedLoveIcon extends StatefulWidget {
  const AnimatedLoveIcon({super.key});

  @override
  _AnimatedLoveIconState createState() => _AnimatedLoveIconState();
}

class _AnimatedLoveIconState extends State<AnimatedLoveIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _animation = Tween<double>(begin: 0, end: 100).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_rounded,
      color: Colors.white,
      size: _animation.value,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}


