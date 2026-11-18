import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../collection_card.dart';
import '../custome_button_.dart';

Widget alertDialogBox ({context,onTap,phoneNumber, buttonText,titleTextAlign, buttonStyle, titleText,titleStyle, icon ,descriptionTextStyle, descriptionText, iconbuttononPress}){
  void launchPhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  return GestureDetector(
    onTap: (){
      launchPhoneCall(phoneNumber);
    },
    child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        title:  Text(titleText,style: titleStyle ,textAlign: titleTextAlign,),
        backgroundColor: Colors.white,
        // iconPadding: EdgeInsets.only(
        //     left: MediaQuery.of(context).size.width /1.5,
        //     top: MediaQuery.of(context).size.height / 100),
        // icon: circleIcon(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   backgroundColor: ConstantColor.primaryMainColor,
        //   iconSize: 15.0,
        //   radius: 15.0,
        //   icons: Icons.close_outlined,
        //   iconcolor:
        //   ConstantColor.primaryBackgroundMainColor,
        // ),
        // insetPadding: EdgeInsets.symmetric(
        //   horizontal: MediaQuery.of(context).size.width / 30,
        //   vertical: MediaQuery.of(context).size.height / 10,
        // ),
        content: RichText(
          text: TextSpan(
            text: "आपकी Enquiry विक्रेता को शेयर कर दी गई है विक्रेता से बात करने के लिए कॉल करें  ",
            style: ConstantTextStyle.allHomeScreenAvatarText,
            children: <TextSpan>[
              TextSpan(
                text: descriptionText,
                style: ConstantTextStyle.checkboxTextStyle2,
              ),
              TextSpan(
                text: "\nनोट:- सिटी बाज़ार ऑनलाइन द्वारा प्रोडक्ट की डिलीवरी प्रदान नही की जाती हैं "
                    "यदि आप प्रोडक्ट डिलेवरी चाहिते हैं तो कृपया विक्रेता से संपर्क करे "
                    "या स्टोर पर जाकर ही खरीदें ।",
                style: ConstantTextStyle.allHomeScreenAvatarText
              ),
            ],
          ),
        ),
        // Text(descriptionText,style: descriptionTextStyle,
        // textAlign: TextAlign.start,),
        contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/20),
        titlePadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/50,),
        actions: [
          TextButton(
            onPressed: iconbuttononPress,
            child: Center(
              child: produtListRichText3(
                    icon: icon,
                    color: ConstantColor.bottonNavIcons,
                    text1: buttonText,
                    style1: buttonStyle,
                    context: context,
                ),
            ),
            ),
    ]
    ),
  );
}

Widget alertReviewDialogBox ({validator,controller,actionWidget,context, submitButton, dialogBoxborderShap, buttonText,titleTextAlign, titleText,titleStyle ,descriptionTextStyle, descriptionText,}){
  return AlertDialog(
      shape:dialogBoxborderShap,

      title:  Text(titleText,style: titleStyle ,textAlign: titleTextAlign,),
      content:  TextFormField(
        controller: controller,
        validator: validator,
        cursorColor: ConstantColor.filedContainerColor,
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: ConstantColor.secondtryGrayColor),
          ),
          labelText: 'Write your review',
          labelStyle: TextStyle(
              color: ConstantColor.filedContainerColor
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: ConstantColor.secondtryGrayColor
            ),
          ),
        ),
      ),
      actions: [ actionWidget,
        SizedBox( height: MediaQuery.of(context).size.height /50,),
        Center(
          child: customeButton(
            // textStyleButton: textStyleButton,
            onPressed: submitButton,
            text: buttonText,
            backgroundColor: ConstantColor.primaryMainColor,
            borderRadius: BorderRadius.circular(8.0),
            minimumSize: Size(MediaQuery.of(context).size.width / 3.5,
                MediaQuery.of(context).size.height / 25.0),
          ),
        ),
      ]
  );
}

Widget circleIcon ({onPressed, backgroundColor, radius, iconSize,icons, iconcolor}){
  return CircleAvatar(
    radius: radius,
    backgroundColor:backgroundColor,
    child: IconButton(
      onPressed: onPressed,
      color: iconcolor,
      iconSize: iconSize,
      icon: Icon(icons),
    ),
  );
}

