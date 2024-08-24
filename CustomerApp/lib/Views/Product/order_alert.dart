import 'package:dorTodor24/Controllers/Product/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:dorTodor24/Helper/colors.dart';
import 'package:get/get.dart';

class OrderAlert extends GetView<ProductController> {
  final String storeId;
  const OrderAlert({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        return PopScope(
          canPop: false,
          child: Center(
            child: Container(
              width: 300,
              height: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colors.white,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Container()),
                  Text(
                    "Confirm Order",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Are you sure you want to proceed with the order? Please review your details to ensure everything is correct before confirming.",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: colors.black, height: 1.4),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (controller.orderLoader) {
                              controller.confirmOrder(context, storeId);
                            }
                          },
                          child: Container(
                            height: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: colors.grey.withOpacity(.1), width: 1),
                            ),
                            child: controller.orderLoader
                                ? Text(
                                    'CONFIRM',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(color: colors.primary),
                                  )
                                : const CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (controller.orderLoader) {
                              Get.back();
                            }
                          },
                          child: Container(
                            height: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: colors.grey.withOpacity(.1), width: 1),
                            ),
                            child: Text(
                              'CANCEL',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(color: colors.secondary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
