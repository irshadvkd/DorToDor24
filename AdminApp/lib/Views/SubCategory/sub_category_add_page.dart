import 'package:dortodorpartner/Controllers/SubCategory/sub_category_controller.dart';
import 'package:dortodorpartner/Helper/button_loader.dart';
import 'package:dortodorpartner/Helper/common_app_bar.dart';
import 'package:dortodorpartner/Helper/common_button.dart';
import 'package:dortodorpartner/Helper/common_text_field.dart';
import 'package:dortodorpartner/Helper/session.dart';
import 'package:dortodorpartner/Views/Home/image_upload_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoryAddPage extends GetView<SubCategoryController> {
  final String action;
  final int categoryId;
  final int? subCategoryId;
  final String? url;
  SubCategoryAddPage({
    Key? key,
    required this.action,
    required this.categoryId,
    this.subCategoryId,
    this.url,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubCategoryController>(
      builder: (controller) {
        return CommonAppBar(
          title: "${action == "create" ? "ADD" : "EDIT"} SUB CATEGORY",
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
          'Sub Category Name (English)',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonTextField(
            hintText: 'Enter sub category name in english',
            textController: controller.nameEng,
            maxLines: 1,
            validator: (value) => commonValidator(
                value, "Sub category name in english cannot be empty!"),
          ),
        ),
        Text(
          'Sub Category Name (Arabic)',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonTextField(
            hintText: 'Enter sub category name in arabic',
            textController: controller.nameAr,
            maxLines: 1,
            validator: (value) => commonValidator(
                value, "Sub category name in arabic cannot be empty!"),
          ),
        ),
        ImageUploadField(
          text: "Sub Category Image",
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
                  text: "${action == "create" ? "ADD" : "EDIT"} SUB CATEGORY",
                  width: 250,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      if (action == 'create') {
                        controller.addSubCategory(context, categoryId);
                      } else if (action == "edit") {
                        controller.updateSubCategory(
                            context, categoryId, subCategoryId);
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
