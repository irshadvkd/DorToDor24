import 'package:dortodorpartner/Controllers/Category/category_controller.dart';
import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:dortodorpartner/Controllers/SubCategory/sub_category_controller.dart';
import 'package:dortodorpartner/Helper/colors.dart';
import 'package:dortodorpartner/Helper/common_alert_confirm.dart';
import 'package:dortodorpartner/Helper/common_app_bar.dart';
import 'package:dortodorpartner/Helper/common_button.dart';
import 'package:dortodorpartner/Helper/common_card.dart';
import 'package:dortodorpartner/Helper/common_image.dart';
import 'package:dortodorpartner/Helper/common_text_field.dart';
import 'package:dortodorpartner/Views/Category/category_add_page.dart';
import 'package:dortodorpartner/Views/SubCategory/sub_category_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryPage extends GetView<CategoryController> {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (controller) {
        return CommonAppBar(
          title: 'category'.tr,
          child: RefreshIndicator(
            onRefresh: () async => controller.getCategory(context),
            child: controller.categoryLoader
                ? Column(
                    children: [
                      /// Search and Create Section
                      searchAndCreateUI(context),

                      ///Category Section UI
                      Expanded(
                        child: GridView.builder(
                          itemCount: controller.category.length,
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
                            return categoryCard(
                                context, controller.category[index]);
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
              hintText: 'searchCategory'.tr,
              textController: controller.search,
              maxLines: 1,
              onChange: (value) {
                controller.addCategoryToList();
              },
            ),
          ),
          const SizedBox(width: 15),
          CommonButton(
            text: 'add'.tr,
            width: 100,
            onTap: () {
              controller.clearFormFields();
              Get.to(() => CategoryAddPage(action: 'create'));
            },
          ),
        ],
      ),
    );
  }

  Widget categoryCard(context, currentIndex) {
    bool isArabic = Get.locale == const Locale('ar', 'KW') ? true : false;
    return CommonCard(
      color: colors.cardBg,
      boxShadowEnable: false,
      onTap: () {
        final productController = Get.put(SubCategoryController());
        productController.getSubCategory(context, currentIndex['id']);
        Get.to(() => SubCategoryPage(
              categoryId: currentIndex['id'],
              title:
                  isArabic ? currentIndex['nameAr'] : currentIndex['nameEng'],
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
          Get.to(() => CategoryAddPage(
                action: "edit",
                url: currentIndex['image'] ?? "",
                categoryId: currentIndex['id'],
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
                controller.deleteCategory(context, currentIndex['id']);
              },
            ),
          );
        }
      },
    );
  }
}
