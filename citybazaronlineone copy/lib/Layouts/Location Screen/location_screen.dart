import 'package:flutter/material.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../../Widgets/custome_richtext.dart';
import '../../Widgets/custome_text.dart';
import '../../Widgets/login_textformfiled.dart';

void main() => runApp(const MyApplication());

class MyApplication extends StatefulWidget {
  const MyApplication({super.key});

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amazing Dialog'),
      ),
/*---------------------------------------------------------------------------------------------*/
      body: Center(
        child: TextButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return
                AlertDialog(
                insetPadding: EdgeInsets.symmetric(
                  horizontal: screenWidth/30,
                  vertical: screenWidth/3,
                ),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: Padding(
                  padding:  EdgeInsets.only(
                    top: screenHeight/40,
                    bottom: screenHeight/40,
                  ),
                  child: customeText(
                    textAlign: TextAlign.center,
                    text: 'choose your location'.toUpperCase(),
                    style: ConstantTextStyle.secodHearText,
                  ),
                ),
/*---------------------------------------------------------------------------------------------*/
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ConstantColor.secondoryMarketColors,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          //   contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                          leading: const Icon(
                            Icons.location_on_outlined,
                            size: 25,
                            color: ConstantColor.primaryMainColor,
                          ),
                          title: customeText(
                            text: "Online Product searching of your city's seller"
                                " is most used online website to search",
                            style: ConstantTextStyle.otpResendButtonText,
                          ),
                        ),
                      ),

/*---------------------------------------------------------------------------------------------*/
                      SizedBox(height: screenHeight / 40,),
                      loginTextFormField1(
                        borderSideColor: ConstantColor.primaryMainColor,
                        prefixIcon: const Icon(
                          Icons.search_outlined,
                          size: 25,
                          color: ConstantColor.primaryMainColor,
                        ),
                        context: context,
                        labelText: "Search City, Area",
                        labelStyle: ConstantTextStyle.lableTextStyle2,
                        hintText: '',
                        hintStyle: ConstantTextStyle.hintTextStyle,
                        cursorColor: ConstantColor.primaryMainColor,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email ID';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                          });
                        },
                      ),

/*---------------------------------------------------------------------------------------------*/
                      SizedBox(height: screenHeight / 150,),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(190, 1),
                          backgroundColor: ConstantColor.primaryMainColor,
                        ),
                        icon: const Icon(Icons.location_on_outlined),
                        label: customeText(
                          text: "Use current location",
                          style: ConstantTextStyle.newiconButtonText,
                        ),
                        onPressed: () {
                          // Button action
                        },
                      ),
/*---------------------------------------------------------------------------------------------*/
                      SizedBox(height: screenHeight / 50,),
                      Container(
                        height: screenHeight / 20,
                        decoration: BoxDecoration(
                          color: ConstantColor.secondoryMarketColors,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            customRichText(
                              text1: "Search within",
                              TextAlign: TextAlign.start,
                              style1: ConstantTextStyle.colorsHeadingText,
                              text2: ' 03 ',
                              style2: ConstantTextStyle.otpResendButtonText,
                              text3: "KM",
                              style3: ConstantTextStyle.colorsHeadingText,
                            ),
                            SliderTheme(
                              data: const SliderThemeData(
                                trackHeight: 3.0,
                                activeTrackColor: ConstantColor.primaryMainColor,
                                thumbColor:
                                    ConstantColor.primaryBackgroundMainColor,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 8.0),
                              ),
                              child: SizedBox(
                                width: screenWidth / 2.3,
                                child: Slider(
                                  value: 0.4, // Set the initial value of the slider
                                  onChanged: (double value) {},
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
/*---------------------------------------------------------------------------------------------*/
                      SizedBox(height: screenHeight / 40,),
                      customeText(
                        text: "Most Searched Locations",
                        style: ConstantTextStyle.storeDetailsText3,
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              );


            },
          ),
          child: const Text('Show Dialog'),
        ),
      ),
    );
  }
}
