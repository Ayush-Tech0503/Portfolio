import 'package:Citybazar_app/Util/constant_color.dart';
import 'package:flutter/material.dart';
import '../../Util/constant_image.dart';

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({super.key});

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      backgroundColor: ConstantColor.primaryBackgroundMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Image.asset(
              ConstantImage.noInternetCBOImage,
              fit: BoxFit.fill,
            ),
          ),
          Flexible(
            child: Image.asset(
              ConstantImage.noInternetImage,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    ));
  }
}




