import 'package:dorTodor24/Controllers/Home/home_controller.dart';
import 'package:dorTodor24/Controllers/Product/product_controller.dart';
import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Helper/common_app_bar.dart';
import 'package:dorTodor24/Helper/common_button.dart';
import 'package:dorTodor24/Helper/common_drop_down.dart';
import 'package:dorTodor24/Helper/common_text_field.dart';
import 'package:dorTodor24/Views/Product/order_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    final productController = Get.put(ProductController());
    productController.paymentMethod = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return CommonAppBar(
      title: "Delivery Information",
      actionEnable: false,
      child: GetBuilder<ProductController>(
        builder: (controller) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: CommonDropDown(
                        hintText: "Select Governorate",
                        list: homeController.governorate,
                        selected: homeController.selectedGovernorate,
                        enabled: false,
                        onChange: (value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: CommonDropDown(
                        hintText: "Select City",
                        list: homeController.city,
                        selected: homeController.selectedCity,
                        enabled: false,
                        onChange: (value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: CommonDropDown(
                        hintText: "Select Block",
                        list: homeController.block,
                        selected: homeController.selectedBlock,
                        enabled: false,
                        onChange: (value) {},
                      ),
                    ),
                    CommonTextField(
                      hintText: 'Street',
                      textController: controller.address,
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Street';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CommonTextField(
                      hintText: 'Building Number',
                      textController: controller.buildingNo,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your building number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CommonTextField(
                      hintText: 'Contact Number',
                      textController: controller.contactNumber,
                      keyboardType: TextInputType.number,
                      inputFormatter: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your contact number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CommonTextField(
                      hintText: 'Delivery Note (Optional)',
                      textController: controller.deliveryNote,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: controller.paymentMethod == "1"
                            ? colors.primary
                            : Colors.grey[200],
                        border: Border.all(color: colors.borderColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: colors.white,
                        checkColor: colors.secondary,
                        value: controller.paymentMethod == "1",
                        title: Text(
                          'Cash on Delivery',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: controller.paymentMethod == "1"
                                      ? colors.white
                                      : colors.textMain),
                        ),
                        onChanged: (newValue) {
                          controller.paymentMethod = "1";
                          controller.update();
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        color: controller.paymentMethod == "2"
                            ? colors.primary
                            : Colors.grey[200],
                        border: Border.all(color: colors.borderColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: colors.white,
                        checkColor: colors.secondary,
                        value: controller.paymentMethod == "2",
                        title: Text(
                          'KNET',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: controller.paymentMethod == "2"
                                      ? colors.white
                                      : colors.textMain),
                        ),
                        onChanged: (newValue) {
                          controller.paymentMethod = "2";
                          controller.update();
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        color: controller.paymentMethod == "3"
                            ? colors.primary
                            : Colors.grey[200],
                        border: Border.all(color: colors.borderColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: colors.white,
                        checkColor: colors.secondary,
                        value: controller.paymentMethod == "3",
                        title: Text(
                          'Link',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: controller.paymentMethod == "3"
                                      ? colors.white
                                      : colors.textMain),
                        ),
                        onChanged: (newValue) {
                          print(newValue);
                          controller.paymentMethod = "3";
                          print(controller.paymentMethod);
                          controller.update();
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    CommonButton(
                      text: "Confirm Order",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: colors.white),
                      height: 60,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          final homeController = Get.put(HomeController());
                          var storeId =
                              homeController.homeModal!.store!.id.toString();
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return OrderAlert(storeId: storeId);
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
