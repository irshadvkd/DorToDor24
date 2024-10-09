import 'package:dortodorpartner/Controllers/Location/location_controller.dart';
import 'package:dortodorpartner/Helper/button_loader.dart';
import 'package:dortodorpartner/Helper/common_app_bar.dart';
import 'package:dortodorpartner/Helper/common_button.dart';
import 'package:dortodorpartner/Helper/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CityAddPage extends GetView<LocationController> {
  final String action;
  final int governorateId;
  final int? cityId;
  CityAddPage({
    Key? key,
    required this.action,
    required this.governorateId,
    this.cityId,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (controller) {
        return CommonAppBar(
          title: 'City',
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: formUI(context),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget formUI(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'City Name (English)',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonTextField(
            hintText: 'Enter city name in english',
            textController: controller.nameEng,
            maxLines: 1,
          ),
        ),
        Text(
          'City Name (Arabic)',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonTextField(
            hintText: 'Enter city name in arabic',
            textController: controller.nameAr,
            maxLines: 1,
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
          child: controller.buttonLoader
              ? CommonButton(
                  text: "${action == 'create' ? "ADD" : "EDIT"} CITY",
                  width: 250,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      if (action == 'create') {
                        controller.addCity(context, governorateId);
                      } else if (action == "edit") {
                        controller.updateCity(context, governorateId, cityId);
                      }
                    }
                  },
                )
              : const ButtonLoader(width: 250),
        ),
      ],
    );
  }
}
