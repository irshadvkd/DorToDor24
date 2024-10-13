import 'dart:convert';

import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:dortodorpartner/Helper/session.dart';
import 'package:dortodorpartner/Helper/string.dart';
import 'package:dortodorpartner/Modals/Category/category_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SubCategoryController extends GetxController {
  TextEditingController search = TextEditingController();
  TextEditingController nameEng = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  TextEditingController imageName = TextEditingController();

  bool buttonLoader = true;
  bool subCategoryLoader = true;

  List tempSubCategory = [];
  List subCategory = [];

  Future getSubCategory(context, categoryId) async {
    subCategoryLoader = false;
    update();
    var response = await getAPI(context, "subCategory/get?catId=$categoryId");
    if (response['status'] == true) {
      tempSubCategory = categoryModalFromJson(response['data']);
      addSubCategoryToList();
    }
    subCategoryLoader = true;
    update();
  }

  Future addSubCategory(context, categoryId) async {
    buttonLoader = false;
    update();
    List data = [
      {"name": "nameEng", "value": nameEng.text},
      {"name": "nameAr", "value": nameAr.text},
      {"name": "catId", "value": categoryId.toString()}
    ];
    final homeController = Get.put(HomeController());
    var response = await multipartPostAPI(
      context,
      "subCategory/add",
      data,
      homeController.imageFile,
    );
    if (response['status'] == true) {
      tempSubCategory = categoryModalFromJson(response['data']);
      Get.back();
      addSubCategoryToList();
    }
    buttonLoader = true;
    update();
  }

  Future updateSubCategory(context, categoryId, subCategoryId) async {
    buttonLoader = false;
    update();
    List data = [
      {"name": "id", "value": subCategoryId.toString()},
      {"name": "catId", "value": categoryId.toString()},
      {"name": "nameEng", "value": nameEng.text},
      {"name": "nameAr", "value": nameAr.text},
    ];
    final homeController = Get.put(HomeController());
    var response = await multipartPostAPI(
      context,
      "subCategory/update",
      data,
      homeController.imageFile,
    );
    if (response['status'] == true) {
      tempSubCategory = categoryModalFromJson(response['data']);
      Get.back();
      addSubCategoryToList();
    }
    buttonLoader = true;
    update();
  }

  Future deleteSubCategory(context, subCategoryId) async {
    final homeController = Get.put(HomeController());
    homeController.buttonLoader = false;
    homeController.update();
    var data = jsonEncode({"id": subCategoryId.toString()});
    var response = await postAPI(context, "subCategory/delete", data);
    if (response['status'] == true) {
      tempSubCategory = categoryModalFromJson(response['data']);
      Get.back();
      addSubCategoryToList();
    }
    homeController.buttonLoader = true;
    homeController.update();
    update();
  }

  addSubCategoryToList() {
    subCategory.clear();
    for (int i = 0; i < tempSubCategory.length; i++) {
      var currentIndex = tempSubCategory[i];
      if (currentIndex.nameEng
              .toString()
              .toLowerCase()
              .contains(search.text.toLowerCase()) ||
          currentIndex.nameAr
              .toString()
              .toLowerCase()
              .contains(search.text.toLowerCase())) {
        subCategory.add({
          "id": currentIndex.id,
          "nameEng": currentIndex.nameEng,
          "nameAr": currentIndex.nameAr,
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
    nameEng.clear();
    nameAr.clear();
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
    nameEng.text = currentIndex['nameEng'];
    nameAr.text = currentIndex['nameAr'];
    update();
  }
}
