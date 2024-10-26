import 'package:dortodorpartner/Controllers/Order/order_controller.dart';
import 'package:dortodorpartner/Views/Order/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Helper/colors.dart';
import '../../Helper/common_app_bar.dart';

class OrdersPage extends GetView<OrderController> {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      init: OrderController(),
      builder: (controller) {
        return CommonAppBar(
          title: 'Orders',
          actionEnable: false,
          child: controller.orders.isEmpty
              ? const Center(child: Text('No orders found.'))
              : ListView.builder(
            itemCount: controller.orders.length,
            itemBuilder: (context, index) {
              var currentOrder = controller.orders[index];

              return orderItemCard(
                context,
                'Order ${currentOrder.id ?? 'N/A'}',
                currentOrder.createdAt ?? 'N/A',
                getOrderStatus(
                    currentOrder.status ?? -1), // Default to -1 if null
                currentOrder.amount ?? '0', // Default to '0' if null
                    () {
                  debugPrint('Tapped on Order #${currentOrder.id}');
                  controller.getOrderDetailUser(context, '${currentOrder.id}');
                  Get.to(() => OrderDetailsPage());
                },
              );
            },
          ),
        );
      },
    );
  }

  String getOrderStatus(int status) {
    switch (status) {
      case 0:
        return 'Pending';
      case 1:
        return 'Accepted/Packing';
      case 2:
        return 'On the way';
      case 3:
        return 'Completed';
      case 4:
        return 'Cancelled';
      default:
        return 'Unknown';
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
    String formattedDate =
    DateFormat('MMM d, yyyy').format(parsedDate); // e.g., "Oct 26, 2024"

    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 4.0),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderNumber,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Order Date: $formattedDate",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Total: $amount KWD",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w500, color: Colors.green),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600, color: colors.textMain),
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


// Widget orderItemCard(context, currentOrder) {
//   bool isArabic = Get.locale == const Locale('ar', 'KW') ? true : false;
//   var status = currentOrder['status'] == 0
//       ? 'Pending'
//       : currentOrder['status'] == 1
//           ? 'Processing'
//           : currentOrder['status'] == 2
//               ? "Shipped"
//               : currentOrder['status'] == 3
//                   ? "Delivered"
//                   : currentOrder['status'] == 4
//                       ? "Cancelled"
//                       : "";
//   return CommonCard(
//     margin: const EdgeInsets.only(bottom: 12),
//     padding: const EdgeInsets.fromLTRB(12, 15, 12, 12),
//     onTap: () {
//       // Implement navigation to the order details page
//       controller.getOrderDetail(context, currentOrder['id']);
//       debugPrint('Tapped on Order');
//       Get.to(() => const OrderDetailsPage());
//     },
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Order : ${currentOrder['id']}",
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//             Text(
//               currentOrder['date'],
//               style: Theme.of(context).textTheme.headlineSmall,
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Row(
//           children: [
//             Text(
//               "Total: ",
//               style: Theme.of(context).textTheme.headlineSmall,
//             ),
//             Text(
//               "${currentOrder['amount']} ${isArabic ? currencyCodeAr : currencyCodeEng}",
//               style: Theme.of(context).textTheme.headlineLarge,
//             ),
//           ],
//         ),
//         const SizedBox(height: 5),
//         Row(
//           children: [
//             Text(
//               "Status: ",
//               style: Theme.of(context).textTheme.headlineSmall,
//             ),
//             Expanded(
//               child: Text(
//                 status,
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//             ),
//             const Icon(Icons.chevron_right)
//           ],
//         ),
//       ],
//     ),
//   );
// }
