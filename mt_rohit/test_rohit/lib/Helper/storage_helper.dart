import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/print_value.dart';
import '../main.dart';
import '../routes/routes_name.dart';

class StorageHelper {
  StorageHelper._();
  static final StorageHelper storageHelper = StorageHelper._();

  factory StorageHelper (){
    return storageHelper;
  }

  late SharedPreferences _pref;

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  Future<void> clear({String? routeName}) async{
    try{
      // if(StorageHelper().getUserLogInType() == 'google'){
      //   await GoogleSignIn().signOut();
      // }else if (StorageHelper().getUserLogInType() == 'apple'){
      //   await FirebaseAuth.instance.signOut();
      // }
    }catch (e){
      printValue(tag: 'Error while signout && clear data: ',e.toString());
    }
    _pref.clear();
    Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, routeName??RouteName.logIn, (route) => false);
    debugPrint("LOGOUT ISSUE: clearing local pref");
  }


  void setIsFirstLaunch(){_pref.setBool("dealshaq_app_launching_first_time", false);}
  bool getIsFirstLaunch(){return _pref.getBool('dealshaq_app_launching_first_time')??true;}

  void setDefaultLocation(String defaultLocation){_pref.setString("user_default_location", defaultLocation);}
  String getDefaultLocation(){return _pref.getString('user_default_location')??'';}

  void setDefaultLocationId(String defaultLocationId){_pref.setString("user_default_location_id", defaultLocationId);}
  String getDefaultLocationId(){return _pref.getString('user_default_location_id')??'';}

  void setDefaultLocationZipCode(String zipcode){_pref.setString("user_default_location_zipcode", zipcode);}
  String getDefaultLocationZipCode(){return _pref.getString('user_default_location_zipcode')??'';}

  void setUserName(String userName) {_pref.setString('dealshaq_user_name', userName);}
  String getUserName() {return _pref.getString('dealshaq_user_name')??"";}

  void setUserBearerToken(String token) {_pref.setString('dealshaq_user_token', token);}
  String getUserBearerToken()  {return _pref.getString('dealshaq_user_token')??"";}

  void setUserId(String userId) {_pref.setString('dealshaq_user_id', userId);}
  String getUserId()  {return _pref.getString('dealshaq_user_id')??"";}

  void setUserEmail(String email) {_pref.setString('dealshaq_user_email', email);}
  String getUserEmail() {return _pref.getString('dealshaq_user_email')??"";}

  void setUserMobileNumber(String mobileNumber) {_pref.setString('dealshaq_user_mobile_number', mobileNumber);}
  String getUserMobileNumber() {return _pref.getString('dealshaq_user_mobile_number')??"";}

  void setUserCountryCode(String countryCode)  {_pref.setString('dealshaq_user_country_code', "($countryCode)");}
  String getUserCountryCode() {return _pref.getString('dealshaq_user_country_code')??"";}

  void setUserLogInType(String type) {_pref.setString('dealshaq_user_login_type', type);}
  String getUserLogInType() {return _pref.getString('dealshaq_user_login_type')??"";}

  void setCharityId(String id) {_pref.setString('dealshaq_user_charity_id', id);}
  String getCharityId() {return _pref.getString('dealshaq_user_charity_id')??"";}

  void setCharityName(String name) {_pref.setString('dealshaq_user_charity_name', name);}
  String getCharityName() {return _pref.getString('dealshaq_user_charity_name')??"";}



  void setTutorialCoachMark() {_pref.setBool('tutorial_coach_mark', false);}
  bool getTutorialCoachMark() {return _pref.getBool('tutorial_coach_mark')??true;}



  void setAutoComplete(String autoCompleteText) {
    List<String> list = getAutoComplete();
    if(list.contains(autoCompleteText)){
      list.remove(autoCompleteText);
    }
    list.add(autoCompleteText);
    if(list.length == 21){
      list.removeAt(20);
    }
    _pref.setStringList('auto_complete', list.reversed.toList());
  }


  List<String> getAutoComplete() {return _pref.getStringList('auto_complete')??[];
  }



  // Language Pref
  Locale setLocale(String languageCode) {_pref.setString('user_language_code', languageCode);return _locale(languageCode);}
  Locale getLocale() {String languageCode = _pref.getString('user_language_code') ?? "en";return _locale(languageCode);}
  Locale _locale(String languageCode) {return languageCode.isNotEmpty ? Locale(languageCode, '') : const Locale('en', '');}



}