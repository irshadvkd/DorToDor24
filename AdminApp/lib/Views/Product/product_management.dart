import 'package:dortodorpartner/Controllers/Product/product_controller.dart';
import 'package:dortodorpartner/Helper/common_app_bar.dart';
import 'package:dortodorpartner/Helper/common_image.dart';
import 'package:dortodorpartner/Helper/common_text_field.dart';
import 'package:dortodorpartner/Helper/string.dart';
import 'package:dortodorpartner/Views/Product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductManagement extends GetView<ProductController> {
  const ProductManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        return CommonAppBar(
          title: "Manage Products",
          child: RefreshIndicator(
            onRefresh: () async => controller.getAllProduct(context),
            child: controller.productLoader
                ? Column(
                    children: [
                      /// Search and Create Section
                      searchAndCreateUI(context),

                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.product.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          itemBuilder: (context, index) {
                            var currentIndex = controller.product[index];
                            return ListTile(
                              leading: CommonImage(
                                url: "${currentIndex['image']}",
                                width: 50,
                                height: 50,
                              ),
                              title: Text(
                                Get.locale!.languageCode == "en"
                                    ? currentIndex['nameEng']
                                    : currentIndex['nameAr'],
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              trailing: Switch(
                                value: currentIndex['available'],
                                onChanged: (value) {
                                  if (controller.productLoader) {
                                    if (controller.disableProduct
                                        .contains(currentIndex['id'].toString())) {
                                      controller.disableProduct
                                          .remove(currentIndex['id'].toString());
                                    } else {
                                      controller.disableProduct
                                          .add(currentIndex['id']);
                                    }
                                    controller.disableProductApi(context);
                                  }
                                },
                              ),
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
              hintText: "searchProduct".tr,
              textController: controller.search,
              maxLines: 1,
              onChange: (value) {
                controller.addProductManageToList();
              },
            ),
          ),
          // const SizedBox(width: 15),
          // CommonButton(
          //   text: 'add'.tr,
          //   width: 100,
          //   onTap: () {
          //     controller.clearFormFields();
          //     Get.to(() => ProductAddPage(
          //       action: 'create',
          //       categoryId: categoryId,
          //       subCategoryId: subCategoryId,
          //     ));
          //   },
          // ),
        ],
      ),
    );
  }
}
