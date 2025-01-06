import 'dart:convert';

import 'package:dortodorpartner/Helper/session.dart';
import 'package:dortodorpartner/Modals/Home/dashboard_modal.dart';
import 'package:dortodorpartner/Modals/Home/login_modal.dart';
import 'package:dortodorpartner/Views/Home/home_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  int currentPage = 0;
  bool isAdmin = false;

  bool buttonLoader = true;
  bool homeLoader = true;

  List notifications = [];

  XFile? imageFile;

  Future loginUser(context, isAdmin) async {
    buttonLoader = false;
    update();
    var data = jsonEncode({
      "username": userName.text,
      "password": password.text,
    });
    var response = await postAPI(context, "auth/login", data);

    print(response);

    if (response['status'] == true) {
      LoginModal loginModal = LoginModal.fromJson(jsonDecode(response['data']));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLogin', true);
      prefs.setString('userId', loginModal.user!.id.toString());
      prefs.setString('privilege', loginModal.user!.previlage.toString());
      final homeController = Get.put(HomeController());
      homeController.getDashboard(context);
      Get.to(() => const HomeAppBar());
      // tempStore = storeModalFromJson(response['data']);
      // Get.back();
      // addStoreToList();
    }
    buttonLoader = true;
    update();
  }

  DashboardModal? dashboardModal;
  Future getDashboard(context) async {
    homeLoader = false;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAdmin = prefs.getString("privilege") == "1" ? true : false;
    var storeId = prefs.getString("userId");
    var data = jsonEncode({"storeId": storeId});
    print(isAdmin);
    var response = await postAPI(
        context, "dashboard/${isAdmin ? "admin" : "store"}", data);
    if (response['status'] == true) {
      dashboardModal = DashboardModal.fromJson(jsonDecode(response['data']));
    }
    homeLoader = true;
    update();
  }

  Future changeLanguage(context, languageCode) async {
    update();
  }
}
