import 'package:flutter/material.dart';

class DialogHelper {
  const DialogHelper._();

  static const opacity0_5 = 0.5;
  static const double strokeWidth = 8;

  static Future<void> showLoadingDialog(
    BuildContext context, {
    bool popped = false,
  }) {
    return showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(opacity0_5),
      pageBuilder: (_, __, ___) {
        return PopScope(
          canPop: popped,
          child: Center(
            child: Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: const CircularProgressIndicator(
                strokeWidth: strokeWidth,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
