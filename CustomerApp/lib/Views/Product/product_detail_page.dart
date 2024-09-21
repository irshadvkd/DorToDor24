// import 'package:dorTodor24/Controllers/Product/product_controller.dart';
// import 'package:dorTodor24/Helper/colors.dart';
// import 'package:dorTodor24/Helper/common_app_bar.dart';
// import 'package:dorTodor24/Helper/common_image.dart';
// import 'package:dorTodor24/Helper/string.dart';
// import 'package:dorTodor24/Modals/Product/cart_modal.dart';
// import 'package:dorTodor24/Views/Product/image_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ProductDetailPage extends GetView<ProductController> {
//   final Data currentIndex;
//   const ProductDetailPage({super.key, required this.currentIndex});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProductController>(
//       builder: (controller) {
//         return CommonAppBar(
//           title: 'Product Details',
//           actionEnable: false,
//           child: Column(
//             children: [
//               Expanded(
//                 child: ListView(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Get.to(
//                             () => ImageView(image: currentIndex.image ?? ""));
//                       },
//                       child: AspectRatio(
//                         aspectRatio: 4 / 3,
//                         child: CommonImage(
//                           url: currentIndex.image ?? "",
//                           radius: 0,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             Get.locale!.languageCode == "en"
//                                 ? currentIndex.nameEng??""
//                                 : currentIndex.nameAr??"",
//                             style: Theme.of(context).textTheme.titleLarge,
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             children: [
//                               Text(
//                                 "Price  : ",
//                                 style: Theme.of(context).textTheme.titleMedium,
//                               ),
//                               Text(
//                                 "${currentIndex.price} $currencyCode",
//                                 style: Theme.of(context).textTheme.titleLarge,
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 12),
//                           // Row(
//                           //   mainAxisAlignment: MainAxisAlignment.start,
//                           //   crossAxisAlignment: CrossAxisAlignment.center,
//                           //   children: [
//                           //     CommonCard(
//                           //       color: colors.themeButton,
//                           //       onTap: () {
//                           //         currentIndex['qty'] = currentIndex['qty'] + 1;
//                           //         controller.update();
//                           //       },
//                           //       padding: const EdgeInsets.all(8),
//                           //       child: const Icon(
//                           //         Icons.add,
//                           //         color: colors.white,
//                           //       ),
//                           //     ),
//                           //     const SizedBox(width: 24),
//                           //     if (currentIndex['qty'] > 0)
//                           //       Text(
//                           //         "${currentIndex['qty']}",
//                           //         style: Theme.of(context).textTheme.titleLarge,
//                           //       ),
//                           //     const SizedBox(width: 24),
//                           //     if (currentIndex['qty'] > 0)
//                           //       CommonCard(
//                           //         color: colors.themeButton,
//                           //         onTap: () {
//                           //           if (currentIndex['qty'] > 0) {
//                           //             currentIndex['qty'] =
//                           //                 currentIndex['qty'] - 1;
//                           //             controller.update();
//                           //           }
//                           //         },
//                           //         padding: const EdgeInsets.all(8),
//                           //         child: const Icon(
//                           //           Icons.remove,
//                           //           color: colors.white,
//                           //         ),
//                           //       ),
//                           //   ],
//                           // ),
//                           // const SizedBox(height: 12),
//                           Text(
//                             'Description',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .headlineMedium!
//                                 .copyWith(
//                                     height: 1.5,
//                                     fontWeight: FontWeight.bold,
//                                     color: colors.textMain),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             Get.locale!.languageCode == "en"
//                                 ? currentIndex['descriptionEng']
//                                 : currentIndex['descriptionAr'],
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .headlineMedium!
//                                 .copyWith(height: 1.5),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // SizedBox(
//               //   height: 80,
//               //   width: MediaQuery.of(context).size.width,
//               //   child: Padding(
//               //     padding: const EdgeInsets.all(10),
//               //     child: Row(
//               //       crossAxisAlignment: CrossAxisAlignment.center,
//               //       mainAxisAlignment: MainAxisAlignment.end,
//               //       children: [
//               //         // SizedBox(
//               //         //   width: 150,
//               //         //   height: 57,
//               //         //   child: Column(
//               //         //     mainAxisAlignment: MainAxisAlignment.center,
//               //         //     children: [
//               //         //       Text(
//               //         //         'Total price',
//               //         //         style: Theme.of(context)
//               //         //             .textTheme
//               //         //             .titleSmall!
//               //         //             .copyWith(
//               //         //                 color: colors.textMain, fontSize: 14),
//               //         //         textAlign: TextAlign.center,
//               //         //         maxLines: 1,
//               //         //         overflow: TextOverflow.ellipsis,
//               //         //       ),
//               //         //       Text(
//               //         //         "${currentIndex['price']} $currencyCode",
//               //         //         style: Theme.of(context)
//               //         //             .textTheme
//               //         //             .titleLarge!
//               //         //             .copyWith(
//               //         //                 fontSize: 14, color: colors.primary),
//               //         //       ),
//               //         //     ],
//               //         //   ),
//               //         // ),
//               //         GestureDetector(
//               //           onTap: () {
//               //             Get.to(() => const CartPage());
//               //           },
//               //           child: Container(
//               //             height: 57,
//               //             width: 220,
//               //             decoration: BoxDecoration(
//               //               color: colors.themeButton,
//               //               borderRadius: BorderRadius.circular(12),
//               //             ),
//               //             child: Padding(
//               //               padding: const EdgeInsets.only(left: 22, right: 22),
//               //               child: Row(
//               //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               //                 children: [
//               //                   Text(
//               //                     'Add to Cart',
//               //                     style: Theme.of(context)
//               //                         .textTheme
//               //                         .titleLarge!
//               //                         .copyWith(
//               //                             fontSize: 20, color: colors.white),
//               //                   ),
//               //                   const Icon(
//               //                     Icons.shopping_cart,
//               //                     color: colors.white,
//               //                   )
//               //                 ],
//               //               ),
//               //             ),
//               //           ),
//               //         ),
//               //       ],
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
