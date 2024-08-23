import 'package:dorTodor24/Controllers/Home/home_controller.dart';
import 'package:dorTodor24/Controllers/Product/product_controller.dart';
import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Views/Home/home_page.dart';
import 'package:dorTodor24/Views/Home/notification_page.dart';
import 'package:dorTodor24/Views/Menu/menu_page.dart';
import 'package:dorTodor24/Views/Product/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            backgroundColor: colors.white,
            leading: Container(),
            leadingWidth: 0,
            title: Text(
              'CP STORE',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: colors.textMain),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: colors.textMain,
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
                    ? const CartPage()
                    : const MenuPage(),
          ),
          bottomNavigationBar: bottomNavigationBar(context),
        );
      },
    );
  }

  Widget bottomNavigationBar(context) {
    final controller = Get.put(HomeController());
    return BottomNavigationBar(
      currentIndex: controller.currentPage,
      onTap: (index) {
        controller.currentPage = index;
        if (index == 1) {
          var productController = Get.put(ProductController());
          productController.getCart(context);
        }
        controller.update();
      },
      elevation: 0,
      backgroundColor: colors.white,
      selectedItemColor: colors.green,
      unselectedItemColor: colors.textMain,
      selectedLabelStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: "Cart",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_rounded),
          label: "Menu",
        ),
      ],
    );
  }
}
