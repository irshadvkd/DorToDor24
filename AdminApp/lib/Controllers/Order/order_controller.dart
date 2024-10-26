import 'dart:convert';

import 'package:dortodorpartner/Helper/session.dart';
import 'package:dortodorpartner/Modals/Order/order_detail_modal.dart';
import 'package:dortodorpartner/Modals/Order/order_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  bool isNetworkAvail = true;
  bool buttonLoader = true;
  bool orderLoader = true;
  bool orderDetailLoader = true;

  List<OrderModal> orderModal = [];
  List<OrderModal> orders = []; // Now using List of OrderModal
  List<Data> detailsData = [];
  List<Products> detailsProducts = [];

  Future getAllOrdersAdmin(context) async {
    isNetworkAvail = await isNetworkAvailable();
    orderLoader = false;
    update();
    var response = await getAPI(context, "orders/get");
    if (response['status'] == true) {
      print('------Admin View Order fetch Success ------');
      orderModal = orderModalFromJson(response['data']);
      addOrderToList();
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
      orderModal = orderModalFromJson(response['data']);
      addOrderToList();
    }
    orderLoader = true;
    update();
  }

  // Add OrderModal instances directly to the orders list
  addOrderToList() {
    orders.clear();
    orders.addAll(orderModal); // Directly add OrderModal instances
    update();
  }

  OrderDetailModal? orderDetailModal;
  Future<void> getOrderDetailUser(BuildContext context, orderId) async {
    isNetworkAvail = await isNetworkAvailable();
    orderDetailLoader = false;
    update();

    var body = jsonEncode({"orderId": orderId});
    var response = await postAPI(context, "orders/getDetail", body);

    if (response['status'] == true) {
      print('------ Customer Order Details fetch Success ------');
      orderDetailModal = OrderDetailModal.fromJson(jsonDecode(response['data']));
      detailsData = [orderDetailModal!.data!];
      detailsProducts = orderDetailModal!.products!;
    } else {
      orderDetailModal = null; // Resetting to null if fetch fails
      print('Failed to fetch orders: ${response['status']}');
    }

    orderDetailLoader = true;
    update();
  }

  List<Map<String, dynamic>> get mappedOrderDetailsProducts {
    return detailsProducts.map((product) => product.toJson()).toList();
  }

  var isExpanded = false.obs;
  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }

}
