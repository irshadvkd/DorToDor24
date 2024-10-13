import 'package:dortodorpartner/Controllers/Product/product_controller.dart';
import 'package:dortodorpartner/Helper/common_app_bar.dart';
import 'package:dortodorpartner/Helper/common_button.dart';
import 'package:dortodorpartner/Helper/common_text_field.dart';
import 'package:dortodorpartner/Views/Product/product_add_page.dart';
import 'package:dortodorpartner/Views/Product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends GetView<ProductController> {
  final String title;
  final int categoryId;
  final int subCategoryId;
  const ProductPage({
    super.key,
    required this.title,
    required this.categoryId,
    required this.subCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        return CommonAppBar(
          title: title,
          child: RefreshIndicator(
            onRefresh: () async =>
                controller.getProduct(context, categoryId, subCategoryId),
            child: controller.productLoader
                ? Column(
                    children: [
                      /// Search and Create Section
                      searchAndCreateUI(context),

                      Expanded(
                        child: GridView.builder(
                          itemCount: controller.product.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1,
                          ),
                          shrinkWrap: true,
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          itemBuilder: (context, index) {
                            return ProductCard(
                              currentIndex: controller.product[index],
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
                controller.addProductToList();
              },
            ),
          ),
          const SizedBox(width: 15),
          CommonButton(
            text: 'add'.tr,
            width: 100,
            onTap: () {
              controller.clearFormFields();
              Get.to(() => ProductAddPage(
                    action: 'create',
                    categoryId: categoryId,
                    subCategoryId: subCategoryId,
                  ));
            },
          ),
        ],
      ),
    );
  }
}
