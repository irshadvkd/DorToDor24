import 'package:dorTodor24/Controllers/Home/home_controller.dart';
import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Helper/common_button.dart';
import 'package:dorTodor24/Helper/common_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceSelectPage extends GetView<HomeController> {
  PlaceSelectPage({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async => controller.getLocation(context),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Form(
                  key: formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Center(
                        child: Text(
                          'Welcome',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 26, color: colors.primary),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                        height: 150,
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/icons/logo.png',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Governorate",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(color: colors.primary),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 16),
                            child: CommonDropDown(
                              hintText: "Select Governorate",
                              list: controller.governorate,
                              selected: controller.selectedGovernorate,
                              borderColor: colors.primary,
                              validatorText: "Please select governorate",
                              onChange: (value) {
                                controller.selectedGovernorate =
                                    value as String;
                                controller.addCityToList();
                                controller.update();
                              },
                            ),
                          ),
                          Text(
                            "City",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(color: colors.primary),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 16),
                            child: CommonDropDown(
                              hintText: "Select City",
                              list: controller.city,
                              selected: controller.selectedCity,
                              borderColor: colors.primary,
                              validatorText: "Please select city",
                              onChange: (value) {
                                controller.selectedCity = value as String;
                                controller.addBlockToList();
                                controller.update();
                              },
                            ),
                          ),
                          Text(
                            "Block",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(color: colors.primary),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 16),
                            child: CommonDropDown(
                              hintText: "Select Block",
                              list: controller.block,
                              selected: controller.selectedBlock,
                              borderColor: colors.primary,
                              validatorText: "Please select block",
                              onChange: (value) {
                                controller.selectedBlock = value as String;
                                controller.update();
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CommonButton(
                        text: "Let's Buy",
                        width: 220,
                        height: 45,
                        color: colors.themeButton,
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            var prefs = await SharedPreferences.getInstance();
                            prefs.setBool("isSelectLocation", true);
                            prefs.setString(
                                "governorate", controller.selectedGovernorate);
                            prefs.setString("city", controller.selectedCity);
                            prefs.setString("block", controller.selectedBlock);
                            controller.getHome(context);
                            Get.offAndToNamed("/home");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
