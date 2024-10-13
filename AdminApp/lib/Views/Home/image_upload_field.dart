import 'dart:io';

import 'package:dortodorpartner/Controllers/Home/home_controller.dart';
import 'package:dortodorpartner/Helper/colors.dart';
import 'package:dortodorpartner/Helper/common_card.dart';
import 'package:dortodorpartner/Helper/common_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadField extends GetView<HomeController> {
  final String text;
  final String url;
  final String imageName;
  final double? xRatio;
  final double? yRatio;
  const ImageUploadField({
    super.key,
    required this.text,
    required this.url,
    required this.imageName,
    this.xRatio,
    this.yRatio,
  });

  @override
  Widget build(BuildContext context) {
    var imageText = imageName;
    if (controller.imageFile != null) {
      imageText = controller.imageFile!.path.toString().split("/").last;
    }
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            CommonCard(
              margin: const EdgeInsets.fromLTRB(0, 8, 0, 16),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              onTap: () async {
                final XFile? image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                CroppedFile? croppedFile = await ImageCropper().cropImage(
                  sourcePath: File(image!.path).path,
                  aspectRatio:
                      CropAspectRatio(ratioX: xRatio ?? 1, ratioY: yRatio ?? 1),
                  compressFormat: ImageCompressFormat.png,
                  uiSettings: [
                    AndroidUiSettings(
                      toolbarTitle: 'Cropper',
                      initAspectRatio: CropAspectRatioPreset.square,
                      lockAspectRatio: true,
                    ),
                    IOSUiSettings(
                      title: 'Cropper',
                      rectX: xRatio ?? 1,
                      rectY: yRatio ?? 1,
                      rotateButtonsHidden: true,
                      showCancelConfirmationDialog: true,
                      aspectRatioPickerButtonHidden: true,
                      aspectRatioLockEnabled: true,
                    ),
                  ],
                );
                controller.imageFile = XFile(croppedFile!.path);

                if (controller.imageFile != null) {
                  imageText =
                      controller.imageFile!.path.toString().split("/").last;
                }
                controller.update();
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      imageText != "" ? imageText : "Choose Image",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: colors.hintText),
                    ),
                  ),
                  const SizedBox(width: 16),
                  CommonCard(
                    height: 60,
                    width: 60,
                    child: controller.imageFile != null
                        ? Image.file(
                            File(controller.imageFile!.path),
                            fit: BoxFit.contain,
                          )
                        : url != ""
                            ? CommonImage(
                                url: url,
                                fit: BoxFit.contain,
                              )
                            : Image.asset(
                                "assets/icons/upload_image.png",
                                fit: BoxFit.contain,
                              ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
