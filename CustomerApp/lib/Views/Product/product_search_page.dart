// import 'package:dorTodor24/Controllers/Product/product_controller.dart';
// import 'package:dorTodor24/Helper/colors.dart';
// import 'package:dorTodor24/Helper/common_app_bar.dart';
// import 'package:dorTodor24/Helper/common_button.dart';
// import 'package:dorTodor24/Helper/common_text_field.dart';
// import 'package:dorTodor24/Views/Product/product_card.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ProductSearchPage extends GetView<ProductController> {
//   const ProductSearchPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProductController>(
//       builder: (controller) {
//         return CommonAppBar(
//           title: "Search Product",
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: CommonTextField(
//                         hintText: "Search Products",
//                         textController: controller.searchInSubCategory,
//                         prefixIcon: const Icon(Icons.search),
//                         onChange: (value) {
//                           controller.addProductToList();
//                           controller.update();
//                         },
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     CommonButton(
//                       color: colors.themeButton,
//                       text: "Search",
//                       onTap: () {},
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: GridView.builder(
//                   itemCount: controller.product.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                   ),
//                   shrinkWrap: true,
//                   padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//                   itemBuilder: (context, index) {
//                     return ProductCard(
//                       currentIndex: controller.product[index],
//                       subCatId: "1",
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
