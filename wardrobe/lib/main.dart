import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wardrobe/design_tokens/global.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/notification/model/command.dart';
import 'package:wardrobe/modules/api/notification/service/command.dart';
import 'package:wardrobe/modules/sqlite/init.dart';
import 'package:wardrobe/organisms/o_bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wardrobe/screens/landing/index.dart';

bool shouldUseFirestoreEmulator = false;

Future<void> fireFCMHandler(RemoteMessage message) async {
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(fireFCMHandler);
  await FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  //FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  WidgetsFlutterBinding.ensureInitialized();
  final DatabaseHelper dbHelper = DatabaseHelper();

  await dbHelper.database;

  bool isLogin = false;
  final prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('auth_key')) {
    isLogin = true;
  }

  runApp(MyApp(isLogin: isLogin));
}

class MyApp extends StatefulWidget {
  MyApp({super.key, required this.isLogin});
  bool isLogin;

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late NotificationCommandsService notificationCommandsService;

  @override
  void initState() {
    super.initState();
    notificationCommandsService = NotificationCommandsService();

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    FlutterLocalNotificationsPlugin().initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        FlutterLocalNotificationsPlugin().show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: primaryColor,
                enableLights: true,
                icon: "@mipmap/ic_launcher",
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(notification.title ?? ""),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(notification.body ?? "")],
                ),
              ),
            );
          },
        );
      }
    });

    getToken();
  }

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();

    // print(token);
    FCMModel data = FCMModel(firebaseFcm: "$token");
    try {
      var response = await notificationCommandsService.updateFcm(data);
      if (response[0]['status'] == false) {
        Get.snackbar('error', response[0]['message']);
      }
    } catch (e) {
      Get.snackbar('error', 'Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    //Lock device on portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wardrobe',
      home: widget.isLogin ? const OrganismsBottomBar() : const LoginPage(),
    );
  }
}
