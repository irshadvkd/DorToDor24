import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dortodorpartner/Helper/colors.dart';

class CommonTextField extends GetView {
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final String hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? inputStyle;
  final String? suffixLabel;
  final bool? enabled;
  final bool? obSecureText;
  final TextEditingController? textController;
  final FocusNode? focusNode;
  final Function(String)? onChange;
  final Function(String)? onSubmit;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final Widget? prefixIcon;
  final String? prefixText;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? cursorColor;
  final EdgeInsets? contentPadding;
  final String? Function(String?)? validator;
  final int? maxLines;
  final double? borderRadius;
  final Color? borderColor;
  final List<TextInputFormatter>? inputFormatter;
  const CommonTextField({
    Key? key,
    required this.hintText,
    this.labelText,
    this.hintStyle,
    this.keyboardType,
    this.textCapitalization,
    this.suffixLabel,
    this.textController,
    this.enabled,
    this.focusNode,
    this.onChange,
    this.onSubmit,
    this.enabledBorder,
    this.focusedBorder,
    this.prefixIcon,
    this.fillColor,
    this.validator,
    this.maxLines,
    this.borderRadius,
    this.borderColor,
    this.inputFormatter,
    this.cursorColor,
    this.contentPadding,
    this.prefixText,
    this.obSecureText,
    this.suffixIcon,
    this.inputStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obSecureText ?? false,
      textCapitalization: textCapitalization ?? TextCapitalization.words,
      enabled: enabled,
      controller: textController,
      keyboardType: keyboardType ?? TextInputType.text,
      style: inputStyle ?? Theme.of(context).textTheme.headlineSmall,
      focusNode: focusNode,
      maxLines: maxLines,
      onChanged: onChange,
      autofocus: false,
      onFieldSubmitted: onSubmit,
      inputFormatters: inputFormatter,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        prefixText: prefixText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefixStyle: Theme.of(context).textTheme.headlineSmall,
        prefixIconConstraints: const BoxConstraints(minWidth: 40),
        isDense: true,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 6),
          borderSide: BorderSide(color: borderColor ?? const Color(0x29000000)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 6),
          borderSide: BorderSide(color: borderColor ?? const Color(0x29000000)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 6),
          borderSide: BorderSide(color: borderColor ?? const Color(0x29000000)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 6),
          borderSide: BorderSide(color: borderColor ?? const Color(0x29000000)),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 6),
          borderSide: BorderSide(color: borderColor ?? const Color(0x29000000)),
        ),
        errorStyle: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: Colors.red, fontWeight: FontWeight.w400),
        // focusedBorder: focusedBorder ?? InputBorder.none,
        // enabledBorder: enabledBorder ?? InputBorder.none,
        // errorBorder: InputBorder.none,
        // disabledBorder: InputBorder.none,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.headlineSmall,
        hintText: hintText,
        hintStyle: hintStyle ??
            Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: colors.hintText),
        suffixText: suffixLabel,
        fillColor: fillColor ?? colors.white,
      ),
      validator: validator,
    );
  }
}
