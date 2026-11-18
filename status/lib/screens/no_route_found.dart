import 'package:centavizers/helpers/string_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoRouteFound extends StatelessWidget {
  const NoRouteFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppString.somethingWentWrong),
      ),
      body:  Center(
        child: Text(AppString.noRouteFound),
      ),
    );
  }
}
