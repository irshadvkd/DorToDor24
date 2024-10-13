import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:dortodorpartner/Controllers/Product/product_controller.dart';
import 'package:dortodorpartner/Controllers/SubCategory/sub_category_controller.dart';
import 'package:dortodorpartner/Helper/colors.dart';
import 'package:dortodorpartner/Helper/common_alert_confirm.dart';
import 'package:dortodorpartner/Helper/common_app_bar.dart';
import 'package:dortodorpartner/Helper/common_button.dart';
import 'package:dortodorpartner/Helper/common_card.dart';
import 'package:dortodorpartner/Helper/common_image.dart';
import 'package:dortodorpartner/Helper/common_text_field.dart';
import 'package:dortodorpartner/Views/Product/product_page.dart';
import 'package:dortodorpartner/Views/SubCategory/sub_category_add_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoryPage extends GetView<SubCategoryController> {
  final int categoryId;
  final String title;
  const SubCategoryPage({
    Key? key,
    required this.categoryId,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubCategoryController>(
      builder: (controller) {
        return CommonAppBar(
          title: title,
          child: RefreshIndicator(
            onRefresh: () async =>
                controller.getSubCategory(context, categoryId),
            child: controller.subCategoryLoader
                ? Column(
                    children: [
                      /// Search and Create Section
                      searchAndCreateUI(context),

                      ///Category Section UI
                      Expanded(
                        child: GridView.builder(
                          itemCount: controller.subCategory.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1,
                          ),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, index) {
                            return subCategoryCard(
                              context,
                              controller.subCategory[index],
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget searchAndCreateUI(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: Row(
        children: [
          Expanded(
            child: CommonTextField(
              hintText: "searchSubCategory".tr,
              textController: controller.search,
              maxLines: 1,
              onChange: (value) {
                controller.addSubCategoryToList();
              },
            ),
          ),
          const SizedBox(width: 15),
          CommonButton(
            text: 'add'.tr,
            width: 100,
            onTap: () {
              controller.clearFormFields();
              Get.to(() => SubCategoryAddPage(
                    action: 'create',
                    categoryId: categoryId,
                  ));
            },
          ),
        ],
      ),
    );
  }

  Widget subCategoryCard(context, currentIndex) {
    bool isArabic = Get.locale == const Locale('ar', 'KW') ? true : false;
    return CommonCard(
      color: colors.cardBg,
      boxShadowEnable: false,
      onTap: () {
        final productController = Get.put(ProductController());
        productController.getProduct(context, categoryId, currentIndex['id']);
        Get.to(() => ProductPage(
              title:
                  isArabic ? currentIndex['nameAr'] : currentIndex['nameEng'],
              categoryId: categoryId,
              subCategoryId: currentIndex['id'],
            ));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 16 / 13,
                child: CommonImage(url: currentIndex['image']),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    isArabic ? currentIndex['nameAr'] : currentIndex['nameEng'],
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: colors.primary),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: colors.cardBg,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: moreMenu(context, currentIndex),
            ),
          ),
        ],
      ),
    );
  }

  Widget moreMenu(context, currentIndex) {
    return PopupMenuButton(
      color: colors.cardBg,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      icon: const Icon(
        Icons.more_vert,
        color: colors.primary,
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
          Get.to(() => SubCategoryAddPage(
                action: "edit",
                url: currentIndex['image'] ?? "",
                categoryId: categoryId,
                subCategoryId: currentIndex['id'],
              ));
        }
        if (value == 2) {
          final homeController = Get.put(HomeController());
          homeController.buttonLoader = true;
          homeController.update();
          Get.dialog(
            CommonAlertConfirm(
              msg: "deleteMessage".tr,
              onTap: () {
                controller.deleteSubCategory(context, currentIndex['id']);
              },
            ),
          );
        }
      },
    );
  }
}
