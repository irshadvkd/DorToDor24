import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dorTodor24/Controllers/Home/user_controller.dart';
import 'package:dorTodor24/Controllers/Product/product_controller.dart';
import 'package:dorTodor24/Helper/session.dart';
import 'package:dorTodor24/Helper/string.dart';
import 'package:dorTodor24/Modals/Home/home_modal.dart';
import 'package:dorTodor24/Modals/Home/location_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Modals/Home/user_model.dart';

class HomeController extends GetxController {
  TextEditingController userName = TextEditingController();
  TextEditingController passWord = TextEditingController();
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
    Get.offAndToNamed("/home");
    getHome(context);
    update();
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

  // Login Password visibility
  var obscurePassword = true.obs;
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();  // Clear all saved data

    Get.offNamed('/login');  // Redirect to login page after logout
  }

  var isLoading = false.obs;
  Future<bool> login() async {
    isLoading.value = true;

    String username = userName.text;
    String password = passWord.text;

    var url = Uri.parse('https://dortodor24.com/api/auth/login');
    var body = jsonEncode({'username': username, 'password': password});

    print('----------------');
    print('------- Login Data : Username :$username && pass : $password ---------');

    // Measure API call duration - Debug purpose
    var startTime = DateTime.now();

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      var endTime = DateTime.now();
      print('API Call Duration: ${endTime.difference(startTime).inMilliseconds} ms');

      // Check the status code and the response body
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('------- Login Function Success ---------');
        try {
          var jsonResponse = jsonDecode(response.body);

          // Extract token and user data from the response
          String token = jsonResponse['token'];
          User user = User.fromJson(jsonResponse['user']);
          print('------- Logged-In User Details ---------');
          print('User : $user');
          print('Token: $token');
          print('----------------');

          // Save the token and user data in SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('token', token);
          // Store the whole user data as a JSON string
          await prefs.setString('userData', jsonEncode(user.toJson()));

          // Set the user in UserController
          UserController userController = Get.find();
          userController.setUser(user);

          // Navigate to the homepage
          Get.offNamed('/home');
          // Return true to indicate successful login
          return true;
        } catch (jsonError) {
          print('Error parsing response: $jsonError');
          Get.snackbar(
            'Error',
            'Failed to process user data from response.',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        print('Login Failed. Status Code: ${response.statusCode}');
        print('Error Response Body: ${response.body}');
        Get.snackbar(
          'Login Failed',
          'Invalid username or password',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error during API call: $e');
      Get.snackbar(
        'Error',
        'Failed to connect to the server. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
    // Return false if login is unsuccessful
    return false;
  }

}
