import 'package:dorTodor24/Controllers/Cart/cart_controller.dart';
import 'package:dorTodor24/Controllers/Home/home_controller.dart';
import 'package:dorTodor24/Controllers/Product/product_controller.dart';
import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Helper/common_card.dart';
import 'package:dorTodor24/Helper/common_image.dart';
import 'package:dorTodor24/Helper/string.dart';
import 'package:dorTodor24/Views/Product/sub_category_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        final productController = Get.put(ProductController());
        final cartController = Get.put(CartController());

        return RefreshIndicator(
          onRefresh: () async {
            controller.getHome(context);
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Let's find food here",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: colors.themeButton, fontSize: 24),
                      ),
                      // const SizedBox(height: 8),
                      // CommonTextField(
                      //   hintText: "Search now....",
                      //   textController: productController.searchInCategory,
                      //   prefixIcon: const Icon(
                      //     Icons.search,
                      //     size: 24,
                      //   ),
                      //   onChange: (value) {
                      //     // final productController =
                      //     //     Get.put(ProductController());
                      //     // // productController.getProduct(context, 0);
                      //     // Get.to(() => const ProductSearchPage());
                      //   },
                      // ),
                    ],
                  ),
                ),

                /// Slider Section UI
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
                  items: controller.slider.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: CommonImage(url: imgUrl + item['image']),
                    );
                  }).toList(),
                ),

                ///Category Section UI
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    itemCount: controller.category.length,
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
                      return categoryCard(context, controller.category[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget categoryCard(context, currentIndex) {
    return CommonCard(
      boxShadowEnable: false,
      onTap: () {
        final productController = Get.put(ProductController());
        productController.searchInSubCategory.clear();
        productController.getSubCategory(context, currentIndex['id']);
        Get.to(() => SubCategoryPage(
              catId: currentIndex['id'].toString(),
              title: Get.locale!.languageCode == "en"
                  ? currentIndex['nameEng']
                  : currentIndex["nameAr"],
            ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 20,
        height: MediaQuery.of(context).size.height / 2 - 20,
        color: colors.cardBg,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Container()),
            SizedBox(
              height: 100,
              child: CommonImage(
                url: imgUrl + currentIndex['image'],
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2 - 24,
              color: colors.cardBg,
              child: Text(
                Get.locale!.languageCode == "en"
                    ? currentIndex['nameEng']
                    : currentIndex["nameAr"],
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
