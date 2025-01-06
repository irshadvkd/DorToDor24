import 'dart:convert';

import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:dortodorpartner/Helper/session.dart';
import 'package:dortodorpartner/Modals/Store/store_location_modal.dart';
import 'package:dortodorpartner/Modals/Store/store_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  TextEditingController search = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  bool buttonLoader = true;
  bool storeLoader = true;

  List tempStore = [];
  List store = [];
  List governorate = [];
  List city = [];
  List block = [];

  String selectedStatus = "";
  String selectedGovernorate = "";
  String selectedCity = "";
  String selectedBlock = "";

  Future getStore(context) async {
    storeLoader = false;
    update();
    var response = await getAPI(context, "store/get");
    if (response['status'] == true) {
      tempStore = storeModalFromJson(response['data']);
      addStoreToList();
    }
    storeLoader = true;
    update();
  }

  Future addStore(context) async {
    buttonLoader = false;
    update();
    var data = jsonEncode({
      "name": name.text,
      "email": email.text,
      "privilege": 2,
      "phone": phone.text,
      "password": password.text,
      "govId": selectedGovernorate.toString(),
      "cityId": selectedCity.toString(),
      "blockId": selectedBlock.toString(),
      "activeStatus": selectedStatus.toString(),
    });
    var response = await postAPI(context, "store/add", data);

    if (response['status'] == true) {
      tempStore = storeModalFromJson(response['data']);
      Get.back();
      addStoreToList();
    }
    buttonLoader = true;
    update();
  }

  Future updateStore(context, storeId) async {
    buttonLoader = false;
    update();
    var data = jsonEncode({
      "id": storeId.toString(),
      "name": name.text,
      "phone": phone.text,
      "govId": selectedGovernorate.toString(),
      "cityId": selectedCity.toString(),
      "blockId": selectedBlock.toString(),
      "activeStatus": selectedStatus.toString(),
    });
    var response = await postAPI(context, "store/update", data);
    if (response['status'] == true) {
      tempStore = storeModalFromJson(response['data']);
      Get.back();
      addStoreToList();
    }
    buttonLoader = true;
    update();
  }

  Future deleteStore(context, storeId) async {
    final homeController = Get.put(HomeController());
    homeController.buttonLoader = false;
    homeController.update();
    var data = jsonEncode({"id": storeId.toString()});
    var response = await postAPI(context, "store/delete", data);
    if (response['status'] == true) {
      tempStore = storeModalFromJson(response['data']);
      Get.back();
      addStoreToList();
    }
    homeController.buttonLoader = true;
    homeController.update();
    update();
  }

  addStoreToList() {
    store.clear();
    for (int i = 0; i < tempStore.length; i++) {
      var currentIndex = tempStore[i];
      if (currentIndex.name
              .toString()
              .toLowerCase()
              .contains(search.text.toLowerCase()) ||
          currentIndex.phone
              .toString()
              .toLowerCase()
              .contains(search.text.toLowerCase())) {
        store.add({
          "id": currentIndex.id,
          "name": currentIndex.name,
          "phone": currentIndex.phone,
          "govId": currentIndex.govId,
          "cityId": currentIndex.cityId,
          "blockId": currentIndex.blockId,
          "activeStatus": currentIndex.activeStatus,
        });
      }
    }
    update();
  }

  StoreLocationModal? storeLocationModal;
  Future getLocation(context) async {
    // storeLoader = false;
    // update();
    var response = await getAPI(context, "location/get");
    if (response['status'] == true) {
      storeLocationModal =
          StoreLocationModal.fromJson(jsonDecode(response['data']));
      addGovernorateToList();
    }
    // storeLoader = true;
    // update();
  }

  addGovernorateToList() {
    governorate.clear();
    for (var i = 0; i < storeLocationModal!.governorate!.length; i++) {
      var currentIndex = storeLocationModal!.governorate![i];
      governorate.add({
        "id": currentIndex.id.toString(),
        "name": Get.locale == const Locale('ar', 'KW')
            ? currentIndex.nameAr
            : currentIndex.nameEng,
      });
    }
    update();
  }

  addCityToList() {
    city.clear();
    for (var i = 0; i < storeLocationModal!.city!.length; i++) {
      var currentIndex = storeLocationModal!.city![i];
      if (selectedGovernorate == currentIndex.govId.toString()) {
        city.add({
          "id": currentIndex.id.toString(),
          "name": Get.locale == const Locale('ar', 'KW')
              ? currentIndex.nameAr
              : currentIndex.nameEng,
        });
      }
    }
    update();
  }

  addBlockToList() {
    block.clear();
    for (var i = 0; i < storeLocationModal!.block!.length; i++) {
      var currentIndex = storeLocationModal!.block![i];
      if (selectedGovernorate == currentIndex.govId.toString() &&
          selectedCity == currentIndex.cityId.toString()) {
        block.add({
          "id": currentIndex.id.toString(),
          "name": Get.locale == const Locale('ar', 'KW')
              ? currentIndex.nameAr
              : currentIndex.nameEng,
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
    phone.clear();
    password.clear();
    selectedGovernorate = "";
    selectedCity = "";
    selectedBlock = "";
    selectedStatus = "";
    buttonLoader = true;
    update();
  }

  setFormFields(currentIndex) async {
    var temp = "";
    if (currentIndex["image"] != "") {
      temp = currentIndex['image'].toString().split("/").last;
    }
    name.text = currentIndex['name'];
    phone.text = currentIndex['phone'];
    selectedGovernorate = currentIndex['govId'].toString();
    await addCityToList();
    selectedCity = currentIndex['cityId'].toString();
    await addBlockToList();
    selectedBlock = currentIndex['blockId'].toString();
    selectedStatus = currentIndex['activeStatus'].toString();
    update();
  }
}
