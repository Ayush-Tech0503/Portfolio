import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../components/print_value.dart';

class PushNotification {

  PushNotification._();
  static final PushNotification pushNotification = PushNotification._();

  factory PushNotification (){
    return pushNotification;
  }

    FirebaseMessaging messaging = FirebaseMessaging.instance;

  void requestPermission ()async{
    NotificationSettings settings = await messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    } else {
      // open app setting if you want
    }
  }



  Future<String> getDeviceToken() async {
    try{
      String fcmToken = "not have token";
      if (Platform.isIOS) {
        String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken != null) {
          fcmToken = await FirebaseMessaging.instance.getToken()??"";
        } else {
          await Future<void>.delayed(const Duration(seconds: 1,));
          apnsToken = await FirebaseMessaging.instance.getAPNSToken();
          if (apnsToken != null) {
            fcmToken = await FirebaseMessaging.instance.getToken()??"";
          }
        }
      } else {
        fcmToken = await FirebaseMessaging.instance.getToken()??"";
      }
      return fcmToken;
    }catch (e){
      return "not have token";
    }

  }



  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'FirebaseTutorials', // id
    'FirebaseTutorials', // title
    importance: Importance.high,
    showBadge: true,
    playSound: true,
    enableVibration: true,
  );

  initLocalNotification () async{

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('notification_icon');

    var initializationSettingsIos = const DarwinInitializationSettings();

    var  initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIos);


    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) => _handleNotificationResponse(jsonDecode(response.payload!)),
    );



    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{

      // final http.Response response = await http.get(Uri.parse(message.data['image']));
      // BigPictureStyleInformation bigPictureStyleInformation =
      // BigPictureStyleInformation(
      //   hideExpandedLargeIcon: true,
      //   ByteArrayAndroidBitmap.fromBase64String(base64Encode(response.bodyBytes)),
      //   largeIcon: ByteArrayAndroidBitmap.fromBase64String(base64Encode(response.bodyBytes)),
      // );

      if (Platform.isAndroid) {
        flutterLocalNotificationsPlugin.show(
          1,
          message.notification?.title,
          message.notification?.body,
            const NotificationDetails(
            android: AndroidNotificationDetails(
              'Centavizer',
              'Centavizer',
              channelDescription: 'channel descriptiopn',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker',
              icon: 'notification_icon',
               // largeIcon: const DrawableResourceAndroidBitmap('notification_icon'),
               // styleInformation: bigPictureStyleInformation
            ),
          ),
          payload: jsonEncode(message.data),
        );
      }
      if (Platform.isIOS){
        await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
          alert: true, // Required to display a heads up notification
          badge: true,
          sound: true,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationResponse(message.data);
    });
  }


  void openFromTerminateState ()async{
    RemoteMessage?  message = await FirebaseMessaging.instance.getInitialMessage();

    if(message != null){
      _handleNotificationResponse(message.data);
    }
  }


  static void _handleNotificationResponse (Map<String, dynamic> data){
    printValue(tag: '_handleNotificationResponse: ', data);
    // handle redirection here
  }
}