import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:dortodorpartner/Helper/common_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return controller.homeLoader?SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    dashboardItemCard(
                      context,
                      "Total Orders",
                      controller.dashboardModal!.total,
                    ),
                    dashboardItemCard(
                      context,
                      "Pending Orders",
                      controller.dashboardModal!.pending,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    dashboardItemCard(
                      context,
                      "Processing Orders",
                      controller.dashboardModal!.processing,
                    ),
                    dashboardItemCard(
                      context,
                      "Shipped Orders",
                      controller.dashboardModal!.shipped,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    dashboardItemCard(
                      context,
                      "Completed Orders",
                      controller.dashboardModal!.completed,
                    ),
                    dashboardItemCard(
                      context,
                      "Cancelled Orders",
                      controller.dashboardModal!.cancelled,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ):const Center(child: CupertinoActivityIndicator());
      },
    );
  }

  Widget dashboardItemCard(context, title, count) {
    return CommonCard(
      height: 150,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          Text(
            count.toString(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
