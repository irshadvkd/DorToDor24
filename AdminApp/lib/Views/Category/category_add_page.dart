import 'package:dortodorpartner/Controllers/Category/category_controller.dart';
import 'package:dortodorpartner/Helper/button_loader.dart';
import 'package:dortodorpartner/Helper/common_app_bar.dart';
import 'package:dortodorpartner/Helper/common_button.dart';
import 'package:dortodorpartner/Helper/common_text_field.dart';
import 'package:dortodorpartner/Views/Home/image_upload_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryAddPage extends GetView<CategoryController> {
  final String action;
  final int? categoryId;
  final String? url;
  CategoryAddPage({
    Key? key,
    required this.action,
    this.categoryId,
    this.url,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (controller) {
        return CommonAppBar(
          title: 'CATEGORY',
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
          'Category Name (English)',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonTextField(
            hintText: 'Enter category name in english',
            textController: controller.nameEng,
            maxLines: 1,
          ),
        ),
        Text(
          'Category Name (Arabic)',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonTextField(
            hintText: 'Enter category name in arabic',
            textController: controller.nameAr,
            maxLines: 1,
          ),
        ),
        ImageUploadField(
          text: "Category Image",
          imageName: controller.imageName.text,
          url: url ?? "",
          xRatio: 16,
          yRatio: 13,
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
          child: controller.buttonLoader
              ? CommonButton(
                  text: "${action == 'create' ? "ADD" : "EDIT"} CATEGORY",
                  width: 250,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      if (action == 'create') {
                        controller.addCategory(context);
                      } else if (action == "edit") {
                        controller.updateCategory(context, categoryId);
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
