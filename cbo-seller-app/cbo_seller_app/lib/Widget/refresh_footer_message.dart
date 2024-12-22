
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Widget customFooter() {
  return CustomFooter(
    builder: (BuildContext context, status) {
      Widget body;
      if (status == LoadStatus.idle) {
        body = const Text("");
      } else if (status == LoadStatus.loading) {
        body = const CupertinoActivityIndicator.partiallyRevealed();
      } else if (status == LoadStatus.failed) {
        body = const Text("Load Failed!Click retry!");
      } else if (status == LoadStatus.canLoading) {
        body = const Text("release to load more");
      } else {
        body = const Text("No More Data",);
      }
      return SizedBox(
        height: 55.0,
        child: Center(child: body),
      );
    },
  );
}