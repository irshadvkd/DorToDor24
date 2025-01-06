import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Helper/common_app_bar.dart';
import 'package:dorTodor24/Helper/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Controllers/Menu/order_controller.dart';

class OrderDetailsPage extends GetView<OrderController> {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      init: OrderController(),
      builder: (controller) {
        // Display a loading indicator while fetching order details
        if (controller.detailsLoader) {
          return const Center(child: CircularProgressIndicator());
        }
        // Get the first order detail if available
        final orderData = controller.detailsData.isNotEmpty
            ? controller.detailsData[0]
            : null;
        // Calculate total amount from product list
        final totalAmount = controller.detailsProducts.fold<double>(
            0,
            (sum, product) =>
                sum +
                (double.tryParse(product.proPrice ?? '0')! *
                    (product.proQty ?? 0)));

        // Parse the value to a DateTime object
        DateTime parsedDate = DateTime.parse(orderData!.createdAt.toString().replaceAll(' ', 'T'));

        // Extract and format the date in DD-MM-YY format
        String date = DateFormat('dd-MM-yyyy').format(parsedDate);

        // Extract and format the time in 12-hour format
        String time = DateFormat('hh:mm aa').format(parsedDate);

        print('Date: $date'); // Output: Date: 02-01-25
        print('Time: $time'); // Output: Time: 04:49 PM

        return CommonAppBar(
          title: 'Order Detail',
          actionEnable: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...[
                Text(
                  'Order ${orderData.id}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      "Date: ",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      " $date at $time",
                      style: Theme.of(context).textTheme.headlineMedium,
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
                      "${orderData.amount} $currencyCode",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "Status: ",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      getOrderStatus(orderData.status!),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Items :',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                // Display each product in the order
                ...controller.detailsProducts.map((product) {
                  return orderItemCard(
                    context,
                    product.nameEng ?? 'Unknown',      // Product name
                    product.proQty ?? 0,               // Quantity
                    double.tryParse(product.proPrice ?? '0') ?? 0,  // Price
                    product.image ?? '',               // Image URL
                  );
                }),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Total Amount: ',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      '$totalAmount $currencyCode',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  'Shipping Address',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  '${orderData.userName}\n${orderData.address}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(height: 1.5),
                ),
              ],
              ],
            ),
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

  Widget orderItemCard(BuildContext context, String name, int quantity, double price, String imageUrl) {
    return Container(
      height: 70,
      margin: const EdgeInsets.only(bottom: 12), // Add some spacing between cards
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 250,
              height: 50,
              fit: BoxFit.fitWidth,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error), // Fallback icon
            ),
          ),
          const SizedBox(width: 12), // Space between image and text

          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis, // Handle long names
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                Text(
                  'Quantity: $quantity',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: colors.fontColor.withOpacity(.6),
                  ),
                ),
              ],
            ),
          ),

          // Product Price
          Text(
            '${(quantity * price).toStringAsFixed(2)} $currencyCode',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ],
      ),
    );
  }

}
