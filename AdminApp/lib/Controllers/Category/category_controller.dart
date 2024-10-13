import 'dart:convert';

import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:dortodorpartner/Helper/session.dart';
import 'package:dortodorpartner/Helper/string.dart';
import 'package:dortodorpartner/Modals/Category/category_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  TextEditingController search = TextEditingController();
  TextEditingController nameEng = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  TextEditingController imageName = TextEditingController();

  bool buttonLoader = true;
  bool categoryLoader = true;

  List tempCategory = [];
  List category = [];

  Future getCategory(context) async {
    categoryLoader = false;
    update();
    var response = await getAPI(context, "category/get");
    if (response['status'] == true) {
      tempCategory = categoryModalFromJson(response['data']);
      addCategoryToList();
    }
    categoryLoader = true;
    update();
  }

  Future addCategory(context) async {
    buttonLoader = false;
    update();
    List data = [
      {"name": "nameEng", "value": nameEng.text},
      {"name": "nameAr", "value": nameAr.text}
    ];
    final homeController = Get.put(HomeController());
    var response = await multipartPostAPI(
      context,
      "category/add",
      data,
      homeController.imageFile,
    );
    if (response['status'] == true) {
      tempCategory = categoryModalFromJson(response['data']);
      Get.back();
      addCategoryToList();
    }
    buttonLoader = true;
    update();
  }

  Future updateCategory(context, categoryId) async {
    buttonLoader = false;
    update();
    List data = [
      {"name": "id", "value": categoryId.toString()},
      {"name": "nameEng", "value": nameEng.text},
      {"name": "nameAr", "value": nameAr.text}
    ];
    final homeController = Get.put(HomeController());
    var response = await multipartPostAPI(
      context,
      "category/update",
      data,
      homeController.imageFile,
    );
    if (response['status'] == true) {
      tempCategory = categoryModalFromJson(response['data']);
      Get.back();
      addCategoryToList();
    }
    buttonLoader = true;
    update();
  }

  Future deleteCategory(context, categoryId) async {
    final homeController = Get.put(HomeController());
    homeController.buttonLoader = false;
    homeController.update();
    var data = jsonEncode({"id": categoryId.toString()});
    var response = await postAPI(context, "category/delete", data);
    if (response['status'] == true) {
      tempCategory = categoryModalFromJson(response['data']);
      Get.back();
      addCategoryToList();
    }
    homeController.buttonLoader = true;
    homeController.update();
    update();
  }

  addCategoryToList() {
    category.clear();
    for (int i = 0; i < tempCategory.length; i++) {
      var currentIndex = tempCategory[i];
      if (currentIndex.nameEng
              .toString()
              .toLowerCase()
              .contains(search.text.toLowerCase()) ||
          currentIndex.nameAr
              .toString()
              .toLowerCase()
              .contains(search.text.toLowerCase())) {
        category.add({
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
