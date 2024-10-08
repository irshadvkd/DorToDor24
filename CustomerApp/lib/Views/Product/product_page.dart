import 'package:dorTodor24/Controllers/Product/product_controller.dart';
import 'package:dorTodor24/Helper/common_app_bar.dart';
import 'package:dorTodor24/Helper/common_text_field.dart';
import 'package:dorTodor24/Views/Home/home_app_bar.dart';
import 'package:dorTodor24/Views/Product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/Cart/cart_controller.dart';
import '../../Helper/colors.dart';
import 'cart_page.dart';

class ProductPage extends GetView<ProductController> {
  final String title;
  final String subCatId;
  const ProductPage({super.key, required this.title, required this.subCatId});

  @override
  Widget build(BuildContext context) {
    var cartController = Get.put(CartController());
    return GetBuilder<ProductController>(
      builder: (controller) {
        return CommonAppBar(
          title: title,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: CommonTextField(
                  hintText: "Search in this product",
                  textController: controller.searchInProduct,
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.9,
                    ),
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemBuilder: (context, index) {
                      return ProductCard(
                        currentIndex: controller.product[index],
                        subCatId: subCatId,
                      );
                    },
                  ),
                ),
              ),

              SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          cartController.loadCartFromSession();
                          Get.to(() => const CartPage(hideAppBar: false));
                          controller.update();
                          // controller.getNotification(context);
                          // Get.offAndToNamed("/home");
                          // var productController =
                          // Get.put(ProductController());
                          // productController.getCart(context);
                          // Get.to(() => const CartPage());
                          // Get.offAllNamed("/home");
                          // controller.currentPage = 1;
                          // controller.update();
                        },
                        child: Container(
                          height: 57,
                          width: 220,
                          decoration: BoxDecoration(
                            color: colors.themeButton,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 22, right: 22),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Go to Cart',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                      fontSize: 20, color: colors.white),
                                ),
                                const Icon(
                                  Icons.shopping_cart,
                                  color: colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
