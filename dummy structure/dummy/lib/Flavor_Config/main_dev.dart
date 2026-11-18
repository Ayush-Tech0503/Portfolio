import 'package:flutter/cupertino.dart';
import '../main_common.dart';
import 'flavor_config.dart';

void main () async{
 WidgetsFlutterBinding.ensureInitialized();
 AppEnvironment.setUpEnv(Environment.dev);
 mainCommon();
}

