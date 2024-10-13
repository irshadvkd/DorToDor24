import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:dortodorpartner/Controllers/Order/order_controller.dart';
import 'package:dortodorpartner/Helper/colors.dart';
import 'package:dortodorpartner/Views/Home/home_page.dart';
import 'package:dortodorpartner/Views/Home/notification_page.dart';
import 'package:dortodorpartner/Views/Menu/menu_page.dart';
import 'package:dortodorpartner/Views/Menu/order_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAppBar extends GetView<HomeController> {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: colors.white,
          appBar: AppBar(
            backgroundColor: colors.primary,
            leading: Image.asset(
              "assets/icons/logo.png",
              color: Colors.white,
            ),
            title: Text(
              'DOR 2 DOR',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: colors.white,
                ),
                onPressed: () {
                  Get.to(() => const NotificationPage());
                },
              ),
            ],
          ),
          body: controller.currentPage == 0
              ? const HomePage()
              : controller.currentPage == 1
                  ? const OrdersPage()
                  : const MenuPage(),
          bottomNavigationBar: bottomNavigationBar(context),
        );
      },
    );
  }

  Widget bottomNavigationBar(context) {
    return BottomNavigationBar(
      currentIndex: controller.currentPage,
      onTap: (index) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (index == 0) {
          controller.getDashboard(context);
        } else if (index == 1) {
          OrderController orderController = Get.put(OrderController());
          if (prefs.getString('privilege') == '1') {
            orderController.getAllOrders(context);
          } else if (prefs.getString('privilege') == '2') {
            var storeId = prefs.getString("userId");
            orderController.getStoreOrders(context, storeId);
          }
        }
        controller.currentPage = index;
        controller.update();
      },
      elevation: 0,
      backgroundColor: colors.white,
      selectedItemColor: colors.primary,
      unselectedItemColor: colors.fontColor,
      selectedLabelStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: "home".tr,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.list_alt),
          label: "orders".tr,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.menu),
          label: "menu".tr,
        ),
      ],
    );
  }
}
