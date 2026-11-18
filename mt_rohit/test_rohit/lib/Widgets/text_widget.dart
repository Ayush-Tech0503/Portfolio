import 'package:flutter/material.dart';

Widget text({title, style, maxLine}) => Text(
title ??'',
style: style,
maxLines: maxLine ?? 2,
);