import 'package:dorTodor24/Controllers/Cart/cart_controller.dart';
import 'package:dorTodor24/Controllers/Home/home_controller.dart';
import 'package:dorTodor24/Controllers/Product/product_controller.dart';
import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Views/Home/home_page.dart';
import 'package:dorTodor24/Views/Home/notification_page.dart';
import 'package:dorTodor24/Views/Menu/menu_page.dart';
import 'package:dorTodor24/Views/Product/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Auth/place_page.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  void initState() {
    final controller = Get.put(HomeController());
    controller.getHome(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: colors.white,
          appBar: AppBar(
            backgroundColor: colors.primary,
            leading: Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: Image.asset("assets/icons/logo.png"),
            ),
            title: Text(
              'DOR TO DOR 24',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.location_city,
                  color: colors.white,
                ),
                onPressed: () {
                  Get.to(() => const PlaceSelectPage());
                },
              ),
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
          body: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            child: controller.currentPage == 0
                ? const HomePage()
                : controller.currentPage == 1
                    ? const CartPage(hideAppBar: true)
                    : const MenuPage(),
          ),
          bottomNavigationBar: bottomNavigationBar(context),
        );
      },
    );
  }

  Widget bottomNavigationBar(context) {
    final controller = Get.put(HomeController());
    // var cartController = Get.put(CartController());
    return GetBuilder<CartController>(
      builder: (cartController) {
        return BottomNavigationBar(
          currentIndex: controller.currentPage,
          onTap: (index) {
            controller.currentPage = index;
            if (index == 1) {
              cartController.loadCartFromSession();
            }
            controller.update();
          },
          elevation: 0,
          backgroundColor: colors.white,
          selectedItemColor: colors.primary,
          unselectedItemColor: colors.secondary,
          selectedLabelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(Icons.shopping_cart_outlined),
                  if (cartController.cartItems.isNotEmpty)
                    Positioned(
                      top: -5,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: colors.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "${cartController.cartItems.length}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: colors.white),
                        ),
                      ),
                    ),
                ],
              ),
              label: "Cart",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.menu_rounded),
              label: "Menu",
            ),
          ],
        );
      },
    );
  }
}
