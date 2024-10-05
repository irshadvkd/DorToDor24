import 'dart:convert';

import 'package:dorTodor24/Controllers/Product/product_controller.dart';
import 'package:dorTodor24/Helper/session.dart';
import 'package:dorTodor24/Helper/string.dart';
import 'package:dorTodor24/Modals/Home/home_modal.dart';
import 'package:dorTodor24/Modals/Home/location_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Views/Auth/auth_service.dart';

class HomeController extends GetxController {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();

  bool isNetworkAvail = true;
  bool homeLoader = true;
  bool buttonLoader = true;

  int currentPage = 0;

  List slider = [];
  List category = [];
  List governorate = [];
  List city = [];
  List block = [];
  List notifications = [
    {
      "id": 1,
      "title": "New Year Offer",
      "desc":
          "Here is the exciting deals for this new year. dorTodor24 wishing you a Happy New Year.",
      "date": "25 Dec 2023 10:15 AM",
    }
  ];

  String selectedGovernorate = "";
  String selectedCity = "";
  String selectedBlock = "";
  String selectedLanguage = "en";

  Map language = {
    "code": "en",
    "name": "English",
    "flag": "🏴󠁧󠁢󠁥󠁮󠁧󠁿",
  };

  Future loginUser(context) async {
    // Get.offAndToNamed("/home");
    // getHome(context);
    gotoHome(context);
    // update();
  }

  HomeModal? homeModal;
  Future getHome(context) async {
    isNetworkAvail = await isNetworkAvailable();
    // if (isNetworkAvail) {
      homeLoader = false;
      update();
      var response = await getAPI(context, "home/user?userId=1");
      if (response['status'] == true) {
        homeModal = HomeModal.fromJson(response['body']);
        language = english;
        addSliderToList();
        addCategoryToList();
        addCartToList();
      }
      homeLoader = true;
    // }
    update();
  }

  Future<void> gotoHome(BuildContext context) async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      homeLoader = false;
      update();

      var body = jsonEncode({'username': userName, 'password': password});
      var response = await postAPI(context, "auth/login", body);

      if (response['status'] == true) {
        print('------ User Login Success ------');
        String token = response['body']['token'];

        // Save the token to local storage
        await AuthService.saveUserToken(token);

        // Navigate to the home page
        Get.offAndToNamed("/home");
      } else {
        // Show error message
        showSnackBar(context, "Login failed: ${response['statusCode']}");
      }

      homeLoader = true;
      update();
    } else {
      showSnackBar(context, "No network available");
    }
  }


  LocationModal? locationModal;
  Future getLocation(context) async {
    isNetworkAvail = await isNetworkAvailable();
    // if (isNetworkAvail) {
      // homeLoader = false;
      // update();
      var response = await getAPI(context, "location/get");
      if (response['status'] == true) {
        locationModal = LocationModal.fromJson(response['body']);
        governorate.clear();
        for (var item in locationModal!.governorate ?? []) {
          governorate.add({
            "id": item.id.toString(),
            "nameEng": item.nameEng,
            "nameAr": item.nameAr,
          });
        }
      // }
      // homeLoader = true;
    }
    update();
  }

  addCityToList() {
    city.clear();
    for (var item in locationModal!.city ?? []) {
      if (item.govId.toString() == selectedGovernorate) {
        city.add({
          "id": item.id.toString(),
          "nameEng": item.nameEng,
          "nameAr": item.nameAr,
        });
      }
    }
    update();
  }

  addBlockToList() {
    block.clear();
    for (var item in locationModal!.block ?? []) {
      if (item.cityId.toString() == selectedCity) {
        block.add({
          "id": item.id.toString(),
          "nameEng": item.nameEng,
          "nameAr": item.nameAr,
        });
      }
    }
    update();
  }

  addSliderToList() {
    slider.clear();
    for (var i = 0; i < homeModal!.slider!.length; i++) {
      var currentIndex = homeModal!.slider![i];
      slider.add({
        "id": currentIndex.id ?? "",
        "title": currentIndex.name ?? "",
        "image": currentIndex.image ?? "",
      });
    }
    update();
  }

  addCategoryToList() {
    category.clear();
    for (var i = 0; i < homeModal!.category!.length; i++) {
      var currentIndex = homeModal!.category![i];
      category.add({
        "id": currentIndex.id ?? "",
        "nameEng": currentIndex.nameEng ?? "",
        "nameAr": currentIndex.nameAr ?? "",
        "image": currentIndex.image ?? "",
      });
    }
    update();
  }

  addCartToList() {
    final productController = Get.put(ProductController());
    productController.cartItems.clear();
    for (var i = 0; i < homeModal!.cart!.length; i++) {
      var currentIndex = homeModal!.cart![i];
      productController.cartItems.add({
        "id": currentIndex.id,
        "productId": currentIndex.productId,
        "proQty": currentIndex.proQty,
        "nameEng": currentIndex.nameEng,
        "nameAr": currentIndex.nameAr,
        "image": "$imgUrl${currentIndex.image}",
        "price": currentIndex.price,
        "unitEng": currentIndex.unitEng,
        "unitAr": currentIndex.unitAr,
      });
    }
    productController.update();
    update();
  }
}
