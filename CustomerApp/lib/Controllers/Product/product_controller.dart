import 'dart:convert';

import 'package:dorTodor24/Controllers/Home/home_controller.dart';
import 'package:dorTodor24/Helper/common_alert.dart';
import 'package:dorTodor24/Helper/session.dart';
import 'package:dorTodor24/Helper/string.dart';
import 'package:dorTodor24/Modals/Product/cart_modal.dart';
import 'package:dorTodor24/Modals/Product/order_modal.dart';
import 'package:dorTodor24/Modals/Product/product_modal.dart';
import 'package:dorTodor24/Modals/Product/sub_category_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  TextEditingController searchInSubCategory = TextEditingController();
  TextEditingController searchInProduct = TextEditingController();

  TextEditingController buildingNo = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  TextEditingController deliveryNote = TextEditingController();

  bool isNetworkAvail = true;
  bool buttonLoader = true;
  bool subCategoryLoader = true;
  bool productLoader = true;
  bool orderLoader = true;
  bool isCashOnDelivery = true;

  List subCategory = [];
  List product = [];
  List cartItems = [];
  List subCategorySlider = [];

  double cartTotal = 0;

  SubCategoryModal? subCategoryModal;
  Future getSubCategory(context, categoryId) async {
    isNetworkAvail = await isNetworkAvailable();
    // if (isNetworkAvail) {
    subCategoryLoader = false;
    update();
    var response = await getAPI(
      context,
      "subCategory/getWithSlider?catId=$categoryId",
    );
    if (response['status'] == true) {
      subCategoryModal = SubCategoryModal.fromJson(response['body']);
      subCategorySlider.clear();
      for (var item in subCategoryModal!.banner ?? []) {
        subCategorySlider.add({
          "id": item.id,
          "title": item.name,
          "image": "$imgUrl${item.image}",
        });
      }
      addSubCategoryToList();
      // }
      subCategoryLoader = true;
    }
    update();
  }

  addSubCategoryToList() {
    subCategory.clear();
    for (var i = 0; i < subCategoryModal!.data!.length; i++) {
      var currentIndex = subCategoryModal!.data![i];
      if (currentIndex.nameEng
              .toString()
              .toLowerCase()
              .contains(searchInSubCategory.text.toLowerCase()) ||
          currentIndex.nameAr
              .toString()
              .toLowerCase()
              .contains(searchInSubCategory.text.toLowerCase())) {
        subCategory.add({
          "id": currentIndex.id.toString(),
          "nameEng": currentIndex.nameEng ?? "",
          "nameAr": currentIndex.nameAr ?? "",
          "image": "$imgUrl${currentIndex.image}",
        });
      }
    }
    update();
  }

  ProductModal? productModal;
  Future getProduct(context, subCategoryId) async {
    isNetworkAvail = await isNetworkAvailable();
    // if (isNetworkAvail) {
    productLoader = false;
    update();

    var response = await getAPI(
      context,
      "product/getBySubCat?subCatId=$subCategoryId&userId=1",
    );
    if (response['status'] == true) {
      productModal = ProductModal.fromJson(response['body']);
      addProductToList();
    }
    productLoader = true;
    // }
    update();
  }

  addProductToList() {
    cartItems.clear();
    for (var i = 0; i < productModal!.cart!.length; i++) {
      var currentIndex = productModal!.cart![i];
      cartItems.add({
        "id": currentIndex.id.toString(),
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
    print(productModal!.cart);
    print(cartItems);
    product.clear();
    for (var i = 0; i < productModal!.data!.length; i++) {
      var currentIndex = productModal!.data![i];
      if (currentIndex.nameEng
              .toString()
              .toLowerCase()
              .contains(searchInProduct.text.toLowerCase()) ||
          currentIndex.nameAr
              .toString()
              .toLowerCase()
              .contains(searchInProduct.text.toLowerCase())) {
        var cartId = "0";
        int qty = 0;
        for (var item in cartItems) {
          if (item['productId'].toString() == currentIndex.id.toString()) {
            cartId = item['id'];
            qty = item['proQty'];
            break;
          }
        }
        product.add({
          "id": currentIndex.id.toString(),
          "nameEng": currentIndex.nameEng ?? "",
          "nameAr": currentIndex.nameAr ?? "",
          "image": "$imgUrl${currentIndex.image}",
          "price": currentIndex.price ?? "",
          "cartId": cartId,
          "qty": qty,
          "descriptionEng": currentIndex.descEng ?? "",
          "descriptionAr": currentIndex.descAr ?? "",
        });
      }
    }
    update();
  }

  CartModal? cartModal;

  Future getCart(context) async {
    isNetworkAvail = await isNetworkAvailable();
    // if (isNetworkAvail) {
    buttonLoader = false;
    update();
    var userId = "1";
    var response = await getAPI(context, "product/getCart?userId=$userId");
    if (response['status'] == true) {
      cartModal = CartModal.fromJson(response['body']);
      addCartToList();
    }
    buttonLoader = true;
    // }
    update();
  }

  Future addToCart(context, productId, qty, subCatId) async {
    isNetworkAvail = await isNetworkAvailable();
    // if (isNetworkAvail) {
    buttonLoader = false;
    update();
    var userId = "1";
    var data = {
      "userId": userId,
      "productId": productId,
      "qty": qty,
      "subCatId": subCatId,
    };
    var response = await postAPI(
      context,
      "product/addCart",
      jsonEncode(data),
    );
    if (response['status'] == true) {
      productModal = ProductModal.fromJson(response['body']);
      addProductToList();
    }
    buttonLoader = true;
    // }
    update();
  }

  Future updateCart(context, cartId, qty, isFromCart, subCatId) async {
    isNetworkAvail = await isNetworkAvailable();
    // if (isNetworkAvail) {
    buttonLoader = false;
    update();
    var userId = "1";
    var data = {
      "userId": userId,
      "cartId": cartId,
      "qty": qty,
    };
    var response = await postAPI(
      context,
      "product/updateCart",
      jsonEncode(data),
    );
    if (response['status'] == true) {
      cartModal = CartModal.fromJson(response['body']);
      await addCartToList();
      if (isFromCart == false) {
        getProduct(context, subCatId);
      }
      // }
      buttonLoader = true;
    }
    update();
  }

  Future deleteCart(context, cartId, isFromCart, subCatId) async {
    isNetworkAvail = await isNetworkAvailable();
    // if (isNetworkAvail) {
    buttonLoader = false;
    update();
    var userId = "1";
    var data = {
      "userId": userId,
      "cartId": cartId,
    };
    var response = await postAPI(
      context,
      "product/deleteCart",
      jsonEncode(data),
    );
    if (response['status'] == true) {
      cartModal = CartModal.fromJson(response['body']);
      await addCartToList();
      if (isFromCart == false) {
        getProduct(context, subCatId);
      }
    }
    buttonLoader = true;
    // }
    update();
  }

  addCartToList() {
    cartItems.clear();
    cartTotal = 0;
    for (var i = 0; i < cartModal!.data!.length; i++) {
      var currentIndex = cartModal!.data![i];
      cartItems.add({
        "id": currentIndex.id.toString(),
        "productId": currentIndex.productId,
        "proQty": currentIndex.proQty,
        "nameEng": currentIndex.nameEng,
        "nameAr": currentIndex.nameAr,
        "image": "$imgUrl${currentIndex.image}",
        "price": currentIndex.price,
        "unitEng": currentIndex.unitEng,
        "unitAr": currentIndex.unitAr,
      });
      cartTotal = cartTotal +
          (currentIndex.proQty! * double.parse(currentIndex.price!));
    }
    update();
  }

  Future confirmOrder(
    context,
    storeId,
  ) async {
    isNetworkAvail = await isNetworkAvailable();
    // if (isNetworkAvail) {
    orderLoader = false;
    update();
    var userId = "1";
    var data = {
      "userId": userId,
      "storeId": storeId,
      "building": buildingNo.text,
      "address": address.text,
      "contact": contactNumber.text,
      "note": deliveryNote.text,
    };
    var response = await postAPI(
      context,
      "orders/add",
      jsonEncode(data),
    );
    if (response['status'] == true) {
      // var orderModal = OrderModal.fromJson(response['body']);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: CommonAlert(
              msg: "Your order has been successfully placed!",
              onTap: () {
                final homeController = Get.put(HomeController());
                homeController.currentPage = 0;
                cartTotal = 0;
                Get.offAllNamed("/home");
              },
            ),
          );
        },
      );
    }
    orderLoader = true;
    // }
    update();
  }
}
