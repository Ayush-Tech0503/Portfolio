import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../Layouts/constant_screen_layout.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';

class SinglePdfFileScreen extends StatelessWidget {
  final String? fileUrl;

  const SinglePdfFileScreen({Key? key, this.fileUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: "",
      titleStyle: ConstantTextStyle.landingScreenAppbarText,
      leading: IconButton(
        icon: const Icon(Icons.close_rounded,size: 30.0,), color: ConstantColor.drawerDividerColor,
        onPressed: () => Navigator.pop(context),
      ),
      scaffoldColor: ConstantColor.primaryBackgroundMainColor,
      appBarColor: ConstantColor.primaryBackgroundMainColor,
      body: PDFView(
        filePath: fileUrl!,
      ),
    );
  }
}

