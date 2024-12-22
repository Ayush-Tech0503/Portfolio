// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import '../Utils/Font Style/text_styles.dart';
import '../Widget/custome_text_widget.dart';

class AppLayout extends StatelessWidget {
  final Widget body;
  final String title;
  final titleStyle;
  final actions;
  final bottomNavigationBar;
  final Widget? leading;
  final Color? scaffoldColor;
  final Color? appBarColor;
  final VoidCallback? leadingOnPressed;

  const AppLayout({
    Key? key,
    required this.body,
    required this.title,
    this.leading,
    this.actions,
    this.bottomNavigationBar,
    this.leadingOnPressed,
    this.scaffoldColor,
    this.appBarColor, this.titleStyle,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      //ConstantColor.secondryBackgroundMainColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        leading: leading ??
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
        title: customeText(
          text: title,
          style: titleStyle ?? ConstantTextStyle.lableTextHeading1,
        ),
        backgroundColor: appBarColor,
        //ConstantColor.secondryBackgroundMainColor,
        actions: actions ??  [],
      ),
      bottomNavigationBar: bottomNavigationBar,
      body: body,
    );
  }
}
