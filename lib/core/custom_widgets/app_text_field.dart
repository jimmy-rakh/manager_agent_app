import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/is_dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final VoidCallback? onFieldTap;
  final TextEditingController? fieldController;
  final double height;
  final Widget? prefix;
  final EdgeInsets? prefixPadding;
  final Widget? suffix;
  final TextInputType? textInputType;
  final Color? fillColor;
  final bool autoFocus;
  final FocusNode? focusNode;
  final void Function(String)? onChange;
  final List<TextInputFormatter> textInputFormatter;
  final bool readOnly;
  final int? maxLength;
  final int maxLines;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;
  final bool? alignLabelWithHint;
  final bool obscureText;

  const AppTextField(
      {Key? key,
      this.isRequired = false,
      required this.label,
      this.onFieldTap,
      this.fieldController,
      this.height = 55,
      this.suffix,
      this.prefix,
      this.textInputType = TextInputType.text,
      this.fillColor,
      this.autoFocus = false,
      this.focusNode,
      this.onChange,
      this.prefixPadding,
      this.readOnly = false,
      this.textInputFormatter = const [],
      this.maxLength,
      this.validator,
      this.textCapitalization = TextCapitalization.none,
      this.maxLines = 1,
      this.alignLabelWithHint,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkModeEnabled(context);
    final Color bgColor = fillColor != null
        ? fillColor!
        : Theme.of(context).colorScheme.background;
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      readOnly: readOnly,
      validator: validator,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16),
      onTap: onFieldTap,
      maxLength: maxLength,
      focusNode: focusNode,
      controller: fieldController,
      keyboardType: textInputType,
      autofocus: autoFocus,
      inputFormatters: textInputFormatter,
      onChanged: onChange,
      textCapitalization: textCapitalization,
      cursorColor: Theme.of(context).primaryColor,
      maxLines: maxLines,
      obscureText: obscureText,
      decoration: InputDecoration(
        counterText: "",
        prefixIcon: prefix != null
            ? Padding(
                padding: prefixPadding ?? const EdgeInsets.all(16.0),
                child: prefix,
              )
            : null,
        suffixIcon: suffix,
        isDense: true,
        filled: true,
        labelText: '$label ${isRequired ? '*' : ''}',
        alignLabelWithHint: alignLabelWithHint,
        fillColor: bgColor,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: isDark ? AppColors.white : Theme.of(context).primaryColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
