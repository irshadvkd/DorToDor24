import 'package:dorTodor24/Controllers/Cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dorTodor24/Controllers/Home/home_controller.dart';
import 'package:dorTodor24/Helper/colors.dart';

import '../Views/Product/cart_page.dart';

class CommonAppBar extends StatelessWidget {
  final String title;
  final bool? actionEnable;
  final Widget child;
  final bool? appBarColor;
  final Color? BarColor;
  const CommonAppBar({
    super.key,
    required this.title,
    this.actionEnable,
    this.appBarColor,
    this.BarColor,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    var cartController = Get.put(CartController());
    return GetBuilder<HomeController>(
      builder: (controller) {
        bool useAppBarColor = appBarColor ?? false;
        return Scaffold(
          backgroundColor: colors.white,
          appBar: AppBar(
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 17,
                color: useAppBarColor ? colors.white : colors.textMain,
              ),
            ),
            centerTitle: true,
            title: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: useAppBarColor ? colors.white : colors.textMain),
            ),
            actions: actionEnable != false
                ? [
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.shopping_cart,
                            color: colors.textMain,
                          ),
                          iconSize: 26,
                          onPressed: () {
                            cartController.loadCartFromSession();
                            Get.to(() => const CartPage(hideAppBar: false));
                            // Get.offAllNamed("/home");
                            // controller.currentPage = 1;
                            controller.update();
                          },
                        ),
                        if (cartController.cartItems.isNotEmpty)
                          Positioned(
                            top: 0,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: colors.secondary,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "${cartController.cartItems.length}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ]
                : null,
            backgroundColor: BarColor ?? colors.white,
          ),
          body: child,
        );
      },
    );
  }
}
