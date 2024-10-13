import 'package:dorTodor24/Controllers/Home/home_controller.dart';
import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Helper/common_app_bar.dart';
import 'package:dorTodor24/Views/Menu/edit_user_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAccountPage extends GetView<HomeController> {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return CommonAppBar(
          appBarColor: true,
          BarColor: colors.themeButton,
          title: "Edit Account Details",
          actionEnable: false,
          child: SafeArea(
            child: Column(
              children: [
                // Top profile section with gradient background
                Stack(
                  clipBehavior:
                  Clip.none, // This allows the CircleAvatar to overflow
                  alignment: Alignment.center, // Center the Stack elements
                  children: [
                    // Background design (purple gradient)
                    Container(
                      height:
                      200, // Adjust the height of the gradient container
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [colors.themeButton, colors.white],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),

                    // Name
                    Positioned(
                      top: 50,
                      child: Text(
                        controller.name.text,
                        style: const TextStyle(
                          color: colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),

                    // Circular profile picture
                    const Positioned(
                      bottom: -80,
                      child: Material(
                        elevation: 4,
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 75,
                            backgroundImage:
                            AssetImage('assets/icons/logo.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 100), // Spacing after the avatar

                const SizedBox(height: 20),
                Column(
                  children: [
                    // Edit Button
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Get.to(const EditUserDetails());
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: colors.themeButton,
                            ),
                            child: const Text(
                              'Edit',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Post, Followers, Following Stats
                    _StatItem(label: 'Email', value: controller.email.text),
                    const SizedBox(height: 10),
                    _StatItem(label: 'Phone', value: controller.phone.text),
                    const SizedBox(height: 40),
                    // ForgetPass Button
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        side: const BorderSide(color: colors.themeButton),
                      ),
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(fontSize: 16, color: colors.textMain),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

// Widget for Stats (Post, Followers, Following)
class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontSize: 18,
                color: colors.textMain,),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}