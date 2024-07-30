import 'package:flutter/material.dart';
import 'package:hadirio/configs/app_colors.dart';
import 'package:hadirio/models/my_dropdown_item.dart';
import 'package:hadirio/utils/function.dart';

class CustomDropdown extends StatelessWidget {
  final String hint;
  final Function(dynamic)? onChange;
  final List<MyDropdownItem> items;
  final MyDropdownItem? value;
  final double? height;
  final double? width;
  final bool isLoading;
  final bool isError;
  final Function()? onRefresh;

  const CustomDropdown({
    super.key,
    required this.onChange,
    required this.items,
    this.value,
    required this.hint,
    this.height,
    this.isLoading = false,
    this.isError = false,
    this.onRefresh,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<MyDropdownItem>> dropdowns =
        items.map<DropdownMenuItem<MyDropdownItem>>((item) {
      return DropdownMenuItem<MyDropdownItem>(
        alignment: Alignment.center,
        value: item,
        child: Text(
          item.value,
          style: textTheme(context).displayMedium?.copyWith(
                color: AppColors.blackColor101828,
              ),
          textAlign: TextAlign.center,
        ),
      );
    }).toList();

    Widget child;
    if (isLoading) {
      child = Text(
        '...',
        style: textTheme(context).displayMedium?.copyWith(
              color: AppColors.blackColor101828,
            ),
      );
    } else if (items.isEmpty) {
      child = Text(
        'Data Kosong',
        style: textTheme(context).displayMedium?.copyWith(
              color: AppColors.blackColor101828,
            ),
      );
    } else {
      child = DropdownButtonHideUnderline(
        child: DropdownButton<MyDropdownItem>(
          menuMaxHeight: MediaQuery.of(context).size.height * 0.35,
          elevation: 1,
          dropdownColor: Colors.white,
          hint: Text(
            hint,
            style: textTheme(context).displayMedium?.copyWith(
                  color: AppColors.blackColor9AA4B2,
                ),
            textAlign: TextAlign.center,
          ),
          isDense: false,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          isExpanded: true,
          value: value,
          alignment: Alignment.center,
          icon: const SizedBox(),
          style: textTheme(context).displayMedium?.copyWith(
                color: AppColors.blackColor101828,
              ),
          onChanged: onChange,
          items: dropdowns,
        ),
      );
    }

    return Container(
      width: width,
      margin: const EdgeInsets.only(top: 20),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            padding: const EdgeInsets.only(
              left: 14,
              right: 7,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.blackColorAFAFAF,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
