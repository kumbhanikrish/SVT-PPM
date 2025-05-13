// import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
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
  final void Function()? onTap;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.isPassword = false,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.onChanged,
    this.color,
    required this.labelText ,
    this.focusNode,
    this.fillColor,
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
              borderSide: BorderSide(color: AppColor.themePrimaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.themePrimaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.themePrimaryColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.themePrimaryColor),
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

// class CustomCountyTextfield extends StatelessWidget {
//   final TextEditingController controller;
//   final void Function(CountryCode) onChanged;
//   final String initialSelection;
//   const CustomCountyTextfield({
//     super.key,
//     required this.controller,
//     required this.onChanged,
//     required this.initialSelection,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return CustomTextField(
//       hintText: 'Number',
//       keyboardType: TextInputType.number,
//       controller: controller,
//       prefixIcon: CountryCodePicker(
//         margin: const EdgeInsets.only(right: 10),
//         onChanged: onChanged,
//         initialSelection: initialSelection,
//         favorite: const ["+91", "IN"],
//         showCountryOnly: false,
//         showOnlyCountryWhenClosed: false,
//         alignLeft: false,
//       ),
//     );
//   }
// }

// class CustomTypeAheadField<T> extends StatelessWidget {
//   final TextEditingController controller;
//   final List<T> Function(String) suggestionsCallback;
//   final void Function(T) onSelected;
//   final String hintText;
//   final Widget Function(BuildContext, T) itemBuilder;

//   const CustomTypeAheadField({
//     super.key,
//     required this.controller,
//     required this.suggestionsCallback,
//     required this.onSelected,
//     required this.hintText,
//     required this.itemBuilder,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TypeAheadField<T>(
//       suggestionsCallback: suggestionsCallback,
//       controller: controller,
//       builder: (context, controller, focusNode) {
//         return CustomTextField(
//           controller: controller,
//           hintText: hintText,
//           focusNode: focusNode,
//           suffixIcon: Icon(
//             Icons.arrow_drop_down_rounded,
//             color: AppColor.themePrimary2Color,
//           ),
//         );
//       },
//       itemBuilder: itemBuilder,
//       onSelected: onSelected,
//     );
//   }
// }

// class City {
//   final String name;
//   final String country;

//   City({required this.name, required this.country});
// }

// class CityService {
//   static List<City> cities = [
//     City(name: 'New York', country: 'USA'),
//     City(name: 'London', country: 'UK'),
//     City(name: 'Paris', country: 'France'),
//     City(name: 'Tokyo', country: 'Japan'),
//   ];

//   static List<City> find(String query) {
//     return cities
//         .where((city) => city.name.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//   }
// }
