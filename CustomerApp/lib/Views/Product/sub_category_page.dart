import 'package:dorTodor24/Controllers/Product/product_controller.dart';
import 'package:dorTodor24/Helper/common_app_bar.dart';
import 'package:dorTodor24/Helper/common_card.dart';
import 'package:dorTodor24/Helper/common_image.dart';
import 'package:dorTodor24/Views/Product/product_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/common_text_field.dart';

class SubCategoryPage extends GetView<ProductController> {
  final String catId;
  final String title;
  const SubCategoryPage({super.key, required this.catId, required this.title});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        return CommonAppBar(
          title: title,
          child: controller.subCategoryLoader
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   "Let's find food here",
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .headlineLarge!
                            //       .copyWith(
                            //           color: colors.themeButton, fontSize: 24),
                            // ),
                            CommonTextField(
                              hintText: "Search in this sub category",
                              textController: controller.searchInSubCategory,
                              prefixIcon: const Icon(Icons.search),
                              onChange: (value) {
                                controller.addSubCategoryToList();
                              },
                            ),
                          ],
                        ),
                      ),

                      ///SubSlider Section UI
                      CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 3,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                          viewportFraction: 0.8,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                        ),
                        items: controller.subCategorySlider.map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: CommonImage(url: item['image']),
                          );
                        }).toList(),
                      ),

                      ///SubCategory Section UI
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: GridView.builder(
                          itemCount: controller.subCategory.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 30,
                            mainAxisSpacing: 20,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, index) {
                            return subCategoryCard(
                                context, controller.subCategory[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget subCategoryCard(context, currentIndex) {
    return CommonCard(
      boxShadowEnable: false,
      onTap: () {
        final productController = Get.put(ProductController());
        productController.searchInProduct.clear();
        productController.getProduct(context, currentIndex['id']);
        Get.to(() => ProductPage(
              title: Get.locale!.languageCode == "en"
                  ? currentIndex['nameEng']
                  : currentIndex['nameAr'],
              subCatId: currentIndex['id'],
            ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 20,
        height: MediaQuery.of(context).size.height / 2 - 20,
        // color: colors.cardBg,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Container()),
            SizedBox(
              height: 100,
              child: CommonImage(
                url: currentIndex['image'],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2 - 24,
              // color: colors.cardBg,
              color: Colors.transparent,
              child: Text(
                Get.locale!.languageCode == "en"
                    ? currentIndex['nameEng']
                    : currentIndex['nameAr'],
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
