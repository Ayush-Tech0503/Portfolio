import 'package:flutter/material.dart';

Widget constantHeight(BuildContext context, double num) {
  return SizedBox(height: MediaQuery.of(context).size.height/num,);
}

Widget constantWidth(BuildContext context, double num) {
  return SizedBox(width: MediaQuery.of(context).size.width/num,);
}
