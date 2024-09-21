import 'dart:convert';
import 'dart:math';
import 'package:dorTodor24/Controllers/Product/product_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' as storage;

import '../../Modals/Product/cart_modal.dart';

class CartController extends GetxController {
  final _storage = storage.GetStorage(); // Initialize GetStorage
  final String _cartKey = 'cart_data'; // Key to store cart data in session

  Rx<CartModal> cartModal = CartModal().obs; // Reactive cart modal
  RxList<Data> cartItems = <Data>[].obs; // Reactive list of cart items
  RxDouble cartTotal = 0.0.obs; // Total cart value
  RxBool isFromCart = false.obs; // Flag to check if it's from cart
  RxBool isLoading = false.obs; // Loading state for API calls

  @override
  void onInit() {
    super.onInit();
    loadCartFromSession(); // Load cart from session on init
  }

  int generateCartId() {
    int timestamp =
        DateTime.now().millisecondsSinceEpoch; // Get the current timestamp
    int randomPart = Random().nextInt(1000); // Generate a random number
    return timestamp + randomPart; // Combine them for a unique ID
  }

  // Load cart data from session (GetStorage)
  void loadCartFromSession() {
    String? cartJson = _storage.read(_cartKey); // Read from GetStorage
    if (cartJson != null) {
      try {
        cartModal.value =
            CartModal.fromJson(jsonDecode(cartJson)); // Decode JSON
        addCartToList(true); // Update cart items
      } catch (e) {
        print(
            "Error parsing cart JSON: $e"); // Catch and log any parsing errors
      }
    }
  }

  // Save cart data to session (GetStorage)
  void saveCartToSession() {
    String cartJson =
        cartModalToJson(cartModal.value); // Convert CartModal to JSON string
    _storage.write(_cartKey, cartJson); // Save to GetStorage
  }

  // Clear cart data from session
  void clearCartSession() {
    _storage.remove(_cartKey); // Remove cart data from storage
    cartItems.clear();
    cartTotal.value = 0.0;
    cartModal.value = CartModal(); // Reset the cart modal
    update(); // Notify UI
  }

  // Add an item to the cart
  void addToCart(context, Data newItem, subCatId, fromCart) {
    isFromCart.value = fromCart; // Set the flag
    isLoading.value = true; // Start loading state
    update();
    // Check if the cart exists
    if (cartModal.value.data == null) {
      cartModal.value = CartModal(data: [newItem]);
    } else {
      // Check if the item already exists in the cart
      int index = cartModal.value.data!
          .indexWhere((item) => item.productId == newItem.productId);
      if (index >= 0) {
        // Update the quantity if the item already exists
        cartModal.value.data![index].proQty = newItem.proQty!;
        final productController = Get.put(ProductController());
        for (var i = 0; i < productController.product.length; i++) {
          if (productController.product[i]['id'] ==
              newItem.productId.toString()) {
            productController.product[i]['qty'] = newItem.proQty.toString();
          }
        }
        productController.update();
      } else {
        // Add the new item to the cart
        cartModal.value.data!.add(newItem);
        final productController = Get.put(ProductController());
        for (var i = 0; i < productController.product.length; i++) {
          if (productController.product[i]['id'] ==
              newItem.productId.toString()) {
            productController.product[i]['qty'] = newItem.proQty.toString();
          }
        }
        productController.update();
        print(cartModal.value.data![0].proQty);
      }
    }

    saveCartToSession(); // Save the updated cart to session
    addCartToList(fromCart); // Update the UI

    if (!isFromCart.value) {
      final productController = Get.put(ProductController());
      productController.getProduct(context, subCatId);
      productController.update();
    }

    isLoading.value = false; // Stop loading state
    update();
  }

  // Remove an item from the cart
  void removeFromCart(context, int cartId, subCatId, fromCart) {
    isFromCart.value = fromCart; // Set the flag
    isLoading.value = true; // Start loading state
    update();

    if (cartModal.value.data != null) {
      cartModal.value.data!.removeWhere((item) => item.id == cartId);
      saveCartToSession(); // Save the updated cart to session
      addCartToList(fromCart); // Update the UI
    }

    if (!isFromCart.value) {
      final productController = Get.put(ProductController());
      productController.getProduct(context, subCatId);
      productController.update();
    }

    isLoading.value = false; // Stop loading state
    update();
  }

  // Update cart items and calculate total
  void addCartToList(bool fromCart) {
    isFromCart.value= fromCart;
    cartItems.clear(); // Clear previous items
    cartTotal.value = 0; // Reset total
    if (cartModal.value.data != null) {
      for (var currentItem in cartModal.value.data!) {
        cartItems.add(currentItem);
        print(currentItem.id);
        print(currentItem.nameEng);

        // Calculate total cart price
        cartTotal.value +=
            (currentItem.proQty! * double.parse(currentItem.price!));
      }
    }
    update();
    if (!isFromCart.value) {
      final productController = Get.put(ProductController());
      productController.addProductToList();
      productController.update();
      update(); // Notify UI of changes
    }
  }

  void clearCart() {
    // Remove the cart data from GetStorage
    _storage.remove(_cartKey); // Assuming _cartKey is the key for cart data

    // Reset reactive variables related to the cart
    cartItems.clear(); // Clear the list of cart items
    cartTotal.value = 0.0; // Reset the total value
    cartModal.value = CartModal(); // Reset the cart modal to its initial state

    update(); // Notify listeners about the changes
  }

  Data mapToData(map) {
    return Data(
      id: int.tryParse(map['id'].toString()),
      productId: int.tryParse(map['productId'].toString()),
      proQty: int.tryParse(map['proQty'].toString()),
      nameEng: map['nameEng'],
      nameAr: map['nameAr'],
      image: map['image'],
      price: map['price'],
      unitEng: map['unitEng'],
      unitAr: map['unitAr'],
    );
  }
}
