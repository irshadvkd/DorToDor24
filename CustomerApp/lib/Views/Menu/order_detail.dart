import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Helper/common_app_bar.dart';
import 'package:dorTodor24/Helper/string.dart';
import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      title: 'Order Detail',
      actionEnable: false,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order #12345',
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
                  "23 May 2023 12:22 AM",
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
                  "234 $currencyCode",
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
                  "Shipped",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Items',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            orderItemCard(context, 'Product A', 2, 25),
            orderItemCard(context, 'Product B', 1, 30),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Total Amount: ',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  '80 $currencyCode',
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
              'John Doe\n123 Main Street\nCityville, KUWAIT',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderItemCard(context, name, quantity, price) {
    return ListTile(
      title: Text(
        name,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        'Quantity: $quantity',
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(color: colors.fontColor.withOpacity(.6)),
      ),
      trailing: Text(
        '${(quantity * price).toStringAsFixed(2)} $currencyCode',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
