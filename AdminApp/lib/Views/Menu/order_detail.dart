import 'package:dortodorpartner/Controllers/Order/order_controller.dart';
import 'package:dortodorpartner/Helper/colors.dart';
import 'package:dortodorpartner/Helper/common_app_bar.dart';
import 'package:dortodorpartner/Helper/session.dart';
import 'package:dortodorpartner/Helper/string.dart';
import 'package:dortodorpartner/Modals/Order/order_detail_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends GetView<OrderController> {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isArabic = Get.locale == const Locale('ar', 'KW') ? true : false;
    return GetBuilder<OrderController>(
      builder: (controller) {
        return CommonAppBar(
          title: 'Order Detail',
          actionEnable: false,
          child: controller.orderDetailLoader
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${controller.orderDetailModal!.data!.id}',
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
                            convertStringTime(
                                "dd MMM yyyy hh:mm a",
                                "yyyy-MM-ddThh:mm",
                                controller.orderDetailModal!.data!.createdAt),
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
                            "${controller.orderDetailModal!.data!.amount} ${isArabic ? currencyCodeAr : currencyCodeEng}",
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
                            controller.orderDetailModal!.data!.status == 0
                                ? 'Pending'
                                : controller.orderDetailModal!.data!.status == 1
                                    ? 'Processing'
                                    : controller.orderDetailModal!.data!
                                                .status ==
                                            2
                                        ? "Shipped"
                                        : controller.orderDetailModal!.data!
                                                    .status ==
                                                3
                                            ? "Delivered"
                                            : controller.orderDetailModal!.data!
                                                        .status ==
                                                    4
                                                ? "Cancelled"
                                                : "",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Items',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      for (var item in controller.orderDetailModal!.products!)
                        orderItemCard(context, item),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'Total Amount: ',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            '${double.parse(controller.orderDetailModal!.data!.amount!).toStringAsFixed(3)} ${isArabic ? currencyCodeAr : currencyCodeEng}',
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
                        "${controller.orderDetailModal!.data!.address}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(height: 1.5),
                      ),
                      Text(
                        "Contact: ${controller.orderDetailModal!.data!.contact}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(height: 1.5),
                      ),
                    ],
                  ),
                )
              : const Center(child: CupertinoActivityIndicator()),
        );
      },
    );
  }

  Widget orderItemCard(context, Products currentProduct) {
    bool isArabic = Get.locale == const Locale('ar', 'KW') ? true : false;
    return ListTile(
      title: Text(
        isArabic ? currentProduct.nameAr ?? "" : currentProduct.nameEng ?? "",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        'Qty: ${currentProduct.proQty} ${isArabic ? currentProduct.unitAr : currentProduct.unitEng} \nPrice: ${currentProduct.proPrice} ${isArabic ? currencyCodeAr : currencyCodeEng}',
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(color: colors.fontColor.withOpacity(.6)),
      ),
      trailing: Text(
        '${(currentProduct.proQty! * double.parse(currentProduct.proPrice!)).toStringAsFixed(3)}\n${isArabic ? currencyCodeAr : currencyCodeEng}',
        style: Theme.of(context).textTheme.headlineLarge,
        textAlign: TextAlign.end,
      ),
    );
  }
}
