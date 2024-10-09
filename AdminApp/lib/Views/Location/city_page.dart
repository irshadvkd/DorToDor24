import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:dortodorpartner/Controllers/Location/location_controller.dart';
import 'package:dortodorpartner/Helper/colors.dart';
import 'package:dortodorpartner/Helper/common_alert_confirm.dart';
import 'package:dortodorpartner/Helper/common_app_bar.dart';
import 'package:dortodorpartner/Helper/common_button.dart';
import 'package:dortodorpartner/Helper/common_card.dart';
import 'package:dortodorpartner/Helper/common_text_field.dart';
import 'package:dortodorpartner/Views/Location/block_page.dart';
import 'package:dortodorpartner/Views/Location/city_add_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CityPage extends GetView<LocationController> {
  final int governorateId;
  final String title;
  const CityPage({
    Key? key,
    required this.governorateId,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (controller) {
        return CommonAppBar(
          title: 'city'.tr,
          child: RefreshIndicator(
            onRefresh: () async => controller.getCity(context, governorateId),
            child: controller.cityLoader
                ? Column(
                    children: [
                      /// Search and Create Section
                      searchAndCreateUI(context),

                      /// City Section UI
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.city.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, index) {
                            return cityCard(
                              context,
                              controller.city[index],
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
              hintText: 'searchCity'.tr,
              textController: controller.search,
              maxLines: 1,
              onChange: (value) {
                controller.addCityToList();
              },
            ),
          ),
          const SizedBox(width: 15),
          CommonButton(
            text: 'add'.tr,
            width: 100,
            onTap: () {
              controller.clearFormFields();
              Get.to(() =>
                  CityAddPage(action: 'create', governorateId: governorateId));
            },
          ),
        ],
      ),
    );
  }

  Widget cityCard(context, currentIndex) {
    bool isArabic = Get.locale == const Locale('ar', 'KW') ? true : false;
    return CommonCard(
      color: colors.cardBg,
      boxShadowEnable: false,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      onTap: () {
        controller.getBlock(context, governorateId, currentIndex['id']);
        Get.to(() => BlockPage(
              governorateId: governorateId,
              cityId: currentIndex['id'],
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
          Get.to(() => CityAddPage(
                action: "edit",
                governorateId: governorateId,
                cityId: currentIndex['id'],
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
                controller.deleteCity(
                    context, governorateId, currentIndex['id']);
              },
            ),
          );
        }
      },
    );
  }
}
