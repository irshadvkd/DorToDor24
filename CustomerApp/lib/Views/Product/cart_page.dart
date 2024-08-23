import 'package:dorTodor24/Controllers/Product/product_controller.dart';
import 'package:dorTodor24/Helper/common_app_bar.dart';
import 'package:dorTodor24/Helper/common_button.dart';
import 'package:dorTodor24/Helper/common_image.dart';
import 'package:dorTodor24/Helper/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/colors.dart';
import '../../Helper/common_card.dart';
import '../Billing/order_confirm_page.dart';

class CartPage extends GetView<ProductController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        return CommonAppBar(
          actionEnable: false,
          title: 'Cart',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.cartItems.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    return cartCard(context, controller.cartItems[index]);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(color: colors.textMain),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            "315 $currencyCode",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: colors.textMain),
                          ),
                        ],
                      ),
                    ),
                    CommonButton(
                      width: 220,
                      color: colors.themeButton,
                      text: "Proceed to Checkout",
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: colors.white, fontWeight: FontWeight.w600),
                      onTap: () {
                        Get.to(() => OrderConfirmPage());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget cartCard(context, currentIndex) {
    return CommonCard(
      boxShadowEnable: true,
      borderRadius: 12,
      margin: const EdgeInsets.only(bottom: 16),
      child:
          // Stack(
          //   children: [
          Row(
        children: [
          CommonCard(
            color: colors.cardBg,
            boxShadowEnable: false,
            margin: const EdgeInsets.fromLTRB(8, 8, 16, 8),
            width: 120,
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: CommonImage(
                url: currentIndex['image'],
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              Get.locale!.languageCode == "en"
                                  ? currentIndex['nameEng']
                                  : currentIndex['nameAr'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(color: colors.textMain),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 30),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            "Price",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: colors.textMain),
                          ),
                          const Text("  :  "),
                          Text(
                            "${currentIndex['price']} $currencyCode",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: colors.textMain),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Total",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${(double.parse(currentIndex['price']) * currentIndex['proQty']).toStringAsFixed(2)} $currencyCode",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: SizedBox(
                    // width: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (currentIndex['proQty'] > 0)
                          CommonCard(
                            color: colors.themeButton,
                            onTap: () {
                              if (currentIndex['proQty'] > 1) {
                                controller.updateCart(
                                  context,
                                  currentIndex['id'],
                                  currentIndex['proQty'] - 1,
                                );
                                controller.update();
                              } else {
                                controller.deleteCart(
                                  context,
                                  currentIndex['id'],
                                );
                              }
                            },
                            padding: const EdgeInsets.all(3),
                            child: const Icon(
                              Icons.remove,
                              color: colors.white,
                            ),
                          ),
                        const SizedBox(height: 6),
                        if (currentIndex['proQty'] > 0)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              "${currentIndex['proQty']}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: colors.textMain),
                            ),
                          ),
                        const SizedBox(height: 6),
                        CommonCard(
                          color: colors.themeButton,
                          onTap: () {
                            controller.updateCart(
                              context,
                              currentIndex['id'],
                              currentIndex['proQty'] + 1,
                            );
                            controller.update();
                          },
                          padding: const EdgeInsets.all(3),
                          child: const Icon(
                            Icons.add,
                            color: colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      // Positioned(
      //   right: 5,
      //   child: GestureDetector(
      //     onTap: () {
      //       debugPrint("delete");
      //     },
      //     child: const Padding(
      //       padding: EdgeInsets.all(6),
      //       child: Icon(Icons.close, size: 24),
      //     ),
      //   ),
      // ),
      // ],
      // ),
    );
  }
}
