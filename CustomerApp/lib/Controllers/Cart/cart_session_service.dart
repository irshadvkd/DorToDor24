import 'package:dorTodor24/Modals/Product/cart_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static const String _cartKey = 'cart_data';

  /// Save CartModal to shared preferences
  Future<void> saveCart(CartModal cartModal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    /// Convert CartModal to JSON string
    String cartJson = cartModalToJson(cartModal);

    /// Save JSON string in shared preferences
    await prefs.setString(_cartKey, cartJson);
  }

  /// Retrieve CartModal from shared preferences
  Future<CartModal?> getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartJson = prefs.getString(_cartKey);

    if (cartJson != null) {
      /// Convert JSON string back to CartModal
      return cartModalFromJson(cartJson);
    }
    return null;
  }

  /// Clear cart data from shared preferences
  Future<void> clearCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }

  /// Add an item to the cart
  Future<void> addToCart(Data newItem) async {
    CartModal? cartModal = await getCart();

    if (cartModal == null) {
      /// If the cart is empty, create a new CartModal with the item
      cartModal = CartModal(data: [newItem]);
    } else {
      /// Check if the item is already in the cart
      int index = cartModal.data
              ?.indexWhere((item) => item.productId == newItem.productId) ??
          -1;

      if (index >= 0) {
        /// Update quantity if item already exists in the cart
        cartModal.data?[index].proQty =
            (cartModal.data?[index].proQty ?? 0) + newItem.proQty!;
      } else {
        /// Add new item to the cart
        cartModal.data?.add(newItem);
      }
    }

    await saveCart(cartModal);
  }

  /// Remove an item from the cart
  Future<void> removeFromCart(int productId) async {
    CartModal? cartModal = await getCart();

    if (cartModal != null) {
      cartModal.data?.removeWhere((item) => item.productId == productId);
      await saveCart(cartModal);
    }
  }
}
