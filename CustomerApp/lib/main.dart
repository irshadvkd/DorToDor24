import 'dart:io';
import 'package:dorTodor24/Views/Auth/language_page.dart';
import 'package:dorTodor24/Views/Home/home_app_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Helper/language.dart';
import 'package:dorTodor24/Views/Auth/login_page.dart';
import 'package:dorTodor24/Views/Auth/splash_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> onBackgroundMessageHandler(RemoteMessage message) async {
  debugPrint('hi');
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FlutterAppBadger.isAppBadgeSupported();
  // FlutterAppBadger.updateBadgeCount(2);
  debugPrint("Background message service");
}

// final LocalNotificationService service = LocalNotificationService();

SharedPreferences? prefs;
FirebaseMessaging messaging = FirebaseMessaging.instance;
void main(context) async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  // await Firebase.initializeApp();

  // FirebaseMessaging.instance.getInitialMessage();
  // service.initialize();
  // listenToNotification();
  prefs = await SharedPreferences.getInstance();

  // await messaging.requestPermission(
  //   alert: true,
  //   announcement: true,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: true,
  //   provisional: true,
  //   sound: true,
  // );
  // Get.put(AuthController());
  // Get.put(HomeController());
  // Get.put(MoreController());
  // Get.put(HomeWorkController());
  // Get.put(EventCalenderController());
  // Get.put(MailController());
  // Get.put(AnnouncementController());
  // Get.put(GalleryController());
  // Get.put(ProfileController());
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //   // RemoteNotification? notification = message.notification;
  //   // service.showNotification(
  //   //   id: notification.hashCode,
  //   //   title: notification!.title!,
  //   //   body: notification.body!,
  //   //   payload: message.data['notificationtype'],
  //   // );
  //   //This will give you the topic string from curl request (/topics/news)
  //   log("From: $message");
  //   //This will give you the Text property in the curl request(Sample Message):
  //   //put code here to navigate based on click_action
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
  //   print("onMessageOpenedApp: $message");
  //   // final moreController = Get.put(MoreController());
  //
  //   print(message.data);
  //   print(message.data['notificationtype'] == "1");
  //   final prefs = await SharedPreferences.getInstance();
  //   if (prefs.getString("user_role") == '3') {
  //     print('api called on main page');
  //     // await homeController.loginUser(
  //     //   context,
  //     //   message.data['notificationtype'] == "11"
  //     //       ? "1"
  //     //       : message.data['notificationtype'] == "12"
  //     //           ? "2"
  //     //           : "",
  //     // );
  //   } else {
  //     // await homeController.getTimeline(context);
  //
  //     var typeCode = message.data['notificationtype'] ?? "";
  //     var diaryCode = message.data['diarytypeid'] ?? "";
  //     var pageTitle = message.data['pagetitle'] ?? "";
  //     if (typeCode == "1") {
  //       // homeWorkController.getHomeWork(context);
  //       // Get.to(() => HomeWorkPage(title: pageTitle));
  //     } else {
  //       // homeController.getNotification(context);
  //       Get.to(() => const NotificationPage());
  //     }
  //   }
  // });
  // FirebaseMessaging.onBackgroundMessage(onBackgroundMessageHandler);
  runApp(const MyApp());
}
//
// listenToNotification() =>
//     service.onNotificationClick.stream.listen(onNotificationListener);
// Future onNotificationListener(String? payload) async {
//   print('payload $payload');
//   Get.to(() => const NotificationPage());
//   if (payload != null && payload.isNotEmpty) {
//     print('payload $payload');
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // listenToNotification();
    // init();
  }

  // init() async {
  //   final NotificationAppLaunchDetails? notificationAppLaunchDetails =
  //       await service.localNotificationService
  //           .getNotificationAppLaunchDetails();
  //   debugPrint('vadad  $notificationAppLaunchDetails');
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      debugShowCheckedModeBanner: false,
      translations: Language(),
      locale: prefs!.getBool('isArabic') == true
          ? const Locale('ar', 'AE')
          : const Locale('en', 'US'),
      theme: ThemeData(
        canvasColor: colors.lightWhite,
        cardColor: colors.white,
        dialogBackgroundColor: colors.white,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: colors.primary),
        primarySwatch: colors.primaryApp,
        primaryColor: colors.lightWhite,
        brightness: Brightness.light,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: colors.black,
          selectionColor: colors.lightWhite,
          selectionHandleColor: colors.black,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 19,
            color: colors.textMain,
            fontFamily:
            prefs!.getBool('isArabic') == true ? 'Almarai' : 'Amiko',
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 19,
            color: colors.textMain,
            fontFamily:
            prefs!.getBool('isArabic') == true ? 'Almarai' : 'Amiko',
          ),
          titleSmall: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 17,
            color: colors.textMain,
            fontFamily:
            prefs!.getBool('isArabic') == true ? 'Almarai' : 'Amiko',
          ),
          headlineLarge: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: colors.textMain,
            fontFamily:
            prefs!.getBool('isArabic') == true ? 'Almarai' : 'Amiko',
          ),
          headlineMedium: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: colors.textMain,
            fontFamily:
            prefs!.getBool('isArabic') == true ? 'Almarai' : 'Amiko',
          ),
          headlineSmall: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: colors.textMain,
            fontFamily:
            prefs!.getBool('isArabic') == true ? 'Almarai' : 'Amiko',
          ),
          labelLarge: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: colors.textMain,
            fontFamily:
            prefs!.getBool('isArabic') == true ? 'Almarai' : 'Amiko',
          ),
          labelMedium: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 11,
            color: colors.textMain,
            fontFamily:
            prefs!.getBool('isArabic') == true ? 'Almarai' : 'Amiko',
          ),
          labelSmall: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 9,
            color: colors.textMain,
            fontFamily:
            prefs!.getBool('isArabic') == true ? 'Almarai' : 'Amiko',
          ),
        ),
      ),
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => LoginPage(),
        '/home': (context) => const HomeAppBar(),
        // '/place': (context) => PlaceSelectPage(),
        '/language': (context) => const LanguagePage(),
        // '/morePage': (context) => MorePage(),
      },
    );
  }
}
