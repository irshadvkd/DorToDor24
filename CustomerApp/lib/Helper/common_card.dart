import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dorTodor24/Helper/colors.dart';

class CommonCard extends GetView {
  const CommonCard({
    Key? key,
    this.width,
    this.height,
    required this.child,
    this.onTap,
    this.borderRadius,
    this.margin,
    this.padding,
    this.color,
    this.boxShadowEnable,
  }) : super(key: key);
  final double? height;
  final double? width;
  final Function()? onTap;
  final Widget child;
  final double? borderRadius;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? color;
  final bool? boxShadowEnable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: margin ?? const EdgeInsets.all(0),
        padding: padding ?? const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: color ?? colors.white,
          boxShadow: boxShadowEnable != false
          ? [
            BoxShadow(
                color: colors.black.withOpacity(.10),
                offset: const Offset(0, 2),
                blurRadius: 2),
            BoxShadow(
                color: colors.black.withOpacity(.10),
                offset: const Offset(0, 2),
                blurRadius: 2),
          ]
            : null,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 11)),
        ),
        child: child,
      ),
    );
  }
}
