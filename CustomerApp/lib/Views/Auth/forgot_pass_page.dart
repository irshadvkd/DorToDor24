import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dorTodor24/Controllers/Home/home_controller.dart';
import 'package:dorTodor24/Helper/button_loader.dart';
import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Helper/common_button.dart';
import 'package:dorTodor24/Helper/common_text_field.dart';
import 'package:dorTodor24/Helper/session.dart';

class ForgotPassPage extends GetView<HomeController> {
  ForgotPassPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: colors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * .82,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height:100,
                        child: Center(
                          child: Image.asset(
                            'assets/icons/logo.png',
                            height: 80,
                          ),
                        ),
                      ),
                      Text(
                        'Email :',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      CommonTextField(
                        hintText: 'userName'.tr,
                        textCapitalization: TextCapitalization.none,
                        textController: controller.userName,
                        borderRadius: 50,
                        fillColor: colors.lightWhite,
                        borderColor: colors.textMain,
                        contentPadding:
                        const EdgeInsets.fromLTRB(25, 20, 25, 20),
                        maxLines: 1,
                        validator: (value) {
                          return commonValidator(value, "requireUserName".tr);
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Phone :',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      CommonTextField(
                        hintText: 'userName'.tr,
                        textCapitalization: TextCapitalization.none,
                        textController: controller.userName,
                        borderRadius: 50,
                        fillColor: colors.lightWhite,
                        borderColor: colors.textMain,
                        contentPadding:
                        const EdgeInsets.fromLTRB(25, 20, 25, 20),
                        maxLines: 1,
                        validator: (value) {
                          return commonValidator(value, "requireUserName".tr);
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'New Password :',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      CommonTextField(
                        hintText: 'password'.tr,
                        textCapitalization: TextCapitalization.none,
                        textController: controller.password,
                        obSecureText: true,
                        borderRadius: 50,
                        fillColor: colors.lightWhite,
                        borderColor: colors.textMain,
                        contentPadding:
                        const EdgeInsets.fromLTRB(25, 20, 25, 20),
                        maxLines: 1,
                        validator: (value) {
                          return commonValidator(value, "requireUserPass".tr);
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Confirm Password :',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      CommonTextField(
                        hintText: 'password'.tr,
                        textCapitalization: TextCapitalization.none,
                        textController: controller.password,
                        obSecureText: true,
                        borderRadius: 50,
                        fillColor: colors.lightWhite,
                        borderColor: colors.textMain,
                        contentPadding:
                        const EdgeInsets.fromLTRB(25, 20, 25, 20),
                        maxLines: 1,
                        validator: (value) {
                          return commonValidator(value, "requireUserPass".tr);
                        },
                      ),
                      const SizedBox(height: 10),
                      controller.buttonLoader
                          ? CommonButton(
                        color: colors.themeButton,
                        text: 'Reset Password'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: colors.white),
                        height: 50,
                        radius: 50,
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            controller.loginUser(context);
                          }
                        },
                      )
                          : const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ButtonLoader(
                          radius: 50,
                          height: 45,
                        ),
                      ),
                      const SizedBox(height: 10),
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
