import 'package:dorTodor24/Controllers/Home/home_controller.dart';
import 'package:dorTodor24/Helper/common_app_bar.dart';
import 'package:dorTodor24/Helper/common_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends GetView<HomeController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return CommonAppBar(
          title: "Notifications",
          actionEnable: false,
          child: ListView.builder(
            itemCount: controller.notifications.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              return notificationCard(context, controller.notifications[index]);
            },
          ),
        );
      },
    );
  }

  Widget notificationCard(context, currentIndex) {
    return CommonCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  currentIndex['title'],
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Text(
                currentIndex['date'],
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            currentIndex['desc'],
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
