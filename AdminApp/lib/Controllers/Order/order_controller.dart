import 'dart:convert';

import 'package:dortodorpartner/Helper/session.dart';
import 'package:dortodorpartner/Modals/Order/order_detail_modal.dart';
import 'package:dortodorpartner/Modals/Order/order_modal.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  bool buttonLoader = true;
  bool orderLoader = true;
  bool orderDetailLoader = true;

  List<OrderModal> orderModal = [];
  List orders = [];

  Future getAllOrders(context) async {
    orderLoader = false;
    update();
    var response = await getAPI(context, "orders/get");
    if (response['status'] == true) {
      orderModal = orderModalFromJson(response['data']);
      addOrderToList();
    }
    orderLoader = true;
    update();
  }

  Future getStoreOrders(context, storeId) async {
    orderLoader = false;
    update();
    var response =
        await postAPI(context, "orders/getByStoreId", jsonEncode({"storeId": storeId}));
    if (response['status'] == true) {
      orderModal = orderModalFromJson(response['data']);
      addOrderToList();
    }
    orderLoader = true;
    update();
  }

  addOrderToList() {
    orders.clear();
    for (var order in orderModal) {
      orders.add({
        "id": order.id,
        "status": order.status,
        "userName": order.userName,
        "amount": order.amount,
        "date": convertStringTime(
            "dd MMM yyyy hh:mm a", "yyyy-MM-ddThh:mm", order.createdAt),
      });
    }
    update();
  }

  OrderDetailModal? orderDetailModal;
  Future getOrderDetail(context, orderId) async {
    orderDetailLoader = false;
    update();
    var body = jsonEncode({"orderId": orderId});
    var response = await postAPI(context, "orders/getDetail", body);
    if (response['status'] == true) {
      orderDetailModal =
          OrderDetailModal.fromJson(jsonDecode(response['data']));
    }
    orderDetailLoader = true;
    update();
  }
}
