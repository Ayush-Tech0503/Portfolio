import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../Layouts/constant_screen_layout.dart';
import '../Font Style/text_styles.dart';
import '../Theme/constant_colors.dart';

class PaymentGatewayScreen extends StatelessWidget {
  final String paymentUrl;
  final String encryptedData;
  final String accessCode;

  const PaymentGatewayScreen({super.key,
    required this.paymentUrl,
    required this.encryptedData,
    required this.accessCode,
  });

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: "Payment Gateway",
      titleStyle: ConstantTextStyle.landingScreenAppbarText,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
        onPressed: () => Navigator.pop(context),
      ),
      scaffoldColor: ConstantColor.primaryBackgroundMainColor,
      appBarColor: ConstantColor.loginWithOtpButtonColor,
      body: WebView(
        initialUrl: Uri.dataFromString(
          """
          <html>
            <body onload="document.forms[0].submit();">
              <form action="$paymentUrl" method="post">
                <input type="hidden" name="encRequest" value="$encryptedData" />
                <input type="hidden" name="access_code" value="$accessCode" />
              </form>
            </body>
          </html>
          """,
          mimeType: 'text/html',
        ).toString(),
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (String url) {
          // Optionally handle post-page load events here
        },
      ),
    );
  }
}
