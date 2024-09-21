import 'package:dorTodor24/Controllers/Cart/cart_controller.dart';
import 'package:dorTodor24/Controllers/Product/product_controller.dart';
import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Helper/common_card.dart';
import 'package:dorTodor24/Helper/common_image.dart';
import 'package:dorTodor24/Helper/string.dart';
import 'package:dorTodor24/Views/Product/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends GetView<ProductController> {
  final Map currentIndex;
  final String subCatId;
  const ProductCard({
    super.key,
    required this.currentIndex,
    required this.subCatId,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        return CommonCard(
          // color: colors.grey,
          boxShadowEnable: false,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => ProductDetailPage(currentIndex: currentIndex));
                },
                child: AspectRatio(
                  aspectRatio: 5 / 3,
                  child: CommonImage(
                    url: currentIndex['image'],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  // color: colors.grey,
                  child: Row(
                    children: [
                      CommonCard(
                        color: colors.themeButton,
                        onTap: () async {
                          if (currentIndex['qty'] == 0) {
                            // await controller.addToCart(
                            //   context,
                            //   currentIndex['id'],
                            //   currentIndex['qty'] + 1,
                            //   subCatId,
                            // );
                            final cartController = Get.put(CartController());
                            int cartId = cartController.generateCartId();
                            var data = cartController.mapToData(currentIndex);
                            data.proQty = currentIndex['qty'] + 1;
                            data.id = cartId;
                            data.productId = int.parse(currentIndex['id']);
                            cartController.addToCart(
                                context, data, subCatId, false);
                          } else {
                            // await controller.updateCart(
                            //   context,
                            //   currentIndex['cartId'],
                            //   currentIndex['qty'] + 1,
                            //   false,
                            //   subCatId,
                            // );
                            final cartController = Get.put(CartController());
                            var data = cartController.mapToData(currentIndex);
                            data.proQty = currentIndex['qty'] + 1;
                            data.productId = int.parse(currentIndex['id']);
                            cartController.addToCart(
                                context, data, subCatId, false);
                          }
                          controller.update();
                        },
                        padding: const EdgeInsets.all(3),
                        child: const Icon(
                          Icons.add,
                          color: colors.white,
                        ),
                      ),
                      const SizedBox(width: 5),
                      if (currentIndex['qty'] > 0)
                        CommonCard(
                          height: 30,
                          width: 70,
                          color: colors.themeButton,
                          child: Center(
                            child: Text(
                              "${currentIndex['qty']}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: colors.white),
                            ),
                          ),
                        ),
                      const SizedBox(width: 5),
                      if (currentIndex['qty'] > 0)
                        CommonCard(
                          color: colors.themeButton,
                          onTap: () async {
                            if (currentIndex['qty'] > 1) {
                              // await controller.updateCart(
                              //   context,
                              //   currentIndex['cartId'],
                              //   currentIndex['qty'] - 1,
                              //   false,
                              //   subCatId,
                              // );
                              final cartController = Get.put(CartController());
                              var data = cartController.mapToData(currentIndex);
                              data.proQty = currentIndex['qty'] - 1;
                              data.productId = int.parse(currentIndex['id']);
                              cartController.addToCart(
                                  context, data, subCatId, false);
                              controller.update();
                            } else {
                              // await controller.deleteCart(
                              //   context,
                              //   currentIndex['cartId'],
                              //   false,
                              //   subCatId,
                              // );
                              final cartController = Get.put(CartController());
                              cartController.removeFromCart(
                                  context,
                                  int.parse(currentIndex['cartId']),
                                  subCatId,
                                  false);
                            }
                          },
                          padding: const EdgeInsets.all(3),
                          child: const Icon(
                            Icons.remove,
                            color: colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                left: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 10),
                  color: colors.white.withOpacity(0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Get.locale!.languageCode == "en"
                            ? currentIndex['nameEng']
                            : currentIndex['nameAr'],
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: colors.textMain),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${currentIndex['price']} $currencyCode",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: colors.green),
                      ),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 5,
              //   right: 5,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       if (currentIndex['qty'] > 0)
              //         CommonCard(
              //           color: colors.themeButton,
              //           onTap: () async {
              //             if (currentIndex['qty'] > 1) {
              //               await controller.updateCart(
              //                 context,
              //                 currentIndex['cartId'],
              //                 currentIndex['qty'] - 1,
              //                 false,
              //                 subCatId,
              //               );
              //               // currentIndex['qty'] = currentIndex['qty'] - 1;
              //               controller.update();
              //             } else {
              //               await controller.deleteCart(
              //                 context,
              //                 currentIndex['cartId'],
              //                 false,
              //                 subCatId,
              //               );
              //               // currentIndex['qty'] = currentIndex['qty'] - 1;
              //             }
              //           },
              //           padding: const EdgeInsets.all(3),
              //           child: const Icon(
              //             Icons.remove,
              //             color: colors.white,
              //           ),
              //         ),
              //       const SizedBox(height: 4),
              //       if (currentIndex['qty'] > 0)
              //         CommonCard(
              //           height: 30,
              //           width: 40,
              //           color: colors.themeButton,
              //           child: Center(
              //             child: Text(
              //               "${currentIndex['qty']}",
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .titleLarge!
              //                   .copyWith(color: colors.white),
              //             ),
              //           ),
              //         ),
              //       const SizedBox(height: 4),
              //       CommonCard(
              //         color: colors.themeButton,
              //         onTap: () async {
              //           if (currentIndex['qty'] == 0) {
              //             await controller.addToCart(
              //               context,
              //               currentIndex['id'],
              //               currentIndex['qty'] + 1,
              //               subCatId,
              //             );
              //           } else {
              //             await controller.updateCart(
              //               context,
              //               currentIndex['cartId'],
              //               currentIndex['qty'] + 1,
              //               false,
              //               subCatId,
              //             );
              //             // currentIndex['qty'] = currentIndex['qty'] + 1;
              //           }
              //           controller.update();
              //         },
              //         padding: const EdgeInsets.all(3),
              //         child: const Icon(
              //           Icons.add,
              //           color: colors.white,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
