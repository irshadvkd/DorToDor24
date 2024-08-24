import 'package:dorTodor24/Helper/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageView extends StatelessWidget {
  final String image;
  const ImageView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      title: "Image Viewer",
      actionEnable: false,
      child: PhotoViewGallery.builder(
        itemCount: 1,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(image),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: const BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }
}
