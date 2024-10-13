import 'package:dortodorpartner/Controllers/Store/store_controller.dart';
import 'package:dortodorpartner/Helper/button_loader.dart';
import 'package:dortodorpartner/Helper/common_app_bar.dart';
import 'package:dortodorpartner/Helper/common_button.dart';
import 'package:dortodorpartner/Helper/common_drop_down.dart';
import 'package:dortodorpartner/Helper/common_text_field.dart';
import 'package:dortodorpartner/Helper/session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreAddPage extends GetView<StoreController> {
  final String action;
  final int? storeId;
  final String? url;
  StoreAddPage({
    Key? key,
    required this.action,
    this.storeId,
    this.url,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      builder: (controller) {
        return CommonAppBar(
          title: 'STORE',
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
          'Store Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonTextField(
            hintText: 'Enter store name',
            textController: controller.name,
            maxLines: 1,
          ),
        ),
        Text(
          'Email',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonTextField(
            hintText: 'Enter email id',
            textController: controller.email,
            textCapitalization: TextCapitalization.none,
            maxLines: 1,
          ),
        ),
        Text(
          'Phone',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonTextField(
            hintText: 'Enter phone number',
            textController: controller.phone,
            maxLines: 1,
          ),
        ),
        if(action=="create")
        Text(
          'Password',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        if(action=="create")
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonTextField(
            hintText: 'Enter password',
            textController: controller.password,
            maxLines: 1,
            validator: (value) =>
                commonValidator(value, "Password cannot be empty!"),
          ),
        ),
        Text(
          'Governorate',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonDropDown(
            hintText: "Select governorate",
            list: controller.governorate,
            selected: controller.selectedGovernorate,
            onChange: (value) {
              controller.selectedGovernorate = value as String;
              controller.city.clear();
              controller.selectedCity = "";
              controller.block.clear();
              controller.selectedBlock = "";
              controller.addCityToList();
              controller.update();
            },
          ),
        ),
        Text(
          'City',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonDropDown(
            hintText: "Select city",
            list: controller.city,
            selected: controller.selectedCity,
            onChange: (value) {
              controller.selectedCity = value as String;
              controller.block.clear();
              controller.selectedBlock = "";
              controller.addBlockToList();
              controller.update();
            },
          ),
        ),
        Text(
          'Block',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonDropDown(
            hintText: "Select block",
            list: controller.block,
            selected: controller.selectedBlock,
            onChange: (value) {
              controller.selectedBlock = value as String;
              controller.update();
            },
          ),
        ),
        Text(
          'Active Status',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: CommonDropDown(
            hintText: "Select active status",
            list: const [
              {"id": "0", "name": "Available"},
              {"id": "1", "name": "Not Available"},
            ],
            selected: controller.selectedStatus,
            onChange: (value) {
              controller.selectedStatus = value as String;
              controller.update();
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
          child: controller.buttonLoader
              ? CommonButton(
                  text: action == 'create' ? "CREATE" : "UPDATE",
                  width: 200,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      if (action == 'create') {
                        controller.addStore(context);
                      } else if (action == "edit") {
                        controller.updateStore(context, storeId);
                      }
                    }
                  },
                )
              : const ButtonLoader(width: 200),
        ),
      ],
    );
  }
}
