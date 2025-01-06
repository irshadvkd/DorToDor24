import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dorTodor24/Controllers/Home/home_controller.dart';
import 'package:dorTodor24/Helper/button_loader.dart';
import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Helper/common_button.dart';
import 'package:dorTodor24/Helper/common_text_field.dart';
import 'package:dorTodor24/Helper/session.dart';

class SignUpPage extends GetView<HomeController> {
  SignUpPage({super.key});
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * .82,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        child: Center(
                          child: Image.asset(
                            'assets/icons/logo.png',
                            height: 80,
                          ),
                        ),
                      ),
                      Text(
                        'User Name :',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      CommonTextField(
                        hintText: 'userName'.tr,
                        textCapitalization: TextCapitalization.none,
                        textController: controller.name,
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
                        'Email :',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      CommonTextField(
                        hintText: 'Enter your email'.tr,
                        textCapitalization: TextCapitalization.none,
                        textController: controller.email,
                        borderRadius: 50,
                        fillColor: colors.lightWhite,
                        borderColor: colors.textMain,
                        contentPadding:
                        const EdgeInsets.fromLTRB(25, 20, 25, 20),
                        maxLines: 1,
                        validator: (value) {
                          return commonValidator(value, "Email id is required");
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Phone :',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      CommonTextField(
                        hintText: 'Enter your phone number'.tr,
                        textCapitalization: TextCapitalization.none,
                        textController: controller.phone,
                        keyboardType: TextInputType.phone,
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        borderRadius: 50,
                        fillColor: colors.lightWhite,
                        borderColor: colors.textMain,
                        contentPadding:
                        const EdgeInsets.fromLTRB(25, 20, 25, 20),
                        maxLines: 1,
                        validator: (value) {
                          return commonValidator(
                              value, "Phone number is required".tr);
                        },
                      ),
                      const SizedBox(height: 10),
                      Obx(() {
                        return Row(
                          children: [
                            Text(
                              'Password : ',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            if (controller.passwordError.value ==
                                true) Text(
                              ' must be more than 8 characters..!',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold, color: colors.red),
                            ),
                          ],
                        );
                      }),
                      Obx(() {
                        return CommonTextField(
                          hintText: 'Enter your password'.tr,
                          textCapitalization: TextCapitalization.none,
                          textController: controller.password,
                          obSecureText: controller.obscureText.value,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.togglePasswordVisibility();
                            },
                            icon: Icon(controller.obscureText.value ? Icons
                                .visibility_off : Icons.visibility),
                          ),
                          borderRadius: 50,
                          fillColor: colors.lightWhite,
                          borderColor: colors.textMain,
                          contentPadding:
                          const EdgeInsets.fromLTRB(25, 20, 25, 20),
                          maxLines: 1,
                          validator: (value) {
                            if (value!.length < 8) {
                              controller.togglePasswordError();
                            }
                            return commonValidator(value, "requireUserPass".tr);
                          },
                        );
                      }),
                      const SizedBox(height: 10),
                      Text(
                        'Confirm Password :',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Obx(() {
                        return CommonTextField(
                          hintText: 'Enter password again'.tr,
                          textCapitalization: TextCapitalization.none,
                          textController: controller.confirmPassword,
                          obSecureText: controller.obscureText.value,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.togglePasswordVisibility();
                            },
                            icon: Icon(controller.obscureText.value ? Icons
                                .visibility_off : Icons.visibility),
                          ),
                          borderRadius: 50,
                          fillColor: colors.lightWhite,
                          borderColor: colors.textMain,
                          contentPadding:
                          const EdgeInsets.fromLTRB(25, 20, 25, 20),
                          maxLines: 1,
                          validator: (value) {
                            if (value
                                .toString()
                                .isEmpty) {
                              return commonValidator(
                                  value, "requireUserPass".tr);
                            } else if (value.toString() !=
                                controller.password.text) {
                              return "Passwords are not matching";
                            }
                            return null;
                          },
                        );
                      }),
                      const SizedBox(height: 10),
                      controller.buttonLoader
                          ? CommonButton(
                        color: colors.themeButton,
                        text: 'SignUp'.tr,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: colors.white),
                        height: 50,
                        radius: 50,
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            controller.registerUser(context);
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: Theme
                                .of(context)
                                .textTheme
                                .headlineMedium,
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              "Login ",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headlineLarge,
                            ),
                          ),
                        ],
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
