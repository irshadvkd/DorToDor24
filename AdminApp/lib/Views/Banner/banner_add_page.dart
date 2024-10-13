import 'package:dortodorpartner/Controllers/Banner/banner_controller.dart';
import 'package:dortodorpartner/Helper/button_loader.dart';
import 'package:dortodorpartner/Helper/common_app_bar.dart';
import 'package:dortodorpartner/Helper/common_button.dart';
import 'package:dortodorpartner/Helper/common_drop_down.dart';
import 'package:dortodorpartner/Helper/common_text_field.dart';
import 'package:dortodorpartner/Views/Home/image_upload_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerAddPage extends GetView<BannerController> {
  final String action;
  final int? bannerId;
  final String? url;
  BannerAddPage({
    Key? key,
    required this.action,
    this.bannerId,
    this.url,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(
      builder: (controller) {
        return CommonAppBar(
          title: 'Banner',
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
          'Banner Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonTextField(
            hintText: 'Enter banner name',
            textController: controller.name,
            maxLines: 1,
          ),
        ),
        Text(
          'Banner Section',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonDropDown(
            hintText: "Select banner section",
            list: const [
              {"id": "0", "name": "Main Page"},
              {"id": "1", "name": "Sub Page"}
            ],
            selected: controller.selectedType,
            onChange: (value) {
              controller.selectedType = value as String;
              controller.update();
            },
          ),
        ),
        ImageUploadField(
          text: "Banner Image",
          imageName: controller.imageName.text,
          url: url ?? "",
          xRatio: 3,
          yRatio: 1,
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
          child: controller.buttonLoader
              ? CommonButton(
                  text: "${action == 'create' ? "ADD" : "EDIT"} BANNER",
                  width: 250,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      if (action == 'create') {
                        controller.addBanner(context);
                      } else if (action == "edit") {
                        controller.updateBanner(context, bannerId);
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
