import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/Menu/order_controller.dart';
import 'order_detail.dart';

class OrdersPage extends GetView<OrderController> {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      init: OrderController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Orders'),
          ),
          body: Expanded(
            child: controller.order.isEmpty
                ? const Center(child: Text('No orders found.'))
                : ListView.builder(
              itemCount: controller.order.length,
              itemBuilder: (context, index) {
                var currentOrder = controller.order[index];

                return orderItemCard(
                  context,
                  'Order ${currentOrder.id ?? 'N/A'}',
                  currentOrder.createdAt ?? 'N/A',
                  getOrderStatus(currentOrder.status ?? -1), // Default to -1 if null
                  currentOrder.amount ?? '0', // Default to '0' if null
                      () {
                    debugPrint('Tapped on Order #${currentOrder.id}');
                    controller.orderDetails(context, '${currentOrder.id}');
                    Get.to(() => const OrderDetailsPage());
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }


  String getOrderStatus(int status) {
    switch (status) {
      case 0: return 'Pending';
      case 1: return 'Accepted/Packing';
      case 2: return 'On the way';
      case 3: return 'Completed';
      case 4: return 'Cancelled';
      default: return 'Unknown';
    }
  }

  Widget orderItemCard(BuildContext context, String orderNumber, String date, String status, String amount, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(
          orderNumber,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order Date: $date", style: Theme.of(context).textTheme.bodySmall),
            Text("Total: $amount KWD", style: Theme.of(context).textTheme.bodyLarge),
            Text("Status: $status", style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
