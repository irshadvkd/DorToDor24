import 'package:dorTodor24/Controllers/Product/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dorTodor24/Controllers/Home/home_controller.dart';
import 'package:dorTodor24/Helper/colors.dart';

import '../Views/Product/cart_page.dart';

class CommonAppBar extends StatelessWidget {
  final String title;
  final bool? actionEnable;
  final Widget child;
  const CommonAppBar({
    Key? key,
    required this.title,
    this.actionEnable,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: colors.white,
          appBar: AppBar(
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 17,
                color: colors.textMain,
              ),
            ),
            centerTitle: true,
            title: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: colors.textMain),
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
                            // controller.getNotification(context);
                            // Get.offAndToNamed("/home");
                            var productController = Get.put(ProductController());
                            productController.getCart(context);
                            Get.to(() => const CartPage());
                            controller.currentPage = 1;
                            controller.update();
                          },
                        ),
                      ],
                    ),
                  ]
                : null,
            backgroundColor: colors.white,
          ),
          body: child,
        );
      },
    );
  }
}
