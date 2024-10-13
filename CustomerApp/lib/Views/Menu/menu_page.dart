import 'package:dorTodor24/Controllers/Home/home_controller.dart';
import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Helper/common_card.dart';
import 'package:dorTodor24/Views/Auth/login_page.dart';
import 'package:dorTodor24/Views/Menu/contact_us.dart';
import 'package:dorTodor24/Views/Menu/my_account_page.dart';
import 'package:dorTodor24/Views/Menu/order_page.dart';
import 'package:dorTodor24/Views/Menu/terms_and_policy.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controllers/Menu/order_controller.dart';

class MenuPage extends GetView<HomeController> {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.find<OrderController>();
    return GetBuilder<HomeController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                commonMenuItem(
                  context,
                  Icons.person,
                  "Login/Signup",
                  () {
                    Get.to(() => LoginPage());
                  },
                ),
                commonMenuItem(
                  context,
                  Icons.person,
                  "My Account",
                  () {
                    Get.to(() => const MyAccountPage());
                  },
                ),
                commonMenuItem(
                  context,
                  Icons.history,
                  "My Orders",
                  () {
                    orderController.getOrder(context, '3');
                    Get.to(() => const OrdersPage());
                  },
                ),
                commonMenuItem(
                  context,
                  Icons.policy,
                  "Terms & Policy",
                  () {
                    Get.to(() => const TermsAndPolicyPage());
                  },
                ),
                commonMenuItem(
                  context,
                  Icons.support_agent,
                  "Contact us",
                  () {
                    Get.to(() => const ContactPage());
                  },
                ),
                commonMenuItem(
                  context,
                  Icons.logout,
                  "Logout",
                  () async {
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setBool("isLogin", false);
                    Get.offAllNamed("/login");
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  commonMenuItem(context, icon, text, onTap) {
    return CommonCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      onTap: onTap,
      child: Row(
        children: [
          CommonCard(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(8),
            borderRadius: 7,
            child: Icon(icon, color: colors.themeButton),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: colors.themeButton,
          ),
        ],
      ),
    );
  }
}
