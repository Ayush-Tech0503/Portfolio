// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, empty_catches

import 'dart:convert';
import 'dart:io';
import 'package:Citybazar_app/Util/constant_googlemap.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:search_map_location/utils/google_search/place.dart';
import 'package:search_map_location/widget/search_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/Location/mostsearchablelocation_model.dart';
import '../../../Util/Constant APi Url/api_urls.dart';
import '../../../Util/constaint_textstyle.dart';
import '../../../Util/constant_color.dart';
import '../../../Widgets/Send Enquiry dialogBox/alert_dialog_box.dart';
import '../../../Widgets/custome_richtext.dart';
import '../../../Widgets/custome_text.dart';
import '../../../Widgets/landing_screen_slider.dart';
import '../../../collapsing_appbar.dart';
class CustomAppbarLeadingData extends StatefulWidget {
   const CustomAppbarLeadingData({super.key,});
  @override
  State<CustomAppbarLeadingData> createState() => _CustomAppbarLeadingDataState();
}
class _CustomAppbarLeadingDataState extends State<CustomAppbarLeadingData> {
  String location = '';
  double _sliderValue = 10.0;

  MostSearchableLocation? mostSearchableLocation;
  List<LocationDataList>? locationData= [];
  var userId;
  bool isLoadingScreen=false;


var tokenAccess;

  fetchMostSearchableLocation() async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      setState(() {
        isLoadingScreen = true;
      });
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.mostSerchableLocationApi}",
        options: Options(
          headers: {
            "Authorization":tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.data.toString());
        mostSearchableLocation = MostSearchableLocation.fromJson(responseData);
        locationData!.addAll(mostSearchableLocation!.locationData??[]);
        setState(() {
          isLoadingScreen = false;
          //  isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoadingScreen = false;
      });
    }
  }
  final ScrollController scrollController = ScrollController();
  String locationName = "";
  Future<void> getLocationName({latitude,longitude}) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks[0];
        final location = "${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}";
        // Save location to SharedPreferences
        await saveLocationToSharedPreferences(location);
        setState(() {
          locationName = location;
        });
      }
    } catch (e) {
    }
  }

  Future<void> saveLocationToSharedPreferences(String location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('location', location);
  }

  Future<String?> getLocationFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('location');
  }

  var locationMessage1 = "";
  var locationMessage2 = "";
  void getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      Platform.isIOS ?
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text("Location Permission Denied"),
          content: const Text("Please enable location access in settings to use this feature."),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ): showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Location Permission Denied"),
          content: const Text("Please enable location access in settings to use this feature."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
      setState(() {
        locationMessage1 = "Location permission denied";
        locationMessage2 = ""; // Initialize to an empty string
      });
    }
    else {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        double latitude = position.latitude;
        double longitude = position.longitude;

        setState(() {
          locationMessage1 = latitude.toString(); // Convert to string
          locationMessage2 = longitude.toString(); // Convert to string
          getLocationName(latitude: locationMessage1, longitude: locationMessage2);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MyHomePageDemo1(
                    mobilenumber: '',
                    lat: locationMessage1,
                    id: "1111",
                    longitude: locationMessage2,
                    lName: "",
                  ),
            ),
          );
        });
      } catch (e) {}
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMostSearchableLocation();
    // getLocation();
    printLocationName();
    getLocationName(latitude:22.7177,longitude:75.8545);
  }


  Future<String?> getLocationNameFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('locationName');
  }
  String? storedLocationName;
  Future<void> printLocationName() async {
     storedLocationName = await getLocationNameFromPrefs();
setState(() {});
  }

  var latitude;
  var longitude;
  var _address;
  var lName;

  String getLocationPart(String location, int index) {
    List<String> parts = location.split(',');
    return parts.length > index && parts[index].isNotEmpty ? parts[index].trim() : "";
  }



  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return AlertDialog(
                     backgroundColor: Colors.white,
      iconPadding: EdgeInsets.only(left: screenWidth / 1.22, top: screenHeight/100),
                      icon: circleIcon(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        backgroundColor: ConstantColor.primaryMainColor,
                        iconSize: 15.0,
                        radius: 15.0,
                        icons: Icons.close_outlined,
                        iconcolor:
                        ConstantColor.primaryBackgroundMainColor,
                      ),
                      insetPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth / 30,
                        vertical: screenHeight / 10,
                      ),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      title: Padding(
                        padding: EdgeInsets.only(bottom: screenHeight / 80,),
                        child: customeText(
                          textAlign: TextAlign.center,
                          text: 'choose your location'.toUpperCase(),
                          style: ConstantTextStyle.secodHearText,
                        ),
                      ),
/*---------------------------------------------------------------------------------------------*/
                      content: CupertinoScrollbar(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
/*----------------------------Container Icon with Text in Row start--------------------------*/
                              rowIconText(
                                context: context,
                                icon: Icons.location_on_outlined,
                                iconSize: 20,
                                iconColor: ConstantColor.primaryMainColor,
                                text: (storedLocationName != null && storedLocationName!.isNotEmpty)
                                    ? storedLocationName
                                    : lName ?? _address ?? locationName,
                                textstyle: ConstantTextStyle.otpResendButtonText,
                                textAlignment: TextAlign.start,
                                textPaddingLeft: screenWidth / 40,
                                textWidth: screenWidth / 1.4,
                              ),
                        /*----------------------------Container Icon with Text in Row end--------------------------*/
                              SizedBox(height: screenHeight / 40,),
                        /*------------------------------search box filed start----------------------------------------*/
                              CustomSearchLocation(
                               placeholder: "Search City, Area",
                               radius: 0.0,
                               apiKey: ConstantGoogleMap.apiKey,
                               country: "IN",
                               iconColor: ConstantColor.filedContainerColor,
                                onSelected: (Place place) async {
                                  try {
                                    List<Location> locations = await locationFromAddress(place.description);
                                    if (locations.isNotEmpty) {
                                      latitude = locations.first.latitude;
                                      longitude = locations.first.longitude;
                                    } else {}
                                  } catch (e) {}
                                  setState(() {
                                    _address = place.description;
                                  });
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                                      MyHomePageDemo1(
                                          mobilenumber: '',
                                          lat: latitude.toString(),
                                          id: "0",
                                          longitude: longitude.toString(),
                                          lName: locationName.isNotEmpty
                                              ? getLocationPart(locationName, 2)
                                              : "",
                                      ),
                                 ));
                              },),
                        /*------------------------------search box filed end----------------------------------------*/
                        /*--------------------------------Icon-Text_button start------------------------------------*/
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: screenHeight/80,),
                                child: iconTextButton(
                                  backgroundColor: ConstantColor.primaryMainColor,
                                  icon: Icons.my_location,
                                  iconColor: ConstantColor.primaryBackgroundMainColor,
                                  iconSize: 20.0,
                                  buttonOnPressed: () {
                                    getLocation();
                                  },
                                  buttontext: "Use current location",
                                  buttontextStyle: ConstantTextStyle.newiconButtonText,
                                  fixedSize: Size(screenWidth, 0),
                                ),
                              ),
                        /*--------------------------------Icon-Text_button end------------------------------------*/
                        /*--------------------------------Linear RichText and Slider start------------------------------------*/
                              Container(
                                decoration: BoxDecoration(
                                  color: ConstantColor.secondoryMarketColors,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: screenWidth / 40,),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: customRichText(
                                      text1: "Search within",
                                      TextAlign: TextAlign.start,
                                      style1: ConstantTextStyle
                                          .colorsHeadingText,
                                      text2: ' ${_sliderValue.round()} ',
                                      style2: ConstantTextStyle
                                          .otpResendButtonText,
                                      text3: "KM",
                                      style3: ConstantTextStyle
                                          .colorsHeadingText,
                                    ),
                                    title: linearSlider(
                                      sizeBoxwidth: screenWidth / 2.4,
                                      thumbColor: ConstantColor.primaryBackgroundMainColor,
                                      activeTrackColor:
                                      ConstantColor.primaryMainColor,
                                      trackHeight: 3.0,
                                      enabledThumbRadius: 8.0,
                                      widget: StatefulBuilder(
                                        builder: (context, state) {
                                          return Slider(
                                            divisions: 10,
                                            value: _sliderValue,
                                            min: 0.0,
                                            max: 10.0,
                                            onChanged: (value) {
                                              setState(() {
                                                _sliderValue = value;
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        /*--------------------------------Linear RichText and Slider end------------------------------------*/
                              SizedBox(height: screenHeight / 40,),
                        /*---------------------------------------------------------------------------------------------*/
                              customeText(
                                text: "Most Searched Locations",
                                style: ConstantTextStyle.storeDetailsText3,),
                              SizedBox(height: screenHeight / 80,),
                        /*-----------------------------Grid view icon and text start----------------------------------------------*/
                              ScrollbarTheme(
                                data: ScrollbarThemeData(
                                  interactive: true,
                                  // isAlwaysShown: true,
                                  thumbColor: MaterialStateProperty.all<Color>(ConstantColor.filedContainerColor),
                                  trackColor: MaterialStateProperty.all<Color>(ConstantColor.carColor),
                                ),
                                child:isLoadingScreen? const Center(
                                  child: SpinKitCircle(
                                    color: ConstantColor.primaryMainColor,
                                    size: 30.0,
                                  ),
                                )
                                    : SizedBox(
                                    width: double.maxFinite,
                                    height: screenHeight /4.8,
                                    child:locationData!=null?  GridView.builder(
                                      // controller: _scrollController,
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:locationData!.length,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        childAspectRatio: 1 / 1.1,
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 5.0,
                                      ),
                                      itemBuilder: (BuildContext context, int index) {
                                      String  lat=locationData![index].locationLat.toString();
                                      String longitude=locationData![index].locationLong.toString();
                                          return buildGridView(
                                            context: context,
                                            gridOnTap:   () {
                                          try {
                                           setState(() {
                                             lName=locationData![index].locationText.toString();
                                           });
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                                                MyHomePageDemo1(
                                                    mobilenumber: '',
                                                    lat:lat,
                                                    longitude:longitude,
                                                    id:locationData![index].id.toString(),
                                                    lName:locationData![index].locationText.toString()
                                                ),
                                            //     BottomNavigationBarScreen(
                                            //         mobilenumber: '',
                                            //         lat:lat,
                                            //         longitude:longitude,
                                            //         id:locationData![index].id.toString(),
                                            //         lName:locationData![index].locationText.toString()
                                            // )
                                            ));
                                        } catch (e) {}
                                      },

                                          icon: Icons.location_on_outlined,
                                          iconSize: 20.0,
                                          iconColor: ConstantColor.primaryMainColor,
                                          textWidget: customeText(
                                            text: locationData![index].locationText,
                                            overflow: TextOverflow.ellipsis,
                                            style: ConstantTextStyle.locationText,
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      },
                                    ):const Text("No Data Found!"),
                                  ),
                                )

                        /*-----------------------------Grid view icon and text end----------------------------------------------*/
                            ],
                          ),
                        ),
                      ),
                    );
  }
}

class CustomSearchLocation extends StatelessWidget {
  final String placeholder;
  final double radius;
  final String apiKey;
  final String country;
  final Color iconColor;
  final Function(Place) onSelected;

   const CustomSearchLocation({super.key,
    required this.placeholder,
    required this.radius,
    required this.apiKey,
    required this.country,
    required this.iconColor,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        border: Border(
          left: BorderSide(
            color: Color(0xffee5816),
            width: 3.5,
          ),
        ),
      ),
      child:
      SearchLocation(
        placeholder: placeholder,
        radius: 0,
        apiKey: apiKey,
        country: country,
        iconColor: iconColor,
        onSelected: onSelected,
        darkMode: false,
      ),
    );
  }
}



