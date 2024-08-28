import 'package:dorTodor24/Controllers/Home/home_controller.dart';
import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Helper/common_app_bar.dart';
import 'package:dorTodor24/Helper/common_button.dart';
import 'package:dorTodor24/Helper/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAccountPage extends GetView<HomeController> {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return CommonAppBar(
          title: "My Account",
          actionEnable: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
                  child: CommonTextField(
                    hintText: "Enter your name",
                    textController: controller.name,
                    maxLines: 1,
                  ),
                ),
                Text(
                  "Email",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
                  child: CommonTextField(
                    hintText: "Enter your email address",
                    textController: controller.email,
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                  ),
                ),
                Text(
                  "Phone",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
                  child: CommonTextField(
                    hintText: "Enter your phone number",
                    textController: controller.phone,
                    maxLines: 1,
                  ),
                ),
                Center(
                  child: CommonButton(
                    color: colors.themeButton,
                    text: "Update",
                    height: 45,
                    width: 200,
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 32),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
