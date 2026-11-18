// ignore_for_file: deprecated_member_use, must_be_immutable, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'package:Citybazar_app/Layouts/Product%20View%20Screens/Top%20Categoty/all_product_list.dart';
import 'package:Citybazar_app/Widgets/custome_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Models/Recent Search Model/recent_search.dart';
import '../../Models/Search Banner Model/search_banner.dart';
import '../../Models/Search Sugesstion Model/search.dart';
import '../../Util/Const Toster/toster.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../../Util/constant_image.dart';
import '../../Widgets/landing_screen_slider.dart';
import '../../Widgets/search_bar.dart';
import '../Famous Market/Store Details/Store Details Screen/store_details.dart';
import '../Famous Market/famous_market_list.dart';
import '../Product View Screens/product_Item_Details.dart';
import '../Product View Screens/seen_more_products_list.dart';
import 'dart:async';
import '../See More Shops/get_seller.dart';
class SearchBoxScreen extends StatefulWidget {

  //id: widget.id, longitude: widget.longitude, latitude: widget.lattude,
  String id;
  String longitude;
  String latitude;
  String lName;

  // final keyword;
  SearchBoxScreen({super.key,required this.id,required this.longitude,required this.latitude,required this.lName});
  @override
  State<SearchBoxScreen> createState() => _SearchBoxScreenState();
}
class _SearchBoxScreenState extends State<SearchBoxScreen> {
  final PageController pageController = PageController(initialPage: 0);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final PageController _pageController1 = PageController(initialPage: 0);
  int _currentCarouselPage = 0;
/*---------------------------------------------------------------------------------------*/
  var userId;
  var tokenAccess;
  late int selectedIndex;
//---------------------Recent Search history Api data start---------------
  bool isLoading = false;
  RecentSearchData? recentSearchData;
  List<SearchedKey> searchedKey=[];

  // String? keyword;
  fetchRecentSearch() async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      setState(() {
        isLoading = true;
      });
      // final body = {"user_id":userId};
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.recentSearchApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        // data: json.encode(body),
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.data.toString());
        recentSearchData = RecentSearchData.fromJson(responseData);

        setState(() {
          searchedKey.addAll(recentSearchData?.searchedKey??[]);
        });
      }
      else {
        // Print the DataList after parsing
      }
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }
  //---------------------Recent Search history Api data end---------------
  //---------------------Recent Search clear Api data start---------------

  bool isLoadingSearchClear = false;
  fetchSearchClear({searchedIn}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      setState(() {
        isLoadingSearchClear = true;
      });
      final body = {
        "user_id": userId,
        "searched_in": searchedIn
      };

      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.recentSearchClearApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.data.toString());
        if (responseData['status'] == 'success'){
            searchedKey.clear();
            fetchRecentSearch();
        }
        setState(() {
          isLoadingSearchClear = false;
        });

      } else {
        isLoadingSearchClear = false;
        // Handle error response
        //  print("Error: ${response.statusCode}");
      }
    } catch (error) {
      isLoadingSearchClear = false;
      // Handle any exceptions
      // print("Error: $error");
    }
  }
//---------------------Recent Search clear Api data start---------------
//--------------------- Search Banner Api data start---------------
  bool  isLoadingBanner = false;
  SearchBannerData? searchBannerData;
  List<Data> bannerDataList=[];
  fetchBanners() async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      setState(() {
        isLoadingBanner = true;
      });
      final body = {"user_id":userId};
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.recentSearchBannerApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.data.toString());
        searchBannerData = SearchBannerData.fromJson(responseData);
        setState(() {
          bannerDataList.addAll(searchBannerData?.data??[]);
        });
      }
      else {
        // Print the DataList after parsing
      }
      setState(() {
        isLoadingBanner = false;
      });
    } catch (error) {
      setState(() {
        isLoadingBanner = false;
      });
    }
  }

//--------------------- Search Banner Api data end---------------
//--------------------- Search Api data Start------------
  bool  isLoadingSearch = false;
  SearchData? searchData;
  List<DataSearchSug> dataSearchList=[];
  String? keyword = '';
  fetchSearch({String? keyword, String? type}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");

      setState(() {
        isLoadingSearch = true;
        // Clear existing data lists before fetching new data
        dataSearchList.clear();
      });

      final body = {
        "keyword": keyword,
        "distance": 10,
        "lat": 22.6903994,
        "long":  75.8657262,
        "type": type,
      };

      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.searchDataApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.data.toString());

        searchData = SearchData.fromJson(responseData);

        setState(() {
          dataSearchList.addAll(searchData?.data ?? []);

          // Clear existing data lists before fetching new data
          // dataSearchList.clear();
        });
      } else {
        // Handle error cases if needed
      }

      setState(() {
        isLoadingSearch = false;
      });
    } catch (error) {
      setState(() {
        isLoadingSearch = false;
      });
    }
  }

  void switchType(String newType) {
    setState(() {
      type = newType;
      // Clear search field and results
      _textEditingController.clear();
      keyword = '';
      dataSearchList.clear();
      searchData = null;
    });
  }
  //********************************************************
  launchWhatsApp(String? phoneNumber, String message) async {
    if ( phoneNumber != null && message == "null" && message !="I found you on CItyBazaarOnline" ) {
      final url = 'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch WhatsApp $url';
      }
    } else {
    }
  }
  //********************************************************
  @override
  void initState() {
    super.initState();
    fetchRecentSearch();
    fetchBanners();
    // fetchSearch();
  }
  var type="products";
  Color productsButtonColor = ConstantColor.primaryMainColor;
  Color shopsButtonColor = ConstantColor.primaryGreyColor;
   Timer? _debounceTimer;
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: ConstantColor.loginWithOtpButtonColor,
      child: SafeArea(
          child:Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: ConstantColor.loginWithOtpButtonColor,
              ),
              backgroundColor: ConstantColor.primaryBackgroundMainColor,
              bottomOpacity: 0.0,
              titleSpacing: 0.0,
              elevation: 1.0,
              title: Text(
                'I\'m looking for',
                style: ConstantTextStyle.allHomeScreenAvatarText,
                textAlign: TextAlign.start,
              ),
              actions: [

                GestureDetector(
                  onTap: (){switchType("products");
                  productsButtonColor = ConstantColor.primaryMainColor;
                  shopsButtonColor = ConstantColor.primaryGreyColor;},
                  child: Chip(
                    onDeleted: type == "products" ? () {} : null,
                    deleteIcon: const Icon(Icons.check_circle_outline_rounded, size: 20,),
                    deleteIconColor: ConstantColor.primaryBackgroundMainColor,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
                    ),
                    backgroundColor: productsButtonColor,
                    label: const Text('products'),
                    labelStyle:  ConstantTextStyle.reviewsRatingsText,
                  ),
                ),
                SizedBox(width: screenWidth/60,),
                GestureDetector(
                  onTap: (){switchType("shops");
                  shopsButtonColor = ConstantColor.primaryMainColor;
                  productsButtonColor = ConstantColor.primaryGreyColor;},
                  child: Chip(
                    onDeleted: type == "shops" ? () {} : null,
                    deleteIcon: const Icon(Icons.check_circle_outline_rounded,size: 20,),
                    deleteIconColor: ConstantColor.primaryBackgroundMainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
                    ),
                    backgroundColor: shopsButtonColor,
                    label: const Text('Shops'),
                    labelStyle:  ConstantTextStyle.reviewsRatingsText,
                  ),
                ),
                SizedBox(width: screenWidth/40,),
              ],
            ),
            body:  Container(
              color: ConstantColor.primaryBackgroundMainColor,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: screenWidth/40),
                children: [
                  SizedBox(height: screenHeight/80,),
/*------------------(TextFormField)----------SearchBox start-------------------*/
                  searchbarBox(
                    textInputAction: TextInputAction.go,
                    onSubmmitted: (value) {
                      if (value.isEmpty) {
                        LoadingScaffoldMessage.showSnackbar(
                          context, "Please type something to search!",
                          ConstantColor.primaryMainColor,
                          const Duration(seconds: 1),
                        );
                      } else {
                        switch (type) {
                          case "products":
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllProductListScreen(
                                  keyword: keyword,
                                  filterKeyword: keyword,
                                  suitableFor: const [],
                                  id: widget.id, longitude: widget.longitude, latitude: widget.latitude,lName: widget.lName,
                                ),
                              ),
                            );
                            break;
                          case "shops":
                            Navigator.push( context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    GetSellerScreen(
                                      keyword: keyword,
                                      id: widget.id,
                                      lattude: widget.latitude,
                                      longitude: widget.longitude,
                                      lName: widget.lName,
                                    ),
                              ),
                            );
                            // if (dataSearchList.isNotEmpty
                            //     && dataSearchList[0].value.toString() == _textEditingController.text)
                            // {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => StoreDetailScreen(
                            //         id: widget.id, longitude: widget.longitude, latitude: widget.latitude,lName: widget.lName,
                            //         sellersId: dataSearchList[0].id.toString(),
                            //       ),
                            //     ),
                            //   );
                            // }
                            // else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //       content: Text("No shops found..."),
                            //     ),
                            //   );
                            // }
                            break;
                          default:
                            LoadingScaffoldMessage.showSnackbar(
                              context, "Please type something to search!",
                              ConstantColor.primaryMainColor,
                              const Duration(seconds: 1),
                            );
                            break;
                        }
                      }
                    },
                    context: context,
                    controller: _textEditingController,
                    onPressed: () {
                      _textEditingController.clear();
                      dataSearchList.clear();
                      searchData = null;
                    },
                    onEditingComlete: () {
                      if (_textEditingController.text.isEmpty) {
                        dataSearchList.clear();
                        searchData = null;
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        keyword = value;
                        dataSearchList = _filterSuggestions(value);
                        if (_debounceTimer != null && _debounceTimer!.isActive) {
                          _debounceTimer?.cancel();
                        }
                        _debounceTimer = Timer(const Duration(milliseconds: 300), () {
                          if (value.isNotEmpty) {
                            fetchSearch(keyword: keyword, type: type);
                          } else {
                            // Clear the data and stop/cancel the API request
                            dataSearchList.clear();
                            searchData = null;
                          }
                        });
                      });
                    },
                    // hintText: "Search Products & Shops",
                    icon: const Icon(
                      Icons.search_rounded,
                      color: ConstantColor.primaryMainColor,
                    ),
                    iconOnPressed: () {
                      if (_textEditingController.text.isEmpty) {
                        LoadingScaffoldMessage.showSnackbar(
                          context, "Please type something to search!",
                          ConstantColor.primaryMainColor,
                          const Duration(seconds: 1),
                        );
                      } else {
                        switch (type) {
                          case "products":
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllProductListScreen(
                                  filterKeyword: keyword,
                                  suitableFor: const [],
                                  id: widget.id, longitude: widget.longitude, latitude: widget.latitude,lName: widget.lName,
                                  keyword: keyword,
                                ),
                              ),
                            );
                            break;
                          case "shops":
                            Navigator.push( context,
                              MaterialPageRoute(
                                builder: (context) => GetSellerScreen(keyword: keyword??"", id: widget.id, lattude: widget.latitude, longitude: widget.longitude, lName: widget.lName,),),
                            );
                            // if (dataSearchList.isNotEmpty
                            //     && dataSearchList[0].value == _textEditingController.text)
                            // {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => StoreDetailScreen(
                            //         id: widget.id, longitude: widget.longitude, latitude: widget.latitude,lName: widget.lName,
                            //         sellersId: dataSearchList[0].id.toString(),
                            //       ),
                            //     ),
                            //   );
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //       content: Text("No shops found..."),
                            //     ),
                            //   );
                            // }
                            break;
                          default:
                            LoadingScaffoldMessage.showSnackbar(
                              context, "Please type something to search!",
                              ConstantColor.primaryMainColor,
                              const Duration(seconds: 1),
                            );
                            break;
                        }
                      }
                    },
                  ),
/*------------------(TextFormField)-------SearchBox end-------------------*/
/*----------------------this is suggestion widget start----------------------------------*/
                  if (dataSearchList.isNotEmpty)
                    Visibility(
                      visible: _textEditingController.text.isNotEmpty,
                      child: SizedBox(
                        height: screenHeight/5,
                        child: ListView.builder(
                          itemCount: dataSearchList.length,
                          itemBuilder: (context, index) {
                            final suggestion = dataSearchList[index];
                            return ListTile(
                              // dense: true,
                              visualDensity: const VisualDensity(horizontal: 0,vertical: -4),
                              title: GestureDetector(
                                  child: Text(suggestion.value)),
                              onTap: () {
                                if (_textEditingController.text.isEmpty) {
                                  LoadingScaffoldMessage.showSnackbar(
                                    context, "Please type something to search!",
                                    ConstantColor.primaryMainColor,
                                    const Duration(seconds: 1),
                                  );
                                } else {
                                  switch (type) {
                                    case "products":
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AllProductListScreen(
                                            filterKeyword: keyword,
                                            suitableFor: const [],
                                            id: widget.id, longitude: widget.longitude, latitude: widget.latitude,lName: widget.lName,
                                            keyword: keyword,
                                          ),
                                        ),
                                      );
                                      break;
                                    case "shops":
                                      Navigator.push( context,
                                        MaterialPageRoute(
                                          builder: (context) => GetSellerScreen(keyword: keyword??"", id: widget.id, lattude: widget.latitude, longitude: widget.longitude, lName: widget.lName),),
                                      );
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => StoreDetailScreen(
                                      //       id: widget.id, longitude: widget.longitude, latitude: widget.latitude,lName: widget.lName,
                                      //       sellersId: dataSearchList[index].id.toString(),
                                      //     ),
                                      //   ),
                                      // );
                                      break;
                                    default:
                                      LoadingScaffoldMessage.showSnackbar(
                                        context, "Please type something to search!",
                                        ConstantColor.primaryMainColor,
                                        const Duration(seconds: 1),
                                      );
                                      break;
                                  }
                                }
                                setState(() {
                                  keyword = suggestion.value;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),
/*----------------------this is suggestion widget start----------------------------------*/
                  // SizedBox(height: screenHeight/80,),
                  const Divider(color: ConstantColor.primaryGreyColor,
                    thickness: 2,),
                  SizedBox(height: screenHeight/80,),
/*-------------------------------------------------------------------------*/
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    leading: customeText(
                      text: "Recent search".toUpperCase(),
                      style: ConstantTextStyle.allHomeScreenAvatarText,
                      textAlign: TextAlign.start,
                    ),
                    title: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.history, color: ConstantColor.primaryGreyColor,),
                        SizedBox(width: 8),
                      ],
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/40,),
                              titlePadding: EdgeInsets.symmetric(horizontal: screenWidth/40, vertical: screenHeight/60),
                              actionsPadding: EdgeInsets.zero,
                              title: const Text('Confirmation!'),
                              content: customeText(text:'Are you sure you want to clear all recent searches?',
                                  style: ConstantTextStyle.becomeSellerDiscText),
                              actions:[
                                TextButton(
                                  child: customeText(text:'Cancel',style: ConstantTextStyle.hintTextStyle2,),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: customeText(text:'Clear All',style: ConstantTextStyle.hintTextStyle2,),
                                  onPressed: ()
                                  async {
                                    setState(() {
                                      switch (type) {
                                        case "products":
                                          fetchSearchClear(searchedIn: "products");
                                          //PRODUCTS
                                          break;
                                        case "shops":
                                          fetchSearchClear(searchedIn: "shops");
                                          //STORES
                                          break;
                                        default:
                                          break;
                                      }
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: customeText(
                        text: "Clear all".toUpperCase(),
                        style: ConstantTextStyle.hintTextStyle2,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  isLoadingSearchClear? Card(
                    margin: EdgeInsets.symmetric(horizontal: screenWidth/7),
                    child:  const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [ SpinKitCircle(color: ConstantColor.primaryMainColor, size: 30.0),
                         SizedBox(width: 30,),Text("Loading. . . .")
                      ],
                    ),
                  ): Container(),
/*---------------------------------------------------------------*/
                  isLoading? const SpinKitCircle(
                      color: ConstantColor.primaryMainColor, size: 30.0)
                      : searchedKey.isNotEmpty
                      ? GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                        childAspectRatio: 1/0.7,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                    ),
                    itemCount:searchedKey.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth/60),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                      //    border: Border.all(color: ConstantColor.secondtryGrayColor),
                          color:ConstantColor.primaryBackgroundMainColor,
                          boxShadow: const [
                             BoxShadow(
                              color: ConstantColor.secondtryGrayColor,
                              spreadRadius: 0,
                              blurRadius: 1,
                              offset: Offset(0, 1), // Changes the position of the shadow
                            ),
                          ],
                        ),

                        child: Center(
                          child: customeText( text:searchedKey[index].searchKeyword??"",
                              textAlign: TextAlign.center,
                              maxLine: 3,
                              overflow: TextOverflow.ellipsis,
                              style: ConstantTextStyle.becomeSellerDiscText),
                        ),
                      );
                    },
                  ): Container(),
/*-------------------------------------------------------------------------*/
                  SizedBox(height: screenHeight/80,),
                  const Divider(color: ConstantColor.primaryGreyColor,
                    thickness: 2,),
                  SizedBox(height: screenHeight/80,),
/*-------------------------------------------------------------------------*/
                  Stack(
                    children: [
                      carouselSlider(
                        bannerHeight: screenHeight /6.5,
                        autoPlay: true,
                        viewportFraction: 1.0,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentCarouselPage = index;
                          });
                        },
                        controller: _pageController1,
                        data: List.generate(bannerDataList.length, (index) {
                          final banner = bannerDataList[index];
                          return GestureDetector(
                            onTap: () {
                              switch (banner.type) {
                                case "shop_detail":
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StoreDetailScreen(
                                        sellersId: banner.keyword,
                                        id: widget.id,
                                        longitude: widget.longitude,
                                        latitude: widget.latitude,
                                        lName: widget.lName,
                                      ),
                                    ),
                                  );
                                  break;
                                case "product_details":
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetailScreen(proId:banner.keyword,
                                          id: widget.id,
                                          longitude: widget.longitude,
                                          latitude: widget.latitude,
                                          lName: widget.lName,)),
                                  );
                                  break;
                                case "product_List":
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SeeMoreProductsScreen(
                                        keyword: banner.bannerTitle,
                                        id: widget.id,
                                        longitude: widget.longitude,
                                        latitude: widget.latitude,
                                        lName: widget.lName,
                                      ),
                                    ),
                                  );
                                  break;
                                case "shop_List":
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FamousMarketListScreen(
                                        id: widget.id,
                                        latitude: widget.latitude,
                                        longitude: widget.longitude,
                                        lName: widget.lName,
                                        fmId: banner.bannerTitle,
                                      ),
                                    ),
                                  );
                                  break;
                                case "contest_details":
                                  launchWhatsApp(banner.keyword.toString(), banner.whatsapptext.toString());
                                  break;
                                default:
                                  launchWhatsApp(banner.keyword.toString(), banner.whatsapptext.toString());
                              }
                            },
                            child: Container(
                              color: ConstantColor.transparent1,
                              child:CachedNetworkImage(
                                imageUrl: banner.bannerImage ?? "",
                                width:screenWidth,
                                fit: BoxFit.fill,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.0),
                                        border: Border.all(color: ConstantColor.primaryMainColor,
                                            width: 0.5),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                      ConstantImage.imageIsNotAvailable,
                                      height:screenHeight,
                                      width:screenWidth,
                                      fit: BoxFit.fill,
                                    ),
                              ),
                            ),
                          );
                        }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: bannerDataList.map((banner) {
                          int index = bannerDataList.indexOf(banner);
                          return dotS(
                            width: _currentCarouselPage == index ? screenWidth / 50.0:screenWidth / 20.0,
                            height:  _currentCarouselPage == index ? screenHeight / 100.0 : screenHeight/200,
                            margin: EdgeInsets.only(
                              top: screenHeight / 8.0,
                            ),
                            shape: BoxShape.circle,
                            color: _currentCarouselPage == index
                                ? ConstantColor.primaryMainColor
                                : ConstantColor.primaryGreyColor,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
/*-------------------------------------------------------------------------*/
                ],
              ),
            ),
          )),
    );
  }

  List<DataSearchSug> _filterSuggestions(String query) {
    final filteredSuggestions = dataSearchList.where((suggestion) {
      final containsQuery = suggestion.value.toLowerCase().contains(query.toLowerCase());
      return containsQuery;
    }).toList();
    return filteredSuggestions;
  }
}
