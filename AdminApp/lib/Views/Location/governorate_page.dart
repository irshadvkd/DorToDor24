import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:dortodorpartner/Controllers/Location/location_controller.dart';
import 'package:dortodorpartner/Helper/colors.dart';
import 'package:dortodorpartner/Helper/common_alert_confirm.dart';
import 'package:dortodorpartner/Helper/common_app_bar.dart';
import 'package:dortodorpartner/Helper/common_button.dart';
import 'package:dortodorpartner/Helper/common_card.dart';
import 'package:dortodorpartner/Helper/common_text_field.dart';
import 'package:dortodorpartner/Views/Location/city_page.dart';
import 'package:dortodorpartner/Views/Location/governorate_add_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GovernoratePage extends GetView<LocationController> {
  const GovernoratePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (controller) {
        return CommonAppBar(
          title: 'governorate'.tr,
          child: RefreshIndicator(
            onRefresh: () async => controller.getGovernorate(context),
            child: controller.governorateLoader
                ? Column(
                    children: [
                      /// Search and Create Section
                      searchAndCreateUI(context),

                      /// Governorate Section UI
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.governorate.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, index) {
                            return governorateCard(
                              context,
                              controller.governorate[index],
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
              hintText: 'searchGovernorate'.tr,
              textController: controller.search,
              maxLines: 1,
              onChange: (value) {
                controller.addGovernorateToList();
              },
            ),
          ),
          const SizedBox(width: 15),
          CommonButton(
            text: 'add'.tr,
            width: 100,
            onTap: () {
              controller.clearFormFields();
              Get.to(() => GovernorateAddPage(action: 'create'));
            },
          ),
        ],
      ),
    );
  }

  Widget governorateCard(context, currentIndex) {
    bool isArabic = Get.locale == const Locale('ar', 'KW') ? true : false;
    return CommonCard(
      color: colors.cardBg,
      boxShadowEnable: false,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      onTap: () {
        controller.getCity(context, currentIndex['id']);
        Get.to(() => CityPage(
              governorateId: currentIndex['id'],
              title:
                  isArabic ? currentIndex['nameAr'] : currentIndex['nameEng'],
            ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              isArabic ? currentIndex['nameAr'] : currentIndex['nameEng'],
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: colors.primary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: colors.cardBg,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: moreMenu(context, currentIndex),
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
          Get.to(() => GovernorateAddPage(
                action: "edit",
                governorateId: currentIndex['id'],
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
                controller.deleteGovernorate(context, currentIndex['id']);
              },
            ),
          );
        }
      },
    );
  }
}
