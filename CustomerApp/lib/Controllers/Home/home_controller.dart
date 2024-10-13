import 'dart:convert';

import 'package:dorTodor24/Controllers/Product/product_controller.dart';
import 'package:dorTodor24/Helper/session.dart';
import 'package:dorTodor24/Helper/string.dart';
import 'package:dorTodor24/Modals/Home/home_modal.dart';
import 'package:dorTodor24/Modals/Home/location_modal.dart';
import 'package:dorTodor24/Modals/Home/login_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
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


  @override
  void onInit() {
    super.onInit();
    loadUserDetails(); // Load the user details when the controller is initialized
  }

  Future loginUser(context) async {
    buttonLoader = false;
    update();
    var data = jsonEncode({
      "username": userName.text,
      "password": password.text,
    });
    var response = await postAPI(
      context,
      "auth/login",
      data,
    );
    if (response['status'] == true) {
      LoginModal loginModal = LoginModal.fromJson(response['body']);
      var prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLogin", true);
      prefs.setString("userId", loginModal.user!.id.toString());
      prefs.setString("userName", loginModal.user!.name.toString());
      prefs.setString("userEmail", loginModal.user!.email.toString());
      prefs.setString("userPhone", loginModal.user!.phone.toString());
      Get.offAndToNamed('/place');
      getLocation(context);
      currentPage = 0;
    }
    buttonLoader = true;
    update();
  }

  Future<void> loadUserDetails() async {
    var userDetails = await getUserDetails();
    name.text = userDetails['name'] ?? '';
    email.text = userDetails['email'] ?? '';
    phone.text = userDetails['phone'] ?? '';
    update(); // Notify the UI that the data has been updated
  }

  Future<Map<String, String>> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    String? userName = prefs.getString("userName");
    String? userEmail = prefs.getString("userEmail");
    String? userPhone = prefs.getString("userPhone");

    return {
      'id': userId ?? '',
      'name': userName ?? '',
      'email': userEmail ?? '',
      'phone': userPhone ?? '',
    };
  }

  Future registerUser(context) async {
    buttonLoader = false;
    update();
    var data = jsonEncode({
      "name": name.text,
      "email": email.text,
      "phone": phone.text,
      "password": password.text,
    });
    var response = await postAPI(
      context,
      "auth/register",
      data,
    );
    if (response['status'] == true) {
      LoginModal loginModal = LoginModal.fromJson(response['body']);
      var prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLogin", true);
      prefs.setString("userId", loginModal.user!.id.toString());
      prefs.setString("userName", loginModal.user!.name.toString());
      prefs.setString("userEmail", loginModal.user!.email.toString());
      prefs.setString("userPhone", loginModal.user!.phone.toString());
      Get.offAndToNamed('/place');
      getLocation(context);
      currentPage = 0;
    }
    buttonLoader = true;
    update();
  }

  HomeModal? homeModal;
  Future getHome(context) async {
    isNetworkAvail = await isNetworkAvailable();
    // if (isNetworkAvail) {
    homeLoader = false;
    update();
    var prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    var response = await getAPI(context, "home/user?userId=$userId");
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
      bool isSelectLocation = false;
      var prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('isSelectLocation') != null) {
        isSelectLocation = prefs.getBool('isSelectLocation')!;
      }
      if (isSelectLocation == true) {
        selectedGovernorate = prefs.getString("governorate") ?? "";
        await addCityToList();
        selectedCity = prefs.getString("city") ?? "";
        await addBlockToList();
        selectedBlock = prefs.getString("block") ?? "";
      }
      // }
      // homeLoader = true;
    }
    update();
  }

  addCityToList() {
    city.clear();
    block.clear();
    selectedCity = "";
    selectedBlock = "";
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
    selectedBlock = "";
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
