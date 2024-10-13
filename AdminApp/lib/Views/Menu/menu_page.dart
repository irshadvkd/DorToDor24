import 'package:dortodorpartner/Controllers/Banner/banner_controller.dart';
import 'package:dortodorpartner/Controllers/Category/category_controller.dart';
import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:dortodorpartner/Controllers/Location/location_controller.dart';
import 'package:dortodorpartner/Controllers/Product/product_controller.dart';
import 'package:dortodorpartner/Controllers/Store/store_controller.dart';
import 'package:dortodorpartner/Helper/common_card.dart';
import 'package:dortodorpartner/Views/Banner/banner_page.dart';
import 'package:dortodorpartner/Views/Category/category_page.dart';
import 'package:dortodorpartner/Views/Location/governorate_page.dart';
import 'package:dortodorpartner/Views/Menu/contact_us.dart';
import 'package:dortodorpartner/Views/Menu/terms_and_policy.dart';
import 'package:dortodorpartner/Views/Product/product_management.dart';
import 'package:dortodorpartner/Views/Stores/store_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuPage extends GetView<HomeController> {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if(controller.isAdmin)
                commonMenuItem(
                  context,
                  Icons.image,
                  "banner".tr,
                  () {
                    final bannerController = Get.put(BannerController());
                    bannerController.getBanner(context);
                    Get.to(() => const BannerPage());
                  },
                ),
                if(controller.isAdmin)
                commonMenuItem(
                  context,
                  Icons.shopping_bag,
                  "product".tr,
                  () {
                    final categoryController = Get.put(CategoryController());
                    categoryController.getCategory(context);
                    Get.to(() => const CategoryPage());
                  },
                ),
                if(controller.isAdmin)
                commonMenuItem(
                  context,
                  Icons.location_on,
                  "location".tr,
                  () {
                    final locationController = Get.put(LocationController());
                    locationController.getGovernorate(context);
                    Get.to(() => const GovernoratePage());
                  },
                ),
                if(controller.isAdmin)
                commonMenuItem(
                  context,
                  Icons.store,
                  "Store",
                  () {
                    final storeController = Get.put(StoreController());
                    storeController.getStore(context);
                    storeController.getLocation(context);
                    Get.to(() => const StorePage());
                  },
                ),
                if(controller.isAdmin == false)
                  commonMenuItem(
                    context,
                    Icons.shopping_bag,
                    "Product",
                        () {
                      final productController = Get.put(ProductController());
                      productController.getAllProduct(context);
                      Get.to(() => const ProductManagement());
                    },
                  ),
                commonMenuItem(
                  context,
                  Icons.policy,
                  "termsPolicy".tr,
                  () {
                    Get.to(() => const TermsAndPolicyPage());
                  },
                ),
                commonMenuItem(
                  context,
                  Icons.support_agent,
                  "contactUs".tr,
                  () {
                    Get.to(() => const ContactPage());
                  },
                ),
                commonMenuItem(
                  context,
                  Icons.language,
                  Get.locale == const Locale('en', 'US')
                      ? 'arabic'.tr
                      : 'english'.tr,
                  () async {
                    controller.currentPage = 0;
                    controller.update();
                    if (Get.locale == const Locale('en', 'US')) {
                      await Get.updateLocale(const Locale("ar", 'KW'));
                    } else if (Get.locale == const Locale('ar', 'KW')) {
                      await Get.updateLocale(const Locale("en", 'US'));
                    }
                  },
                ),
                commonMenuItem(
                  context,
                  Icons.logout,
                  "logout".tr,
                  () {
                    Get.offAllNamed("/login");
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  commonMenuItem(context, icon, text, onTap) {
    bool isArabic = Get.locale == const Locale('ar', 'KW') ? true : false;
    return CommonCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      onTap: onTap,
      child: Row(
        children: [
          CommonCard(
            margin: EdgeInsets.only(
              right: isArabic ? 0 : 16,
              left: isArabic ? 16 : 0,
            ),
            padding: const EdgeInsets.all(8),
            borderRadius: 7,
            child: Icon(icon),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
