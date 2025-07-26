// import 'package:country_code_picker/country_code_picker.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_filed_box.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController? controller;
  final bool isPassword;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final Color? color;
  final Widget? suffixIcon;
  final bool readOnly;
  final FocusNode? focusNode;
  final int? line;
  final int? maxLength;
  final Color? fillColor;
  final Color? borderColor;
  final TextCapitalization? textCapitalization;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.isPassword = false,
    this.readOnly = false,
    this.prefixIcon,
    this.borderColor,
    this.suffixIcon,
    this.maxLength,
    this.onChanged,
    this.color,
    required this.labelText,
    this.focusNode,
    this.fillColor,
    this.textCapitalization,
    this.keyboardType = TextInputType.text,
    this.line = 1,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          readOnly: readOnly,
          focusNode: focusNode,
          maxLines: line,
          minLines: line,
          maxLength: maxLength,

          onTap: onTap,
          onChanged: onChanged,
          cursorColor: AppColor.themePrimaryColor,
          style: TextStyle(color: AppColor.themePrimaryColor),
          textCapitalization:
              textCapitalization ?? TextCapitalization.sentences,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: hintText,
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'DM Sans',

              color: AppColor.themePrimaryColor,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            fillColor: fillColor ?? AppColor.whiteColor,
            hintStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: 'DM Sans',

              color: color ?? AppColor.hintColor,
            ),
            filled: true,

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: borderColor ?? AppColor.themePrimaryColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: borderColor ?? AppColor.themePrimaryColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: borderColor ?? AppColor.themePrimaryColor,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: borderColor ?? AppColor.themePrimaryColor,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropWonFiled<T> extends StatelessWidget {
  final String text;
  final T? initialItem;
  final String? hintText;
  final String title;
  final List<T> items;
  final dynamic Function(T?) onChanged;
  final Color? selectColor;
  final Widget Function(BuildContext, T, bool, void Function())?
  listItemBuilder;
  const CustomDropWonFiled({
    super.key,
    required this.text,
    this.initialItem,
    this.hintText,
    this.selectColor,
    this.listItemBuilder,
    required this.items,
    required this.title,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFieldBox(
      title: title,
      fontSize: 12,
      padding: EdgeInsets.zero,
      children: [
        CustomDropdown<T>(
          hintText: hintText,

          closedHeaderPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),

          decoration: CustomDropdownDecoration(
            closedBorder: Border.all(color: AppColor.transparentColor),

            hintStyle: TextStyle(
              fontFamily: 'Caros Soft',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColor.hintColor,
            ),
            headerStyle: TextStyle(
              fontFamily: 'Caros Soft',
              fontSize: 12,
              color: selectColor,
              fontWeight: FontWeight.w500,
            ),
            listItemStyle: TextStyle(
              fontFamily: 'Caros Soft',
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          listItemBuilder: listItemBuilder,
          items: items,
          initialItem: initialItem,

          onChanged: onChanged,
        ),
      ],
    );
  }
}
