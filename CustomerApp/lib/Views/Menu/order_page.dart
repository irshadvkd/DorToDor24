import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Controllers/Menu/order_controller.dart';
import '../../Helper/colors.dart';
import '../../Helper/common_app_bar.dart';
import 'order_detail.dart';

class OrdersPage extends GetView<OrderController> {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      init: OrderController(),
      builder: (controller) {
        return CommonAppBar(
          title: 'My Orders',
          actionEnable: false,
          child: Expanded(
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

  Widget orderItemCard(
      BuildContext context,
      String orderNumber,
      String date,
      String status,
      String amount,
      VoidCallback onTap,
      ) {

    // Parse and format the date
    DateTime parsedDate = DateTime.tryParse(date) ?? DateTime.now();
    String formattedDate = DateFormat('MMM d, yyyy').format(parsedDate); // e.g., "Oct 26, 2024"

    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 8.0),
      child: Card(
        color: colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Add an icon or status indicator on the left
                CircleAvatar(
                  backgroundColor: Colors.blueAccent.withOpacity(0.1),
                  radius: 30,
                  child: const Icon(
                    Icons.shopping_cart,
                    color: colors.themeButton,
                    size: 35,
                  ),
                ),
                const SizedBox(width: 16),
                // Main order information section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderNumber,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Order Date: $formattedDate",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Total: $amount KWD",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status and trailing arrow
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Status with conditional color and icon
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: status == "Completed"
                              ? Colors.green
                              : status == "Pending"
                              ? Colors.orange
                              : Colors.red,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          status,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: status == "Completed"
                                ? colors.textMain
                                : status == "Pending"
                                ? colors.textMain
                                : colors.textMain,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
