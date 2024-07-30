import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hadirio/configs/app_colors.dart';
import 'package:hadirio/utils/function.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.formatter,
    this.controller,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.minLines,
    this.maxLines,
    this.readOnly = false,
    this.textAlign = TextAlign.center,
  });

  final String hint;
  final List<TextInputFormatter>? formatter;
  final TextEditingController? controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final int? minLines;
  final int? maxLines;
  final bool readOnly;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            readOnly: readOnly,
            textAlignVertical: TextAlignVertical.center,
            controller: controller,
            obscureText: inputType == TextInputType.visiblePassword,
            obscuringCharacter: '*',
            inputFormatters: formatter,
            textAlign: textAlign,
            style: textTheme(context).displayMedium,
            minLines: minLines,
            maxLines: inputType == TextInputType.visiblePassword ? 1 : maxLines,
            decoration: InputDecoration(
              isDense: true,
              hintText: hint,
              fillColor: AppColors.blackColorAFAFAF.withOpacity(0.3),
              filled: readOnly,
              hintStyle: textTheme(context).displayMedium?.copyWith(
                    color: AppColors.blackColor9AA4B2,
                  ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.blackColorAFAFAF),
              ),
              contentPadding: const EdgeInsets.all(
                20,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.blackColor1E1E1E),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.blackColorAFAFAF),
              ),
            ),
            keyboardType: inputType,
            textInputAction: inputAction,
          ),
        ],
      ),
    );
  }
}
