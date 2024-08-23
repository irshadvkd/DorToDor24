import 'package:dorTodor24/Controllers/Home/home_controller.dart';
import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Helper/common_button.dart';
import 'package:dorTodor24/Helper/common_card.dart';
import 'package:dorTodor24/Views/Auth/phone_no_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguagePage extends GetView<HomeController> {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 70, 0, 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Select',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 26, color: colors.primary),
                    ),
                    Text(
                      ' Language',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 26, color: colors.secondary),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Image.asset(
                    'assets/icons/lng_change.png',
                    fit: BoxFit.contain,
                    width: 300,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              GestureDetector(
                onTap: () {
                  // showLanguagePicker(context);
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  decoration: BoxDecoration(
                      border: Border.all(color: colors.fontColor, width: 1),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        controller.language["flag"]??"",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: colors.fontColor, fontSize: 26),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          controller.language["name"]??"",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: colors.fontColor),
                        ),
                      ),
                      // moreMenu(context),
                      const Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ),
              ),
              CommonButton(
                text: "Select",
                width: 220,
                height: 45,
                margin: const EdgeInsets.fromLTRB(0, 60, 0, 60),
                color: colors.themeButton,
                onTap: () {
                  Get.to(() => const PhoneNoPage());
                },
              ),

              // SizedBox(
              //   height: MediaQuery.of(context).size.height / 5,
              //   width: MediaQuery.of(context).size.width,
              //   child: Padding(
              //     padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
              //     child: Column(
              //       children: [
              //         const SizedBox(height: 30),
              //
              //         // DropdownButtonHideUnderline(
              //         //   child: DropdownButtonFormField2(
              //         //     isExpanded: true,
              //         //     items: [
              //         //       {
              //         //         "code": "en",
              //         //         "name": "English",
              //         //         "flag": "🏴󠁧󠁢󠁥󠁮󠁧󠁿",
              //         //       },
              //         //       {
              //         //         "code": "ar",
              //         //         "name": "Arabic",
              //         //         "flag": "🇧🇭",
              //         //       },
              //         //     ].map((item) {
              //         //       return DropdownMenuItem(
              //         //         value: item["code"],
              //         //         enabled: true,
              //         //         child: Container(
              //         //           width: double.infinity,
              //         //           height: double.infinity,
              //         //           alignment: Alignment.centerLeft,
              //         //           child: Row(
              //         //             children: [
              //         //               Text(
              //         //                 item["flag"]!,
              //         //                 style: Theme.of(context)
              //         //                     .textTheme
              //         //                     .headlineLarge!
              //         //                     .copyWith(
              //         //                         color: colors.fontColor,
              //         //                         fontSize: 30),
              //         //               ),
              //         //               const SizedBox(width: 16),
              //         //               Text(
              //         //                 item["name"]!,
              //         //                 style: Theme.of(context)
              //         //                     .textTheme
              //         //                     .headlineLarge!
              //         //                     .copyWith(color: colors.fontColor),
              //         //               ),
              //         //             ],
              //         //           ),
              //         //         ),
              //         //       );
              //         //     }).toList(),
              //         //     value: controller.selectedLanguage,
              //         //     onChanged: (value) {
              //         //       controller.selectedLanguage = value.toString();
              //         //       controller.update();
              //         //     },
              //         //     decoration: InputDecoration(
              //         //       filled: true,
              //         //       fillColor: colors.white,
              //         //       isDense: true,
              //         //       contentPadding:
              //         //           const EdgeInsets.fromLTRB(0, 12, 0, 12),
              //         //       enabledBorder: OutlineInputBorder(
              //         //         borderRadius: BorderRadius.circular(6),
              //         //         borderSide:
              //         //             const BorderSide(color: colors.themeButton),
              //         //       ),
              //         //       focusedBorder: OutlineInputBorder(
              //         //           borderRadius: BorderRadius.circular(6),
              //         //           borderSide: const BorderSide(
              //         //               color: colors.themeButton)),
              //         //       errorBorder: OutlineInputBorder(
              //         //         borderRadius: BorderRadius.circular(6),
              //         //         borderSide: const BorderSide(color: Colors.red),
              //         //       ),
              //         //       disabledBorder: OutlineInputBorder(
              //         //           borderRadius: BorderRadius.circular(6),
              //         //           borderSide:
              //         //               const BorderSide(color: colors.fontColor)),
              //         //       errorStyle: Theme.of(context)
              //         //           .textTheme
              //         //           .titleLarge!
              //         //           .copyWith(
              //         //               color: Colors.red,
              //         //               fontWeight: FontWeight.w400),
              //         //     ),
              //         //     iconStyleData: const IconStyleData(
              //         //       iconEnabledColor: colors.themeButton,
              //         //       iconDisabledColor: colors.themeButton,
              //         //       icon: Padding(
              //         //         padding: EdgeInsets.only(right: 10, bottom: 10),
              //         //         child: Icon(Icons.arrow_drop_down, size: 30),
              //         //       ),
              //         //     ),
              //         //     menuItemStyleData: const MenuItemStyleData(
              //         //       padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              //         //     ),
              //         //     dropdownStyleData: DropdownStyleData(
              //         //       maxHeight: 200,
              //         //       padding: null,
              //         //       decoration: BoxDecoration(
              //         //         borderRadius: BorderRadius.circular(6),
              //         //         color: colors.white,
              //         //         boxShadow: const [
              //         //           BoxShadow(
              //         //             color: Color(0x29000000),
              //         //             blurRadius: 3,
              //         //           ),
              //         //         ],
              //         //       ),
              //         //       scrollbarTheme: ScrollbarThemeData(
              //         //         radius: const Radius.circular(40),
              //         //         thickness: MaterialStateProperty.all(6),
              //         //         thumbVisibility: MaterialStateProperty.all(true),
              //         //       ),
              //         //     ),
              //         //   ),
              //         // ),
              //         CommonButton(
              //           text: "Select",
              //           width: 220,
              //           height: 45,
              //           margin: const EdgeInsets.fromLTRB(0, 60, 0, 60),
              //           color: colors.themeButton,
              //           onTap: () {
              //             Get.to(() => const PhoneNoPage());
              //           },
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }

  Widget moreMenu(context) {
    return PopupMenuButton(
      color: colors.cardBg,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      icon: const Icon(
        Icons.more_vert,
        color: colors.primary,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              const Icon(
                Icons.edit,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                'edit'.tr,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              const Icon(
                Icons.delete,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                'delete'.tr,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
      ],
      onSelected: (int value) {
        if (value == 1) {
          // controller.clearFormFields();
          // controller.setFormFields(currentIndex);
          // Get.to(() => SubCategoryAddPage(
          //   action: "edit",
          //   url: currentIndex['image'] ?? "",
          //   categoryId: categoryId,
          //   subCategoryId: currentIndex['id'],
          // ));
        }
        if (value == 2) {
          final homeController = Get.put(HomeController());
          homeController.buttonLoader = true;
          homeController.update();
          // Get.dialog(
          //   CommonAlertConfirm(
          //     msg: "deleteMessage".tr,
          //     onTap: () {
          //       controller.deleteSubCategory(context, currentIndex['id']);
          //     },
          //   ),
          // );
        }
      },
    );
  }

  showLanguagePicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            children: [
              ListTile(
                title: Text('English'),
                onTap: () {
                  // _selectLanguage('English');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Spanish'),
                onTap: () {
                  // _selectLanguage('Spanish');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('French'),
                onTap: () {
                  // _selectLanguage('French');
                  Navigator.pop(context);
                },
              ),
              // Add more ListTile widgets for additional languages
            ],
          ),
        );
      },
    );
  }
}
