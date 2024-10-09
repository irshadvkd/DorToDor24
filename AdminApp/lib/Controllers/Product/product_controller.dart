import 'dart:convert';

import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:dortodorpartner/Helper/session.dart';
import 'package:dortodorpartner/Helper/string.dart';
import 'package:dortodorpartner/Modals/Product/product_management_modal.dart';
import 'package:dortodorpartner/Modals/Product/product_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  TextEditingController search = TextEditingController();
  TextEditingController nameEng = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  TextEditingController imageName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController unitEng = TextEditingController();
  TextEditingController unitAr = TextEditingController();
  TextEditingController descEng = TextEditingController();
  TextEditingController descAr = TextEditingController();

  bool isNetworkAvail = true;
  bool buttonLoader = true;
  bool subCategoryLoader = true;
  bool productLoader = true;

  List tempProduct = [];
  List disableProduct = [];
  List product = [];

  final List<String> images = [
    'https://img.etimg.com/thumb/width-640,height-480,imgsize-56196,resizemode-75,msid-95423731/magazines/panache/5-reasons-why-tomatoes-should-be-your-favourite-fruit-this-year/tomatoes-canva.jpg',
    'https://example.com/image2.jpg',
    'https://example.com/image3.jpg',
  ];
  List cartItems = [
    {
      "id": 1,
      "productId": 1,
      "name": "Tomato",
      "image":
          "https://img.etimg.com/thumb/width-640,height-480,imgsize-56196,resizemode-75,msid-95423731/magazines/panache/5-reasons-why-tomatoes-should-be-your-favourite-fruit-this-year/tomatoes-canva.jpg",
      "qty": 2,
      "price": "5.75",
    }
  ];
  List subCategorySlider = [
    {
      "id": 1,
      "title": "New",
      "image":
          "https://imgscf.slidemembers.com/docs/1/1/722/grocerystore_pptx_slides_presentation_721814.jpg"
    },
    {
      "id": 2,
      "title": "New",
      "image":
          "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/grocery-food-ad-design-template-9980f9ad133ec18b61132437820f70a0_screen.jpg"
    },
    {
      "id": 3,
      "title": "New",
      "image":
          "https://indiangroceryvictoria.com/groceryapp/wp-content/uploads/2018/06/7-2.jpg"
    }
  ];

  Future getProduct(context, categoryId, subCategoryId) async {
    productLoader = false;
    update();
    var response = await getAPI(
        context, "product/get?catId=$categoryId&subCatId=$subCategoryId");
    if (response['status'] == true) {
      tempProduct = productModalFromJson(response['data']);
      addProductToList();
    }
    productLoader = true;
    update();
  }

  Future addProduct(context, categoryId, subCategoryId) async {
    buttonLoader = false;
    update();
    List data = [
      {"name": "nameEng", "value": nameEng.text},
      {"name": "nameAr", "value": nameAr.text},
      {"name": "catId", "value": categoryId.toString()},
      {"name": "subCatId", "value": subCategoryId.toString()},
      {"name": "price", "value": double.parse(price.text).toStringAsFixed(3)},
      {"name": "unitEng", "value": unitEng.text},
      {"name": "unitAr", "value": unitAr.text},
      {"name": "descEng", "value": descEng.text},
      {"name": "descAr", "value": descAr.text},
    ];
    final homeController = Get.put(HomeController());
    var response = await multipartPostAPI(
      context,
      "product/add",
      data,
      homeController.imageFile,
    );
    if (response['status'] == true) {
      tempProduct = productModalFromJson(response['data']);
      Get.back();
      addProductToList();
    }
    buttonLoader = true;
    update();
  }

  Future updateProduct(context, categoryId, subCategoryId, productId) async {
    buttonLoader = false;
    update();
    List data = [
      {"name": "id", "value": productId.toString()},
      {"name": "nameEng", "value": nameEng.text},
      {"name": "nameAr", "value": nameAr.text},
      {"name": "catId", "value": categoryId.toString()},
      {"name": "subCatId", "value": subCategoryId.toString()},
      {"name": "price", "value": double.parse(price.text).toStringAsFixed(3)},
      {"name": "unitEng", "value": unitEng.text},
      {"name": "unitAr", "value": unitAr.text},
      {"name": "descEng", "value": descEng.text},
      {"name": "descAr", "value": descAr.text},
    ];
    final homeController = Get.put(HomeController());
    var response = await multipartPostAPI(
      context,
      "product/update",
      data,
      homeController.imageFile,
    );
    if (response['status'] == true) {
      tempProduct = productModalFromJson(response['data']);
      Get.back();
      addProductToList();
    }
    buttonLoader = true;
    update();
  }

  Future deleteProduct(context, categoryId, subCategoryId, productId) async {
    final homeController = Get.put(HomeController());
    homeController.buttonLoader = false;
    homeController.update();
    var data = jsonEncode({
      "id": productId.toString(),
      "catId": categoryId.toString(),
      "subCatId": subCategoryId.toString(),
    });
    var response = await postAPI(context, "product/delete", data);
    if (response['status'] == true) {
      tempProduct = productModalFromJson(response['data']);
      Get.back();
      addProductToList();
    }
    homeController.buttonLoader = true;
    homeController.update();
    update();
  }

  addProductToList() {
    product.clear();
    for (int i = 0; i < tempProduct.length; i++) {
      var currentIndex = tempProduct[i];
      if (currentIndex.nameEng
              .toString()
              .toLowerCase()
              .contains(search.text.toLowerCase()) ||
          currentIndex.nameAr
              .toString()
              .toLowerCase()
              .contains(search.text.toLowerCase())) {
        product.add({
          "id": currentIndex.id ?? "",
          "catId": currentIndex.catId ?? "",
          "subCatId": currentIndex.subCatId ?? "",
          "nameEng": currentIndex.nameEng ?? "",
          "nameAr": currentIndex.nameAr ?? "",
          "image": "$imgUrl${currentIndex.image}",
          "price": double.parse(currentIndex.price).toStringAsFixed(3),
          "unitEng": currentIndex.unitEng ?? "",
          "unitAr": currentIndex.unitAr ?? "",
          "qty": 0,
          "descEng": currentIndex.descEng ?? "",
          "descAr": currentIndex.descAr ?? "",
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
    price.clear();
    unitEng.clear();
    unitAr.clear();
    descEng.clear();
    descAr.clear();
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
    price.text = currentIndex['price'];
    unitEng.text = currentIndex['unitEng'];
    unitAr.text = currentIndex['unitAr'];
    descEng.text = currentIndex['descEng'];
    descAr.text = currentIndex['descAr'];
    update();
  }

  Future getAllProduct(context) async {
    productLoader = false;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var storeId = prefs.getString("userId");
    var response = await getAPI(context, "product/getAll?storeId=$storeId");
    if (response['status'] == true) {
      var tempModal = productManagementModalFromJson(response['data']);
      tempProduct = tempModal.data ?? [];
      if (tempModal.disabled![0].disableProduct != null) {
        disableProduct = tempModal.disabled![0].disableProduct
            .split(',')
            .map((item) => item.toString())
            .toList();
      } else {
        disableProduct = [];
      }
      addProductManageToList();
    }
    productLoader = true;
    update();
  }

  addProductManageToList() {
    product.clear();
    for (int i = 0; i < tempProduct.length; i++) {
      var currentIndex = tempProduct[i];
      if (currentIndex.nameEng
              .toString()
              .toLowerCase()
              .contains(search.text.toLowerCase()) ||
          currentIndex.nameAr
              .toString()
              .toLowerCase()
              .contains(search.text.toLowerCase())) {
        var available = true;
        if (disableProduct.contains(currentIndex.id.toString())) {
          available = false;
        }
        product.add({
          "id": currentIndex.id ?? "",
          "nameEng": currentIndex.nameEng ?? "",
          "nameAr": currentIndex.nameAr ?? "",
          "image": "$imgUrl${currentIndex.image}",
          "available": available,
        });
      }
    }
    update();
  }

  Future disableProductApi(context) async {
    productLoader = false;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var storeId = prefs.getString("userId");

    var response = await postAPI(
      context,
      "product/disable",
      jsonEncode({"storeId": storeId, 'products': disableProduct.join(",")}),
    );
    if (response['status'] == true) {
      var tempModal = productManagementModalFromJson(response['data']);
      tempProduct = tempModal.data ?? [];
      if (tempModal.disabled![0].disableProduct != null) {
        disableProduct = tempModal.disabled![0].disableProduct
            .split(',')
            .map((item) => item.toString())
            .toList();
      } else {
        disableProduct = [];
      }
      addProductManageToList();
    }
    productLoader = true;
    update();
  }
}
