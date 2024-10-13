import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helper/session.dart';
import '../../Modals/Product/order_details_model.dart';
import '../../Modals/Product/order_modal.dart';

class OrderController extends GetxController {
  bool isNetworkAvail = true;
  bool orderLoader = true;
  bool detailsLoader = true;
  List<Order> order = [];
  List<Data> detailsData = [];
  List<Product> detailsProducts = [];
  OrderModal? orderModal;
  OrderDetailsModel? orderDetailsModal;

  Future<void> getOrder(BuildContext context) async {
    isNetworkAvail = await isNetworkAvailable();
    orderLoader = false;
    update();
    var prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    var body = jsonEncode({"userId": userId}); // Use the passed userId
    var response = await postAPI(context, 'orders/getByUserId', body);

    if (response['status'] == true) {
      print('------ Order fetch Success ------');
      orderModal = OrderModal.fromJson(response['body']);
      order = orderModal!.orders; // Populate order list with fetched orders
      // addOrderToList();
    } else {
      // Handle the case where the response is not successful
      orderModal = null; // Resetting to null
      print('Failed to fetch orders: ${response['status']}');
    }

    orderLoader = true;
    update();
  }

  Future<void> orderDetails(BuildContext context, String orderId) async {
    isNetworkAvail = await isNetworkAvailable();
    detailsLoader = true;
    update();

    var body = jsonEncode({"orderId": orderId});
    var response = await postAPI(context, 'orders/getDetail', body);

    if (response['status'] == true) {
      print('------ Order Details fetch Success ------');
      orderDetailsModal = OrderDetailsModel.fromJson(response['body']);
      detailsData = [orderDetailsModal!.data!];
      detailsProducts = orderDetailsModal!.products!;
      // addOrderToList();
    } else {
      // Handle the case where the response is not successful
      orderDetailsModal = null; // Resetting to null
      print('Failed to fetch orders: ${response['status']}');
    }

    detailsLoader = false;
    update();
  }
}
