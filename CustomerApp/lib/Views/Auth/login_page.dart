import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dorTodor24/Controllers/Home/home_controller.dart';
import 'package:dorTodor24/Helper/button_loader.dart';
import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Helper/common_button.dart';
import 'package:dorTodor24/Helper/common_text_field.dart';
import 'package:dorTodor24/Helper/session.dart';

class LoginPage extends GetView<HomeController> {
  LoginPage({Key? key}) : super(key: key);
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 300,
                        child: Center(
                          child: Image.asset(
                            'assets/icons/logo.png',
                            height: 200,
                          ),
                        ),
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
                        text: 'login'.tr,
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
                      // Row(
                      //   children: <Widget>[
                      //     Text(
                      //       'loginEasily'.tr,
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .headline6!
                      //           .copyWith(
                      //               fontWeight: FontWeight.normal,
                      //               color: colors.border),
                      //     ),
                      //     const SizedBox(width: 5),
                      //     InkWell(
                      //       child: Text(
                      //         'loginQR'.tr,
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .headline5!
                      //             .copyWith(color: colors.white),
                      //       ),
                      //     ),
                      //   ],
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      // ),
                      // const SizedBox(height: 20),
                      // InkWell(
                      //   child: Text(
                      //     'forgotPass'.tr,
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .headline5!
                      //         .copyWith(color: colors.white),
                      //   ),
                      // ),
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
