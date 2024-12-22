
import 'package:flutter/material.dart';
import '../../Utils/Constant Size /constant_sizes.dart';

Widget iconRichText2 ({icon,color,size,text ,style, context}) {
  return Text.rich(  overflow: TextOverflow.ellipsis,
    TextSpan(
      children: [
        WidgetSpan(child: Icon(icon,color:color, size: size)),
        WidgetSpan(child: constantWidth(context, 80.0)),
        TextSpan(text: text,style: style),
      ],
    ),
  );
}

