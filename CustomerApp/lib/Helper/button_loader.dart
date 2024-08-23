import 'package:flutter/material.dart';
import 'package:dorTodor24/Helper/colors.dart';

class ButtonLoader extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? radius;
  final Color? color;
  final Color? textColor;
  const ButtonLoader({
    Key? key,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.radius,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 40,
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: color ?? colors.primary,
        borderRadius: BorderRadius.circular(radius ?? 6),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: textColor ?? colors.white,
        ),
      ),
    );
  }
}
