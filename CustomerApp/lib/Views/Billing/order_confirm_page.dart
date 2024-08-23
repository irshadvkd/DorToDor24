import 'package:dorTodor24/Controllers/Product/product_controller.dart';
import 'package:dorTodor24/Helper/common_app_bar.dart';
import 'package:dorTodor24/Helper/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/colors.dart';
import 'address_card.dart';
import 'edit_address_button.dart';
import 'order_success_widget.dart';

class OrderConfirmPage extends GetView<ProductController> {
  OrderConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      title: 'Confirm your Order',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'Delivery Address',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: colors.textMain),
            ),
          ),
          const SizedBox(height: 10),
          Obx(() {
            return Expanded(
              child: ListView(
                children: [
                  RadioListTile<int>(
                    title: const AddressCard(),
                    value: 1,
                    groupValue: controller.selectedValue.value,
                    onChanged: (int? value) {
                      if (value != null) {
                        controller.updateSelectedValue(value);
                      }
                    },
                  ),
                  RadioListTile<int>(
                    title: const AddressCard(),
                    value: 2,
                    groupValue: controller.selectedValue.value,
                    onChanged: (int? value) {
                      if (value != null) {
                        controller.updateSelectedValue(value);
                      }
                    },
                  ),
                  RadioListTile<int>(
                    title: const AddressCard(),
                    value: 3,
                    groupValue: controller.selectedValue.value,
                    onChanged: (int? value) {
                      if (value != null) {
                        controller.updateSelectedValue(value);
                      }
                    },
                  ),
                ],
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Center(
              child: CommonButton(
                width: 220,
                color: colors.themeButton,
                text: "Confirm",
                height: 50,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: colors.white, fontWeight: FontWeight.w600),
                onTap: () {
                  // Add your onTap logic here
                  showOrderSuccessPopup(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  // void showOrderSuccessPopup(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => Container(
  //       width: MediaQuery.of(context).size.width,
  //       height: 400,
  //       color: colors.orange,
  //       child: ClipRRect(
  //         borderRadius: const BorderRadius.vertical(top: Radius.circular(200)),
  //         child: Container(
  //           height: 300,
  //           color: colors.white,
  //           child: OrderSuccessPopup(),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
