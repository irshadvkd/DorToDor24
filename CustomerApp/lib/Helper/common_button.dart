import 'package:flutter/material.dart';
import 'package:dorTodor24/Helper/colors.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? radius;
  final Color? color;
  final double? textSize;
  final Color? textColor;
  final TextStyle? style;
  final Function() onTap;
  const CommonButton({
    super.key,
    required this.text,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.radius,
    this.color,
    this.style,
    this.textSize,
    this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 40,
        margin: margin ?? EdgeInsets.zero,
        alignment: Alignment.center,
        padding: padding ?? const EdgeInsets.fromLTRB(13, 6, 13, 6),
        decoration: BoxDecoration(
          color: color ?? colors.primary,
          borderRadius: BorderRadius.circular(radius ?? 6),
        ),
        child: Text(
          text,
          style: style ??
              Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: textColor ?? colors.white,
                  fontSize: textSize,
                  fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
