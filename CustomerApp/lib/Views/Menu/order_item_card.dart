import 'package:dorTodor24/Controllers/Menu/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../Helper/colors.dart';
import '../../Helper/common_image.dart';
import '../../Helper/string.dart';
import '../../Modals/Product/order_details_model.dart';

class OrderItemCard extends GetView<OrderController> {
  // final Product product;
  final Map<String, dynamic> currentIndex;
  final String orderId;

  const OrderItemCard({
    super.key,
    // required this.product,
    required this.currentIndex,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    const String baseUrl = "https://dorTodor24.com/api";
    // final String imageUrl = "$baseUrl${product.image}";
    // final String? imageUrl = product.image;
    // final String name = product.nameEng ?? 'Unknown Product';
    // final int quantity = product.proQty ?? 0;
    // final double price = double.tryParse(product.proPrice ?? '0') ?? 0.0;

    final String imageUrl = "https://dorTodor24.com/api${currentIndex['image']}";
    final String name = currentIndex['nameEng'] ?? 'Unknown Product';
    final int quantity = currentIndex['proQty'] ?? 0;
    final double price = double.tryParse(currentIndex['proPrice'] ?? '0') ?? 0.0;

    return GetBuilder<OrderController>(
      builder: (controller) {
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
                // child: Image.network(
                //   imageUrl!,
                //   width: 80,
                //   height: 80,
                //   fit: BoxFit.cover,
                //   errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 40),
                // ),
                child: CommonImage(
                  url: imageUrl,  // Using CommonImage with Map-based URL
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
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
      },
    );
  }
}
