import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:dortodorpartner/Controllers/Product/product_controller.dart';
import 'package:dortodorpartner/Helper/colors.dart';
import 'package:dortodorpartner/Helper/common_alert_confirm.dart';
import 'package:dortodorpartner/Helper/common_card.dart';
import 'package:dortodorpartner/Helper/common_image.dart';
import 'package:dortodorpartner/Helper/session.dart';
import 'package:dortodorpartner/Helper/string.dart';
import 'package:dortodorpartner/Views/Product/product_add_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends GetView<ProductController> {
  final Map currentIndex;
  const ProductCard({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    bool isArabic = Get.locale == const Locale('ar', 'KW') ? true : false;
    return GetBuilder<ProductController>(
      builder: (controller) {
        return CommonCard(
          boxShadowEnable: false,
          onTap: () {
            // Get.to(() => ProductDetailPage(currentIndex: currentIndex));
          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 5 / 3,
                      child: CommonImage(
                        url: currentIndex['image'],
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isArabic
                          ? currentIndex['nameAr']
                          : currentIndex['nameEng'],
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: colors.primary),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          "unit".tr,
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Text(" : "),
                        Text(
                          isArabic
                              ? currentIndex['unitAr']
                              : currentIndex['unitEng'],
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${isArabic ? convertToArabicNumber(currentIndex['price']) : currentIndex['price']} ${isArabic ? currencyCodeAr : currencyCodeEng}",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  alignment: Alignment.center,
                  color: colors.white.withOpacity(.8),
                  child: moreMenu(context, currentIndex),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget moreMenu(context, currentIndex) {
    return PopupMenuButton(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      icon: const Icon(
        Icons.more_vert,
        size: 20,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              const Icon(
                Icons.edit,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                'edit'.tr,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              const Icon(
                Icons.delete,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                'delete'.tr,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
      ],
      onSelected: (int value) {
        if (value == 1) {
          controller.clearFormFields();
          controller.setFormFields(currentIndex);
          Get.to(() => ProductAddPage(
                action: "edit",
                url: currentIndex['image'] ?? "",
                productId: currentIndex['id'],
                categoryId: currentIndex['catId'],
                subCategoryId: currentIndex['subCatId'],
              ));
        }
        if (value == 2) {
          final homeController = Get.put(HomeController());
          homeController.buttonLoader = true;
          homeController.update();
          Get.dialog(
            CommonAlertConfirm(
              msg: "deleteMessage",
              onTap: () {
                controller.deleteProduct(context, currentIndex['catId'],
                    currentIndex['subCatId'], currentIndex['id']);
              },
            ),
          );
        }
      },
    );
  }
}
