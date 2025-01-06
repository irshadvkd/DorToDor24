import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:dortodorpartner/Helper/colors.dart';

class CommonAppBar extends StatelessWidget {
  final String title;
  final bool? actionEnable;
  final Widget child;
  const CommonAppBar({
    super.key,
    required this.title,
    this.actionEnable,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: colors.white,
          appBar: AppBar(elevation: 0,
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 17,
                color: colors.textMain,
              ),
            ),
            centerTitle: true,
            title: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: colors.textMain),
            ),
            backgroundColor: colors.white,
          ),
          body: child,
        );
      },
    );
  }
}
