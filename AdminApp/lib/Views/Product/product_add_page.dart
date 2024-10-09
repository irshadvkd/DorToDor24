import 'package:dortodorpartner/Controllers/Product/product_controller.dart';
import 'package:dortodorpartner/Helper/button_loader.dart';
import 'package:dortodorpartner/Helper/common_app_bar.dart';
import 'package:dortodorpartner/Helper/common_button.dart';
import 'package:dortodorpartner/Helper/common_text_field.dart';
import 'package:dortodorpartner/Helper/session.dart';
import 'package:dortodorpartner/Views/Home/image_upload_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductAddPage extends GetView<ProductController> {
  final String action;
  final int? productId;
  final int categoryId;
  final int subCategoryId;
  final String? url;
  ProductAddPage({
    Key? key,
    required this.action,
    this.productId,
    required this.categoryId,
    required this.subCategoryId,
    this.url,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        return CommonAppBar(
          title: "${action == "create" ? "ADD" : "EDIT"} PRODUCT",
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
          'Product Name (English)',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonTextField(
            hintText: 'Enter product name in english',
            textController: controller.nameEng,
            maxLines: 1,
            validator: (value) => commonValidator(
                value, "Product name in english cannot be empty!"),
          ),
        ),
        Text(
          'Product Name (Arabic)',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonTextField(
            hintText: 'Enter product name in arabic',
            textController: controller.nameAr,
            maxLines: 1,
            validator: (value) => commonValidator(
                value, "Product name in arabic cannot be empty!"),
          ),
        ),
        ImageUploadField(
          text: "Product Image",
          imageName: controller.imageName.text,
          url: url ?? "",
          xRatio: 5,
          yRatio: 3,
        ),
        Text(
          'Product Price',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonTextField(
            hintText: 'Enter product price',
            textController: controller.price,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            maxLines: 1,
            inputFormatter: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{1,3})?$')),
            ],
            validator: (value) =>
                commonValidator(value, "Product price cannot be empty!"),
          ),
        ),
        Text(
          'Product Unit (English)',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonTextField(
            hintText: 'Enter product unit in english',
            textController: controller.unitEng,
            maxLines: 1,
            validator: (value) => commonValidator(
                value, "Product unit in english cannot be empty!"),
          ),
        ),
        Text(
          'Product Unit (Arabic)',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonTextField(
            hintText: 'Enter product unit in arabic',
            textController: controller.unitAr,
            maxLines: 1,
            validator: (value) => commonValidator(
                value, "Product unit in arabic cannot be empty!"),
          ),
        ),
        Text(
          'Product Description (English)',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonTextField(
            hintText: 'Enter product description in english',
            textController: controller.descEng,
            maxLines: 5,
            validator: (value) => commonValidator(
                value, "Product description in english cannot be empty!"),
          ),
        ),
        Text(
          'Product Description (Arabic)',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonTextField(
            hintText: 'Enter product description in arabic',
            textController: controller.descAr,
            maxLines: 5,
            validator: (value) => commonValidator(
                value, "Product description in arabic cannot be empty!"),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
          child: controller.buttonLoader
              ? CommonButton(
                  text: "${action == "create" ? "ADD" : "EDIT"} PRODUCT",
                  width: 250,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      if (action == 'create') {
                        controller.addProduct(
                            context, categoryId, subCategoryId);
                      } else if (action == "edit") {
                        controller.updateProduct(
                            context, categoryId, subCategoryId, productId);
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
