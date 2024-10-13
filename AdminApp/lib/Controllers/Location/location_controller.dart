import 'dart:convert';

import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:dortodorpartner/Helper/session.dart';
import 'package:dortodorpartner/Modals/Location/block_modal.dart';
import 'package:dortodorpartner/Modals/Location/city_modal.dart';
import 'package:dortodorpartner/Modals/Location/governorate_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  TextEditingController search = TextEditingController();
  TextEditingController nameEng = TextEditingController();
  TextEditingController nameAr = TextEditingController();

  bool buttonLoader = true;
  bool governorateLoader = true;
  bool cityLoader = true;
  bool blockLoader = true;

  List tempGovernorate = [];
  List governorate = [];
  List tempCity = [];
  List city = [];
  List tempBlock = [];
  List block = [];

  Future getGovernorate(context) async {
    governorateLoader = false;
    update();
    var response = await getAPI(context, "governorate/get");
    if (response['status'] == true) {
      tempGovernorate = governorateModalFromJson(response['data']);
      addGovernorateToList();
    }
    governorateLoader = true;
    update();
  }

  Future addGovernorate(context) async {
    buttonLoader = false;
    update();
    var data = jsonEncode({
      "nameEng": nameEng.text,
      "nameAr": nameAr.text,
    });
    var response = await postAPI(
      context,
      "governorate/add",
      data,
    );
    if (response['status'] == true) {
      tempGovernorate = governorateModalFromJson(response['data']);
      Get.back();
      addGovernorateToList();
    }
    buttonLoader = true;
    update();
  }

  Future updateGovernorate(context, governorateId) async {
    buttonLoader = false;
    update();
    var data = jsonEncode({
      "id": governorateId.toString(),
      "nameEng": nameEng.text,
      "nameAr": nameAr.text,
    });
    var response = await postAPI(
      context,
      "governorate/update",
      data,
    );
    if (response['status'] == true) {
      tempGovernorate = governorateModalFromJson(response['data']);
      Get.back();
      addGovernorateToList();
    }
    buttonLoader = true;
    update();
  }

  Future deleteGovernorate(context, governorateId) async {
    final homeController = Get.put(HomeController());
    homeController.buttonLoader = false;
    homeController.update();
    var data = jsonEncode({"id": governorateId.toString()});
    var response = await postAPI(context, "governorate/delete", data);
    if (response['status'] == true) {
      tempGovernorate = governorateModalFromJson(response['data']);
      Get.back();
      addGovernorateToList();
    }
    homeController.buttonLoader = true;
    homeController.update();
    update();
  }

  addGovernorateToList() {
    governorate.clear();
    for (int i = 0; i < tempGovernorate.length; i++) {
      var currentIndex = tempGovernorate[i];
      if (currentIndex.nameEng
              .toString()
              .toLowerCase()
              .contains(search.text.toLowerCase()) ||
          currentIndex.nameAr
              .toString()
              .toLowerCase()
              .contains(search.text.toLowerCase())) {
        governorate.add({
          "id": currentIndex.id,
          "nameEng": currentIndex.nameEng,
          "nameAr": currentIndex.nameAr,
        });
      }
    }
    update();
  }

  Future getCity(context, governorateId) async {
    cityLoader = false;
    update();
    var response = await getAPI(context, "city/get?govId=$governorateId");
    if (response['status'] == true) {
      tempCity = cityModalFromJson(response['data']);
      addCityToList();
    }
    cityLoader = true;
    update();
  }

  Future addCity(context, governorateId) async {
    buttonLoader = false;
    update();
    var data = jsonEncode({
      "nameEng": nameEng.text,
      "nameAr": nameAr.text,
      "govId": governorateId,
    });
    var response = await postAPI(
      context,
      "city/add",
      data,
    );
    if (response['status'] == true) {
      tempCity = cityModalFromJson(response['data']);
      Get.back();
      addCityToList();
    }
    buttonLoader = true;
    update();
  }

  Future updateCity(context, governorateId, cityId) async {
    buttonLoader = false;
    update();
    var data = jsonEncode({
      "id": cityId.toString(),
      "govId": governorateId.toString(),
      "nameEng": nameEng.text,
      "nameAr": nameAr.text,
    });
    var response = await postAPI(
      context,
      "city/update",
      data,
    );
    if (response['status'] == true) {
      tempCity = cityModalFromJson(response['data']);
      Get.back();
      addCityToList();
    }
    buttonLoader = true;
    update();
  }

  Future deleteCity(context, governorateId, cityId) async {
    final homeController = Get.put(HomeController());
    homeController.buttonLoader = false;
    homeController.update();
    var data = jsonEncode({
      "id": cityId.toString(),
      "govId": governorateId.toString(),
    });
    var response = await postAPI(context, "city/delete", data);
    if (response['status'] == true) {
      tempCity = cityModalFromJson(response['data']);
      Get.back();
      addCityToList();
    }
    homeController.buttonLoader = true;
    homeController.update();
    update();
  }

  addCityToList() {
    city.clear();
    for (int i = 0; i < tempCity.length; i++) {
      var currentIndex = tempCity[i];
      if (currentIndex.nameEng
              .toString()
              .toLowerCase()
              .contains(search.text.toLowerCase()) ||
          currentIndex.nameAr
              .toString()
              .toLowerCase()
              .contains(search.text.toLowerCase())) {
        city.add({
          "id": currentIndex.id,
          "nameEng": currentIndex.nameEng,
          "nameAr": currentIndex.nameAr,
        });
      }
    }
    update();
  }

  Future getBlock(context, governorateId, cityId) async {
    blockLoader = false;
    update();
    var response =
        await getAPI(context, "block/get?govId=$governorateId&cityId=$cityId");
    if (response['status'] == true) {
      tempBlock = blockModalFromJson(response['data']);
      addBlockToList();
    }
    blockLoader = true;
    update();
  }

  Future addBlock(context, governorateId, cityId) async {
    buttonLoader = false;
    update();
    var data = jsonEncode({
      "nameEng": nameEng.text,
      "nameAr": nameAr.text,
      "govId": governorateId,
      "cityId": cityId,
    });
    var response = await postAPI(
      context,
      "block/add",
      data,
    );
    if (response['status'] == true) {
      tempBlock = blockModalFromJson(response['data']);
      Get.back();
      addBlockToList();
    }
    buttonLoader = true;
    update();
  }

  Future updateBlock(context, governorateId, cityId, blockId) async {
    buttonLoader = false;
    update();
    var data = jsonEncode({
      "id": blockId.toString(),
      "cityId": cityId.toString(),
      "govId": governorateId.toString(),
      "nameEng": nameEng.text,
      "nameAr": nameAr.text,
    });
    var response = await postAPI(
      context,
      "block/update",
      data,
    );
    if (response['status'] == true) {
      tempBlock = blockModalFromJson(response['data']);
      Get.back();
      addBlockToList();
    }
    buttonLoader = true;
    update();
  }

  Future deleteBlock(context, governorateId, cityId, blockId) async {
    final homeController = Get.put(HomeController());
    homeController.buttonLoader = false;
    homeController.update();
    var data = jsonEncode({
      "id": blockId.toString(),
      "cityId": cityId.toString(),
      "govId": governorateId.toString(),
    });
    var response = await postAPI(context, "block/delete", data);
    if (response['status'] == true) {
      tempBlock = blockModalFromJson(response['data']);
      Get.back();
      addBlockToList();
    }
    homeController.buttonLoader = true;
    homeController.update();
    update();
  }

  addBlockToList() {
    block.clear();
    for (int i = 0; i < tempBlock.length; i++) {
      var currentIndex = tempBlock[i];
      if (currentIndex.nameEng
              .toString()
              .toLowerCase()
              .contains(search.text.toLowerCase()) ||
          currentIndex.nameAr
              .toString()
              .toLowerCase()
              .contains(search.text.toLowerCase())) {
        block.add({
          "id": currentIndex.id,
          "nameEng": currentIndex.nameEng,
          "nameAr": currentIndex.nameAr,
        });
      }
    }
    update();
  }

  clearFormFields() {
    nameEng.clear();
    nameAr.clear();
    buttonLoader = true;
    update();
  }

  setFormFields(currentIndex) {
    nameEng.text = currentIndex['nameEng'];
    nameAr.text = currentIndex['nameAr'].toString();
    update();
  }
}
