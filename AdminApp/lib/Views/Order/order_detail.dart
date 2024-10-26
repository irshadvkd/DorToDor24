import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/Order/order_controller.dart';
import '../../Helper/colors.dart';
import '../../Helper/common_app_bar.dart';
import 'order_item_card.dart';

class OrderDetailsPage extends GetView<OrderController> {
  OrderDetailsPage({super.key});

  final ScrollController _scrollController = ScrollController();
  final String currencyCode = 'KWD'; // Define the currency code here

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      init: OrderController(),
      builder: (controller) {
        if (controller.orderDetailLoader) {
          return const Center(child: CircularProgressIndicator());
        }

        final orderData = controller.detailsData.isNotEmpty
            ? controller.detailsData[0]
            : null;
        final totalAmount = controller.detailsProducts.fold<double>(
          0,
              (sum, product) => sum +
              (double.tryParse(product.proPrice ?? '0')! *
                  (product.proQty ?? 0)),
        );

        return CommonAppBar(
          title: 'Order Details',
          actionEnable: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (orderData != null) ...[
                  Text('Order ${orderData.id}',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text("Date: ",
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text(
                        // Convert createdAt to DateTime and format it
                        DateTime.tryParse(orderData.createdAt ?? '')
                            ?.toLocal()
                            .toString()
                            .split(' ')[0] ??
                            'N/A',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text("Total: ",
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text(
                        "${orderData.amount} $currencyCode",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text("Status: ",
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text(
                        getOrderStatus(orderData.status!),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Items: ${controller.detailsProducts.length}',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8.0),

                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 4),
                          blurRadius: 8,
                          spreadRadius: -4,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: _scrollController,
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.only(right: 12.0),
                        itemCount: controller.mappedOrderDetailsProducts.length,
                        itemBuilder: (context, index) {
                          return OrderItemCard(
                            currentIndex: controller.mappedOrderDetailsProducts[index],
                            orderId: '${orderData.id}',
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Text('Total Amount : ',
                          style: Theme.of(context).textTheme.titleSmall),
                      Text(
                        '${totalAmount.toStringAsFixed(3)} $currencyCode',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),

                  GestureDetector(
                    onTap: controller.toggleExpansion,
                    child: Row(
                      children: [
                        Text('Shipping Address',
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(width: 8),
                        Obx(() => Icon(
                          controller.isExpanded.value
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          color: Colors.black54,
                        )),
                      ],
                    ),
                  ),

                  Obx(() {
                    return controller.isExpanded.value
                        ? Column(
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.person,
                                      color: colors.themeButton),
                                  const SizedBox(width: 8),
                                  Text(
                                    orderData.userName ?? 'Unknown User',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      color: colors.themeButton),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      orderData.address ??
                                          'No Address Provided',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(height: 1.5),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ],
                    )
                        : const SizedBox.shrink();
                  }),
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
}
