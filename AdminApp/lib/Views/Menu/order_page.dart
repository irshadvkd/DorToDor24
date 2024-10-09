import 'package:dortodorpartner/Controllers/Order/order_controller.dart';
import 'package:dortodorpartner/Helper/common_card.dart';
import 'package:dortodorpartner/Helper/string.dart';
import 'package:dortodorpartner/Modals/Order/order_modal.dart';
import 'package:dortodorpartner/Views/Menu/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersPage extends GetView<OrderController> {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (controller) {
      return ListView.builder(
        itemCount: controller.orders.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          var currentOrder = controller.orders[index];
          return orderItemCard(context, currentOrder);
        },
      );
    });
  }

  Widget orderItemCard(context, currentOrder) {
    bool isArabic = Get.locale == const Locale('ar', 'KW') ? true : false;
    var status = currentOrder['status'] == 0
        ? 'Pending'
        : currentOrder['status'] == 1
            ? 'Processing'
            : currentOrder['status'] == 2
                ? "Shipped"
                : currentOrder['status'] == 3
                    ? "Delivered"
                    : currentOrder['status'] == 4
                        ? "Cancelled"
                        : "";
    return CommonCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(12, 15, 12, 12),
      onTap: () {
        // Implement navigation to the order details page
        controller.getOrderDetail(context, currentOrder['id']);
        debugPrint('Tapped on Order');
        Get.to(() => const OrderDetailsPage());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order #${currentOrder['id']}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                currentOrder['date'],
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                "Total: ",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                "${currentOrder['amount']} ${isArabic ? currencyCodeAr : currencyCodeEng}",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                "Status: ",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Expanded(
                child: Text(
                  status,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const Icon(Icons.chevron_right)
            ],
          ),
        ],
      ),
    );
  }
}
