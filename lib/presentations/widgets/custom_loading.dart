import 'package:flutter/material.dart';
import 'package:hadirio/configs/app_colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key, this.height});

  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 200,
      width: double.infinity,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
