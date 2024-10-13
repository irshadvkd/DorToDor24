import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:dortodorpartner/Controllers/Store/store_controller.dart';
import 'package:dortodorpartner/Helper/colors.dart';
import 'package:dortodorpartner/Helper/common_alert_confirm.dart';
import 'package:dortodorpartner/Helper/common_app_bar.dart';
import 'package:dortodorpartner/Helper/common_button.dart';
import 'package:dortodorpartner/Helper/common_card.dart';
import 'package:dortodorpartner/Helper/common_text_field.dart';
import 'package:dortodorpartner/Views/Stores/store_add_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StorePage extends GetView<StoreController> {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      builder: (controller) {
        return CommonAppBar(
          title: 'store'.tr,
          child: RefreshIndicator(
            onRefresh: () async => controller.getStore(context),
            child: controller.storeLoader
                ? Column(
                    children: [
                      /// Search and Create Section
                      searchAndCreateUI(context),

                      ///Category Section UI
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.store.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, index) {
                            return storeCard(context, controller.store[index]);
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
              hintText: 'searchStore'.tr,
              textController: controller.search,
              maxLines: 1,
              onChange: (value) {
                controller.addStoreToList();
              },
            ),
          ),
          const SizedBox(width: 15),
          CommonButton(
            text: 'add'.tr,
            width: 100,
            onTap: () {
              controller.clearFormFields();
              Get.to(() => StoreAddPage(action: 'create'));
            },
          ),
        ],
      ),
    );
  }

  Widget storeCard(context, currentIndex) {
    return CommonCard(
      color: colors.cardBg,
      boxShadowEnable: false,
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.store, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        currentIndex['name'],
                        style: Theme.of(context).textTheme.headlineLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.phone, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        currentIndex['phone'],
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.safety_check, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        currentIndex['activeStatus'] == 0
                            ? "Active"
                            : "Inactive",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          moreMenu(context, currentIndex),
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
          Get.to(() => StoreAddPage(
                action: "edit",
                url: currentIndex['image'] ?? "",
                storeId: currentIndex['id'],
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
                controller.deleteStore(context, currentIndex['id']);
              },
            ),
          );
        }
      },
    );
  }
}
