import 'dart:convert';

import 'package:dorTodor24/Helper/session.dart';
import 'package:dorTodor24/Helper/string.dart';
import 'package:dorTodor24/Modals/Product/cart_modal.dart';
import 'package:dorTodor24/Modals/Product/product_modal.dart';
import 'package:dorTodor24/Modals/Product/sub_category_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  TextEditingController searchInCategory = TextEditingController();

  bool isNetworkAvail = true;
  bool buttonLoader = true;
  bool subCategoryLoader = true;
  bool productLoader = true;

  List subCategory = [];
  List product = [];
  final List<String> images = [
    'https://drive.google.com/uc?export=view&id=1rPAUi6Lu7Vi9zoRTSnjoPnq8y79oz_hd',
    'https://drive.google.com/uc?export=view&id=1_fNKeyl8me9iCmmuFV1qUFVLurjOnKi3',
    'https://example.com/image3.jpg',
  ];
  List cartItems = [];
  List subCategorySlider = [];

  SubCategoryModal? subCategoryModal;
  Future getSubCategory(context, categoryId) async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
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
      }
      subCategoryLoader = true;
    }
    update();
  }

  addSubCategoryToList() {
    subCategory.clear();
    for (var i = 0; i < subCategoryModal!.data!.length; i++) {
      var currentIndex = subCategoryModal!.data![i];
      subCategory.add({
        "id": currentIndex.id ?? "",
        "nameEng": currentIndex.nameEng ?? "",
        "nameAr": currentIndex.nameAr ?? "",
        "image": "$imgUrl${currentIndex.image}",
      });
    }
    update();
  }

  ProductModal? productModal;
  Future getProduct(context, subCategoryId) async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      productLoader = false;
      update();

      var response = await getAPI(
        context,
        "product/getBySubCat?subCatId=$subCategoryId",
      );
      if (response['status'] == true) {
        productModal = ProductModal.fromJson(response['body']);
        addProductToList();
      }
      productLoader = true;
    }
    update();
  }

  addProductToList() {
    product.clear();
    for (var i = 0; i < productModal!.data!.length; i++) {
      var currentIndex = productModal!.data![i];
      if (currentIndex.nameEng
              .toString()
              .toLowerCase()
              .contains(searchInCategory.text.toLowerCase()) ||
          currentIndex.nameAr
              .toString()
              .toLowerCase()
              .contains(searchInCategory.text.toLowerCase())) {
        var cartId = 0;
        var qty = 0;
        for (var item in cartItems) {
          if (item['productId'].toString() == currentIndex.id.toString()) {
            cartId = item['id'];
            qty = item['proQty'];
            break;
          }
        }
        product.add({
          "id": currentIndex.id ?? "",
          "nameEng": currentIndex.nameEng ?? "",
          "nameAr": currentIndex.nameAr ?? "",
          "image": "$imgUrl${currentIndex.image}",
          "price": currentIndex.price ?? "",
          "cartId": cartId,
          "qty": qty,
          "descriptionEng": currentIndex.descEng ?? "",
          "descriptionAr": currentIndex.descAr ?? "",
        });
        print(product);
      }
    }
    update();
  }

  CartModal? cartModal;

  Future getCart(context) async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      buttonLoader = false;
      update();
      var userId = "1";
      var response = await getAPI(context, "product/getCart?userId=$userId");
      if (response['status'] == true) {
        cartModal = CartModal.fromJson(response['body']);
        addCartToList();
      }
      buttonLoader = true;
    }
    update();
  }

  Future addToCart(context, productId, qty) async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      buttonLoader = false;
      update();
      var userId = "1";
      var data = {
        "userId": userId,
        "productId": productId,
        "qty": qty,
      };
      var response = await postAPI(
        context,
        "product/addCart",
        jsonEncode(data),
      );
      if (response['status'] == true) {
        cartModal = CartModal.fromJson(response['body']);
        addCartToList();
      }
      buttonLoader = true;
    }
    update();
  }

  Future updateCart(context, cartId, qty) async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
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
        addCartToList();
      }
      buttonLoader = true;
    }
    update();
  }

  Future deleteCart(context, cartId) async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
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
        addCartToList();
      }
      buttonLoader = true;
    }
    update();
  }

  addCartToList() {
    cartItems.clear();
    for (var i = 0; i < cartModal!.data!.length; i++) {
      var currentIndex = cartModal!.data![i];
      cartItems.add({
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
    update();
  }

  // Observable variable to keep track of the selected value
  var selectedValue = 0.obs;

  // Method to update the selected value
  void updateSelectedValue(int value) {
    selectedValue.value = value;
  }
}
