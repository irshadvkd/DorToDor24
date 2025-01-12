// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:dortodorpartner/Controllers/Product/product_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dortodorpartner/Helper/colors.dart';
import 'package:dortodorpartner/Helper/session.dart';
import 'package:dortodorpartner/Helper/string.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // If you're going to use other Firebase services in the background, such as Fire store,
  // make sure you call `initializeApp` before using other Firebase services.
  debugPrint('Handling a background message ${message.messageId}');
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool splashNetwork = true;
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) async {
    // final moreController = Get.put(MoreController());

    debugPrint(message.data.toString());
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("user_role") == '3') {
      debugPrint('api called on splash page');
      // await homeController.loginUser(
      //   context,
      //   message.data['notificationtype'] == "11"
      //       ? "1"
      //       : message.data['notificationtype'] == "12"
      //       ? "2"
      //       : "",
      // );
    } else {
      if (message.data['notificationtype'] == "1") {
        // homeWorkController.getHomeWork(context);
        // Get.to(() => HomeWorkPage(title: message.data['pagetitle']));
      } else {
        // homeController.getNotification(context);
        // Get.to(() => const NotificationPage());
      }
    }
  }

  @override
  void initState() {
    super.initState();

    // Run code required to handle interacted messages in an async function
    // as initState() must not be async
    // setupInteractedMessage();
    checkForUpdate();
    startTime();
  }

  checkForUpdate() async {
    if (Platform.isAndroid) {
      InAppUpdate.checkForUpdate().then((info) {
        setState(() {
          debugPrint('info $info');
          if (info.immediateUpdateAllowed) {
            InAppUpdate.performImmediateUpdate().catchError((e) {
              showSnackBar(context, e.toString());
              return AppUpdateResult.inAppUpdateFailed;
            });
          }
        });
      }).catchError((e) {
        showSnackBar(context, e.toString());
      });
    }
  }

  void showSnack(String text) {
    // toastMsg(context, text);
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: SizedBox(
              width: 200,
              child: Image.asset(
                'assets/icons/logo.png',
              ),
            ),
          ),
          // Positioned(
          //   bottom: 30,
          //   child: Column(
          //     children: [
          //       Text(
          //         'Powered by',
          //         style: Theme.of(context).textTheme.headlineSmall,
          //       ),
          //       Text(
          //         'EDECX',
          //         style: Theme.of(context).textTheme.headlineMedium,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, navigationPage);
  }

  Future<void> navigationPage() async {
    final homeController = Get.put(HomeController());
    Get.put(ProductController());
    bool isLogin = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLogin') != null) {
      isLogin = prefs.getBool('isLogin')!;
    }
    debugPrint("Whether device already login or not : $isLogin");
    if (isLogin == true) {
      homeController.getDashboard(context);
      Get.offAndToNamed('/home');
    } else {
      // homeController.getHome(context);
      // Get.offAndToNamed('/home');
      Get.offAndToNamed('/login');
    }
  }
}
