import 'package:dorTodor24/Controllers/Home/home_controller.dart';
import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Helper/common_button.dart';
import 'package:dorTodor24/Helper/common_text_field.dart';
import 'package:dorTodor24/Views/Auth/place_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneNoPage extends GetView<HomeController> {
  const PhoneNoPage({super.key});

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
                      'Hi,',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 26, color: colors.primary),
                    ),
                    Text(
                      ' Welcome back',
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
                    'assets/icons/location.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.fromLTRB(40, 30, 40, 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter your number',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: colors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 8),
                child: CommonTextField(
                  hintText: '965 0 000 0000',
                  keyboardType: TextInputType.number,
                  borderColor: colors.fontColor,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      '🇰🇼',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: colors.fontColor, fontSize: 26),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                alignment: Alignment.centerLeft,
                child: Text(
                  "We'll text you a code to verify your number",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: colors.lightGrey),
                ),
              ),
              CommonButton(
                text: "Continue",
                width: 220,
                height: 45,
                margin: const EdgeInsets.fromLTRB(0, 80, 0, 20),
                color: colors.themeButton,
                onTap: () {
                  controller.getLocation(context);
                  Get.to(() =>  PlaceSelectPage());
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: GestureDetector(
                  onTap: () {
                    Get.offAllNamed("/home");
                  },
                  child: Text(
                    'Continue as guest',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
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
