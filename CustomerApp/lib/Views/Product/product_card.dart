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
  const ProductCard({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        return CommonCard(
          boxShadowEnable: false,
          onTap: () {
            Get.to(() => ProductDetailPage(currentIndex: currentIndex));
          },
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 5 / 3,
                child: CommonImage(
                  url: currentIndex['image'],
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                bottom: 20,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Get.locale!.languageCode == "en"
                          ? currentIndex['nameEng']
                          : currentIndex['nameAr'],
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: colors.textMain),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Text(
                    //   'subtext',
                    //   style: Theme.of(context).textTheme.titleSmall!.copyWith(color: colors.textMain,fontSize: 8),
                    //   textAlign: TextAlign.center,
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    const SizedBox(height: 5),
                    Text(
                      "${currentIndex['price']} $currencyCode",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 12, color: colors.primary),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (currentIndex['qty'] > 0)
                      CommonCard(
                        color: colors.themeButton,
                        onTap: () async {
                          if (currentIndex['qty'] > 1) {
                            await controller.updateCart(
                              context,
                              currentIndex['cartId'],
                              currentIndex['qty'] - 1,
                            );
                            currentIndex['qty'] = currentIndex['qty'] - 1;
                            controller.update();
                          } else {
                            await controller.deleteCart(
                              context,
                              currentIndex['cartId'],
                            );
                            currentIndex['qty'] = currentIndex['qty'] - 1;
                          }
                        },
                        padding: const EdgeInsets.all(3),
                        child: const Icon(
                          Icons.remove,
                          color: colors.white,
                        ),
                      ),
                    const SizedBox(height: 4),
                    if (currentIndex['qty'] > 0)
                      CommonCard(
                        height: 30,
                        width: 30,
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
                    const SizedBox(height: 4),
                    CommonCard(
                      color: colors.themeButton,
                      onTap: () async {
                        if (currentIndex['qty'] == 0) {
                          await controller.addToCart(
                            context,
                            currentIndex['id'],
                            currentIndex['qty'] + 1,
                          );
                          currentIndex['qty'] = currentIndex['qty'] + 1;
                        } else {
                          await controller.updateCart(
                            context,
                            currentIndex['cartId'],
                            currentIndex['qty'] + 1,
                          );
                          currentIndex['qty'] = currentIndex['qty'] + 1;
                        }
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
            ],
          ),
        );
      },
    );
  }
}