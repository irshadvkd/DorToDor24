import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Helper/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/Home/home_controller.dart';
import '../../Helper/common_button.dart';
import '../../Helper/common_text_field.dart';

class EditUserDetails extends GetView<HomeController> {
  const EditUserDetails({super.key});

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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildEditableTextField(
                        context,
                        "Name",
                        controller.name,
                        "Enter your name",
                      ),
                      const SizedBox(height: 16),
                      _buildEditableTextField(
                        context,
                        "Email",
                        controller.email,
                        "Enter your email address",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      _buildEditableTextField(
                        context,
                        "Phone",
                        controller.phone,
                        "Enter your phone number",
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: CommonButton(
                          color: colors.themeButton,
                          text: "Update",
                          height: 45,
                          width: 200,
                          onTap: () {
                          },
                        ),
                      ),
                    ],
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

  // Helper method to build editable text fields
  Widget _buildEditableTextField(BuildContext context, String label,
      TextEditingController controller, String hintText,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonTextField(
            hintText: hintText,
            textController: controller,
            textCapitalization: TextCapitalization.none,
            keyboardType: keyboardType,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
