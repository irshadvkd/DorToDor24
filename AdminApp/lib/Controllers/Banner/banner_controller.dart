import 'dart:convert';

import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:dortodorpartner/Helper/session.dart';
import 'package:dortodorpartner/Helper/string.dart';
import 'package:dortodorpartner/Modals/Banner/banner_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  TextEditingController search = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController imageName = TextEditingController();

  bool buttonLoader = true;
  bool bannerLoader = true;
  List tempBanner = [];
  List banner = [];

  String selectedType = "";

  Future getBanner(context) async {
    bannerLoader = false;
    update();
    var response = await getAPI(context, "banner/get");
    if (response['status'] == true) {
      tempBanner = bannerModalFromJson(response['data']);
      addBannerToList();
    }
    bannerLoader = true;
    update();
  }

  Future addBanner(context) async {
    buttonLoader = false;
    update();
    List data = [
      {"name": "name", "value": name.text},
      {"name": "type", "value": selectedType}
    ];
    final homeController = Get.put(HomeController());
    var response = await multipartPostAPI(
      context,
      "banner/add",
      data,
      homeController.imageFile,
    );
    if (response['status'] == true) {
      tempBanner = bannerModalFromJson(response['data']);
      Get.back();
      addBannerToList();
    }
    buttonLoader = true;
    update();
  }

  Future updateBanner(context, bannerId) async {
    buttonLoader = false;
    update();
    List data = [
      {"name": "id", "value": bannerId.toString()},
      {"name": "name", "value": name.text},
      {"name": "type", "value": selectedType}
    ];
    final homeController = Get.put(HomeController());
    var response = await multipartPostAPI(
      context,
      "banner/update",
      data,
      homeController.imageFile,
    );
    if (response['status'] == true) {
      tempBanner = bannerModalFromJson(response['data']);
      Get.back();
      addBannerToList();
    }
    buttonLoader = true;
    update();
  }

  Future deleteBanner(context, bannerId) async {
    final homeController = Get.put(HomeController());
    homeController.buttonLoader = false;
    homeController.update();
    var data = jsonEncode({"id": bannerId.toString()});
    var response = await postAPI(context, "banner/delete", data);
    if (response['status'] == true) {
      tempBanner = bannerModalFromJson(response['data']);
      Get.back();
      addBannerToList();
    }
    homeController.buttonLoader = true;
    homeController.update();
    update();
  }

  addBannerToList() {
    banner.clear();
    for (int i = 0; i < tempBanner.length; i++) {
      var currentIndex = tempBanner[i];
      if (currentIndex.name
          .toString()
          .toLowerCase()
          .contains(search.text.toLowerCase())) {
        banner.add({
          "id": currentIndex.id,
          "name": currentIndex.name,
          "type": currentIndex.type,
          "image": "$imgUrl${currentIndex.image}",
        });
      }
    }
    update();
  }

  clearFormFields() {
    final homeController = Get.put(HomeController());
    homeController.imageFile = null;
    homeController.update();
    name.clear();
    selectedType = "";
    imageName.clear();
    buttonLoader = true;
    update();
  }

  setFormFields(currentIndex) {
    var temp = "";
    if (currentIndex["image"] != "") {
      temp = currentIndex['image'].toString().split("/").last;
    }
    imageName.text = temp;
    name.text = currentIndex['name'];
    selectedType = currentIndex['type'].toString();
    update();
  }
}
