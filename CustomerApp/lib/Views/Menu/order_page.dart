import 'package:dorTodor24/Helper/common_app_bar.dart';
import 'package:dorTodor24/Helper/common_card.dart';
import 'package:dorTodor24/Helper/string.dart';
import 'package:dorTodor24/Views/Menu/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      title: 'My Orders',
      actionEnable: false,
      child: ListView.builder(
        itemCount: 5,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return orderItemCard(
            context,
            'Order #${index + 1}',
            '15 May 2022 12:22 AM',
            index,
            () {
              // Implement navigation to the order details page
              debugPrint('Tapped on Order #${index + 1}');
              Get.to(() => const OrderDetailsPage());
            },
          );
        },
      ),
    );
  }

  Widget orderItemCard(context, orderNumber, date, status, onTap) {
    status = status % 2 == 0 ? 'Shipped' : 'Processing';
    return CommonCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(12, 15, 12, 12),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderNumber,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                date,
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
                "234 $currencyCode",
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
              const Icon(Icons.chevron_right,)
            ],
          ),
        ],
      ),
    );
  }
}
