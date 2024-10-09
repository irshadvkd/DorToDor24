import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:dortodorpartner/Helper/colors.dart';
import 'package:get/get.dart';

class CommonAlertConfirm extends GetView<HomeController> {
  final String msg;
  final double? height;
  final void Function() onTap;
  const CommonAlertConfirm(
      {Key? key, required this.msg, this.height, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Center(
          child: Container(
            width: 280,
            height: height ?? 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    msg,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(child: Container()),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: colors.grey.withOpacity(.1), width: 1),
                          ),
                          child: Text(
                            'CANCEL',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(color: colors.primary),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: controller.buttonLoader
                          ? GestureDetector(
                              onTap: onTap,
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: colors.grey.withOpacity(.1),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  'DELETE',
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(4),
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: colors.grey.withOpacity(.1),
                                  width: 1,
                                ),
                              ),
                              child: const CircularProgressIndicator(),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
