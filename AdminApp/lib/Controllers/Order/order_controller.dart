import 'dart:convert';

import 'package:dortodorpartner/Helper/session.dart';
import 'package:dortodorpartner/Modals/Order/order_detail_modal.dart';
import 'package:dortodorpartner/Modals/Order/admin_order_modal.dart';
import 'package:dortodorpartner/Modals/Order/order_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  bool isNetworkAvail = true;
  bool orderLoader = true;
  bool orderDetailLoader = true;
  List<Order> order = [];
  List<Data> detailsData = [];
  List<Product> detailsProducts = [];
  OrderModal? orderModal;
  OrderDetailsModel? orderDetailsModal;


  AdminOrderModal? adminOrderModal;
  List<AdminOrderModal> adminOrder = [];
  Future getAllOrdersAdmin(context) async {
    isNetworkAvail = await isNetworkAvailable();
    orderLoader = false;
    update();
    var response = await getAPI(context, "orders/get");
    if (response['status'] == true) {
      print('------Admin View Order fetch Success ------');
      adminOrderModal = AdminOrderModal.fromJson(response['body']);
      adminOrder = [adminOrderModal!];
    }
    orderLoader = true;
    update();
  }

  Future getAllOrdersStore(context, storeId) async {
    isNetworkAvail = await isNetworkAvailable();
    orderLoader = false;
    update();
    var response =
    await postAPI(context, "orders/getByStoreId", jsonEncode({"storeId": storeId}));
    if (response['status'] == true) {
      print('------Store View Order fetch Success ------');
      // orderModal = orderModalFromJson(response['data']);
    }
    orderLoader = true;
    update();
  }

  Future<void> getOrderDetailUser(BuildContext context, String orderId) async {
    isNetworkAvail = await isNetworkAvailable();
    orderDetailLoader = true;
    update();

    var body = jsonEncode({"orderId": orderId});
    var response = await postAPI(context, 'orders/getDetail', body);

    if (response['status'] == true) {
      print('------ Customer Order Details fetch Success ------');
      orderDetailsModal = OrderDetailsModel.fromJson(response['body']);
      detailsData = [orderDetailsModal!.data!];
      print("--------------------------");
      print(jsonEncode(orderDetailsModal?.toJson()));
      print("--------------------------");
      detailsProducts = orderDetailsModal!.products!;
      // Log to confirm product image URLs
      // detailsProducts.forEach((product) {
      //   print('Product Image URL: ${product.image}');
      // });
      // addOrderToList();
      print("----detailsProducts-------");
      print("--------------------------");
      print(detailsProducts);
      print("--------------------------");
    } else {
      // Handle the case where the response is not successful
      orderDetailsModal = null; // Resetting to null
      print('Failed to fetch orders: ${response['status']}');
    }

    orderDetailLoader = false;
    update();
  }

  List<Map<String, dynamic>> get mappedOrderDetailsProducts {
    return detailsProducts.map((product) => product.toJson()).toList();
  }
}
