import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Views/Home/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/common_button.dart';
import '../Menu/order_page.dart';

class OrderSuccessPopup extends StatefulWidget {
  const OrderSuccessPopup({super.key});

  @override
  _OrderSuccessPopupState createState() => _OrderSuccessPopupState();
}

class _OrderSuccessPopupState extends State<OrderSuccessPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(200),
                topRight: Radius.circular(200),
            ),
          ),
          padding: EdgeInsets.only(
            top: 180,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Order Success',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'You spent \$8.9 and saved \$90.8',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              CommonButton(
                width: 220,
                color: colors.themeButton,
                text: "Back to home",
                height: 50,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: colors.white, fontWeight: FontWeight.w600),
                onTap: () {
                  Get.offAllNamed("/home");
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.to(const OrdersPage());
                },
                child: Text(
                  'View order detail',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: Center(
            child: AnimatedBuilder(
              animation: _controller,
              // child: const Icon(
              //   Icons.shopping_cart,
              //   size: 60,
              //   color: Colors.green,
              // ),
              child: const Image(
                image: AssetImage('assets/icons/dortodor_ordercomplete.png'),
                width: 200,
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.translate(
                  offset: Offset(0, -10 * (1.0 - _controller.value)),
                  child: child,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

void showOrderSuccessPopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      height: 400,
      color: Colors.transparent,
      child: const OrderSuccessPopup(),
    ),
  );
}

