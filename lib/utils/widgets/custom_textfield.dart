// import 'package:country_code_picker/country_code_picker.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_filed_box.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';
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
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.inputFormatters,
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
    this.validator,
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
          validator: validator,
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
          inputFormatters: inputFormatters,
          style: TextStyle(color: AppColor.themePrimaryColor),
          textCapitalization:
              textCapitalization ?? TextCapitalization.sentences,
          decoration: InputDecoration(
            counterText: '',
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

class CustomDropWonFiled<T> extends StatefulWidget {
  final String text;
  final T? initialItem;
  final String? hintText;
  final String title;
  final List<T> items;
  final dynamic Function(T?) onChanged;
  final Color? selectColor;
  final String? Function(T?)? validator;
  final Widget Function(BuildContext, T, bool, void Function())?
  listItemBuilder;
  const CustomDropWonFiled({
    super.key,
    required this.text,
    this.validator,
    this.initialItem,
    this.hintText,
    this.selectColor,
    this.listItemBuilder,
    required this.items,
    required this.title,
    required this.onChanged,
  });

  @override
  State<CustomDropWonFiled<T>> createState() => _CustomDropWonFiledState<T>();
}

class _CustomDropWonFiledState<T> extends State<CustomDropWonFiled<T>> {
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialItem;
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => _DropdownBottomSheet<T>(
            items: widget.items,
            selectedItem: _selectedItem,
            hintText: widget.hintText ?? 'Search...',
            onItemSelected: (item) {
              setState(() {
                _selectedItem = item;
              });
              widget.onChanged(item);
              Navigator.pop(context);
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomFieldBox(
      title: widget.title,
      fontSize: 12,
      padding: EdgeInsets.zero,
      children: [
        InkWell(
          onTap: _showBottomSheet,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            // decoration: BoxDecoration(
            //   color: AppColor.whiteColor,
            //   borderRadius: BorderRadius.circular(12),
            //   border: Border.all(color: AppColor.themePrimaryColor),
            // ),
            child: Row(
              children: [
                Expanded(
                  child: CustomText(
                    text:
                        _selectedItem?.toString() ??
                        widget.hintText ??
                        'Select',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color:
                        _selectedItem != null
                            ? widget.selectColor ?? AppColor.themePrimaryColor
                            : AppColor.hintColor,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: AppColor.hintColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DropdownBottomSheet<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final String hintText;
  final Function(T) onItemSelected;

  const _DropdownBottomSheet({
    required this.items,
    required this.selectedItem,
    required this.hintText,
    required this.onItemSelected,
  });

  @override
  State<_DropdownBottomSheet<T>> createState() =>
      _DropdownBottomSheetState<T>();
}

class _DropdownBottomSheetState<T> extends State<_DropdownBottomSheet<T>> {
  late List<T> _filteredItems;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = widget.items;
      } else {
        _filteredItems =
            widget.items
                .where(
                  (item) => item.toString().toLowerCase().contains(
                    query.toLowerCase(),
                  ),
                )
                .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: _filterItems,
              decoration: InputDecoration(
                hintText: widget.hintText,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                final isSelected = item == widget.selectedItem;
                return ListTile(
                  title: Text(
                    item.toString(),
                    style: TextStyle(
                      fontFamily: 'Caros Soft',
                      fontSize: 14,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                      color:
                          isSelected
                              ? AppColor.themePrimaryColor
                              : Colors.black,
                    ),
                  ),
                  trailing:
                      isSelected
                          ? Icon(Icons.check, color: AppColor.themePrimaryColor)
                          : null,
                  onTap: () => widget.onItemSelected(item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
