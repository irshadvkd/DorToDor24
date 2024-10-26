import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Helper/common_app_bar.dart';
import 'package:dorTodor24/Helper/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/Menu/order_controller.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  bool _isExpanded = false; // State variable for expansion

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

        return CommonAppBar(
          title: 'Order Details',
          actionEnable: false,
          child: SingleChildScrollView( // Wrap with SingleChildScrollView
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (orderData != null) ...[
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
                        "${orderData.createdAt?.toLocal().toString().split(' ')[0]} ${orderData.createdAt?.hour}:${orderData.createdAt?.minute}",
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
                    'Items: ${controller.detailsProducts.length}', // Display total number of items
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8.0),

                  // Use a ListView to allow scrolling for items
                  Container(
                    height: 400, // Fixed height for the list to prevent overflow
                    decoration: BoxDecoration(
                      color: Colors.grey[50], // Background color
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          offset: const Offset(0, 4), // Shadow offset
                          blurRadius: 8, // Shadow blur radius
                          spreadRadius: -4, // Negative spread to create a pressed effect
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        // ListView.builder positioned inside the container
                        ScrollbarTheme(
                          data: ScrollbarThemeData(
                            thumbColor: WidgetStateProperty.all(Colors.blueAccent),
                            thickness: WidgetStateProperty.all(6.0),
                            radius: const Radius.circular(8),
                          ),
                          child: Scrollbar(
                            thumbVisibility: true,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(right: 12.0),
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: controller.detailsProducts.length,
                              itemBuilder: (context, index) {
                                final product = controller.detailsProducts[index];
                                return orderItemCard(
                                  context,
                                  product.nameEng ?? 'Unknown',
                                  product.proQty ?? 0,
                                  double.tryParse(product.proPrice ?? '0') ?? 0,
                                  product.image ?? '',
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Text(
                        'Total Amount : ',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        '${totalAmount.toStringAsFixed(3)} $currencyCode',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded; // Toggle the expansion state
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          'Shipping Address',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                  if (_isExpanded) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16.0), // Padding around the address
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12), // Rounded corners
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.person, color: colors.themeButton), // User icon
                              const SizedBox(width: 8),
                              Text(
                                orderData.userName ?? 'Unknown User',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Row(
                          //   children: [
                          //     const Icon(Icons.phone, color: Colors.blueAccent), // Phone icon
                          //     const SizedBox(width: 8),
                          //     Text(
                          //       orderData.phoneNumber ?? 'No Phone Number Provided',
                          //       style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.5),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(height: 8),
                          // Row(
                          //   children: [
                          //     const Icon(Icons.email, color: Colors.blueAccent), // Email icon
                          //     const SizedBox(width: 8),
                          //     Text(
                          //       orderData.email ?? 'No Email Provided',
                          //       style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.5),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: colors.themeButton), // Location icon
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  orderData.address ?? 'No Address Provided',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.5),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Row(
                          //   children: [
                          //     const Icon(Icons.note, color: Colors.blueAccent), // Note icon
                          //     const SizedBox(width: 8),
                          //     Text(
                          //       orderData.deliveryInstructions ?? 'No Delivery Instructions',
                          //       style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.5),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                  _isExpanded ? const SizedBox(height: 30) : const SizedBox(height: 30),
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
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 40),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                Text(
                  'Quantity: $quantity',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: colors.fontColor.withOpacity(.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${(quantity * price).toStringAsFixed(2)} $currencyCode',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
