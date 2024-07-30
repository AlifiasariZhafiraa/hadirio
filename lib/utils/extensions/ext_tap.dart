import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension ExtGesture on Widget {
  Widget extCupertino({
    VoidCallback? onTap,
    bool useMaterial = false,
    bool transparentIfTapNull = true,
  }) {
    final button = CupertinoButton(
      minSize: 0,
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: useMaterial
          ? Material(
              color: Colors.transparent,
              child: this,
            )
          : this,
    );

    if (transparentIfTapNull && onTap == null) {
      return Opacity(
        opacity: 0.5,
        child: button,
      );
    }

    return button;
  }
}
