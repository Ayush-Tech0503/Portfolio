// lib/main.dart

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_rohit/Helper/dimens_helper.dart';
import 'package:test_rohit/Screen/webview_screen.dart';
import 'package:test_rohit/Utils/app_strings.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../Cubits/hacker_news_cubit.dart';
import '../Cubits/hacker_news_state.dart';
import '../Model/post.dart';
import '../Utils/app_bar.dart';
import '../Widgets/button.dart';
import '../Widgets/text_widget.dart';


class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(DimensHelper.dimens_8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(DimensHelper.dimens_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text(
             title: post.title,
              maxLine: 2,
              style: TextStyle(fontSize:DimensHelper.dimens_16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: DimensHelper.dimens_8),
            text(title:'by ${post.by} | Score: ${post.score}'),
            SizedBox(height: DimensHelper.dimens_8),
            CustomButton(
              onPressed: () {
                if (post.url.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewScreen(url: post.url),
                    ),
                  );
                }
              },
              title: AppStrings().readMore,
            ),
          ],
        ),
      ),
    );
  }
}

