import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final int? maxLine;
  final Key? formKey;
  final String? hintText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Function(String)? onChange;
  final VoidCallback? onDone;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final double? contentPaddingHorizontal;
  final double? contentPaddingVertical;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? readOnly;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final TextCapitalization? textCapitalization;
  final FormFieldValidator<String>? onValidate;
  final List<TextInputFormatter>? inputFormatter;
  final int? maxLength;
  final bool obscureText;

  CustomTextField({
    this.controller,
    this.onValidate,
    this.focusNode,
    this.style,
    this.textInputType,
    this.suffixIcon,
    this.prefixIcon,
    this.formKey,
    this.maxLine,
    this.inputFormatter,
    this.readOnly = false,
    this.textInputAction,
    this.hintText = '',
    this.onChange,
    this.onDone,
    this.contentPadding,
    this.contentPaddingHorizontal,
    this.contentPaddingVertical,
    this.textCapitalization,
    this.maxLength,
    this.hintStyle,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: TextFormField(
        onChanged: onChange,
        readOnly: readOnly ?? false,
        controller: controller,
        validator: onValidate,
        focusNode: focusNode,
        cursorColor: Theme.of(context).primaryColor,
        style: style,
        maxLength: maxLength,
        keyboardType: textInputType,
        textInputAction: textInputAction ?? TextInputAction.newline,
        onEditingComplete: onDone,
        inputFormatters: inputFormatter,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          fillColor: Theme.of(context).dividerColor.withOpacity(0.1),
          hintStyle: hintStyle ?? Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey),
          errorStyle: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).errorColor),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(
                  vertical: contentPaddingVertical ?? 17.0, horizontal: contentPaddingHorizontal ?? 16.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).disabledColor, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        maxLines: maxLine ?? 1,
        obscureText: obscureText,
      ),
    );
  }
}
