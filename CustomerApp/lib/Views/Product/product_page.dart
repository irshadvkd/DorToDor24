import 'package:dorTodor24/Controllers/Product/product_controller.dart';
import 'package:dorTodor24/Helper/common_app_bar.dart';
import 'package:dorTodor24/Helper/common_text_field.dart';
import 'package:dorTodor24/Views/Product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends GetView<ProductController> {
  final String title;
  const ProductPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        return CommonAppBar(
          title: title,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: CommonTextField(
                  hintText: "Search in this category",
                  textController: controller.searchInCategory,
                  prefixIcon: const Icon(Icons.search),
                  onChange: (value) {
                    controller.addProductToList();
                    controller.update();
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    itemCount: controller.product.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.9,
                    ),
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemBuilder: (context, index) {
                      return ProductCard(currentIndex: controller.product[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
