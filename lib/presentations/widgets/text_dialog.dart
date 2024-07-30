// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hadirio/utils/extensions/space_x.dart';
import 'package:hadirio/utils/function.dart';

class TextDialog extends StatelessWidget {
  const TextDialog({
    super.key,
    required this.text,
    this.textBtn,
    this.onTap,
  });

  final String text;
  final String? textBtn;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              20.verticalSpace,
              Text(
                text,
                style: textTheme(context).titleMedium,
                textAlign: TextAlign.center,
              ),
              40.verticalSpace,
              ElevatedButton(
                onPressed: onTap ?? Get.back,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(40, Platform.isIOS ? 45 : 50),
                ),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
