import 'package:flutter/material.dart';

 class ContextUtility {
   static final GlobalKey<NavigatorState> _navigatorkey = GlobalKey<NavigatorState>();
   static GlobalKey<NavigatorState> get navigatorKey=> _navigatorkey;
   static NavigatorState? get navigator => navigatorKey.currentState;
   static BuildContext? get context => navigator?.overlay?.context;
 }