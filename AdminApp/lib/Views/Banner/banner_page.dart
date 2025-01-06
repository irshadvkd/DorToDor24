import 'package:dortodorpartner/Controllers/Banner/banner_controller.dart';
import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:dortodorpartner/Helper/colors.dart';
import 'package:dortodorpartner/Helper/common_alert_confirm.dart';
import 'package:dortodorpartner/Helper/common_app_bar.dart';
import 'package:dortodorpartner/Helper/common_button.dart';
import 'package:dortodorpartner/Helper/common_card.dart';
import 'package:dortodorpartner/Helper/common_image.dart';
import 'package:dortodorpartner/Helper/common_text_field.dart';
import 'package:dortodorpartner/Views/Banner/banner_add_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerPage extends GetView<BannerController> {
  const BannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(
      builder: (controller) {
        return CommonAppBar(
          title: 'banner'.tr,
          child: RefreshIndicator(
            onRefresh: () async => controller.getBanner(context),
            child: controller.bannerLoader
                ? Column(
                    children: [
                      /// Search and Create Section
                      searchAndCreateUI(context),

                      ///Banner Section UI
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.banner.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, index) {
                            return bannerCard(
                              context,
                              controller.banner[index],
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
              hintText: 'searchBanner'.tr,
              textController: controller.search,
              maxLines: 1,
              onChange: (value) {
                controller.addBannerToList();
              },
            ),
          ),
          const SizedBox(width: 15),
          CommonButton(
            text: 'add'.tr,
            width: 100,
            onTap: () {
              controller.clearFormFields();
              Get.to(() => BannerAddPage(action: 'create'));
            },
          ),
        ],
      ),
    );
  }

  Widget bannerCard(context, currentIndex) {
    // bool isArabic = Get.locale == const Locale('ar', 'KW') ? true : false;
    return CommonCard(
      color: colors.cardBg,
      boxShadowEnable: false,
      height: (MediaQuery.of(context).size.width - 32) / 3,
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 3,
                child: CommonImage(url: currentIndex['image']),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  decoration: const BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    currentIndex['name'],
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: colors.white),
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
          Get.to(() => BannerAddPage(
                action: "edit",
                url: currentIndex['image'] ?? "",
                bannerId: currentIndex['id'],
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
                controller.deleteBanner(context, currentIndex['id']);
              },
            ),
          );
        }
      },
    );
  }
}
