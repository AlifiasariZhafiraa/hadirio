import 'package:flutter/material.dart';

/// for spacing
extension SpaceX on num {
  SizedBox get horizontalSpace => setHorizontalSpace(this);
  SizedBox get verticalSpace => setVerticalSpace(this);

  SizedBox setHorizontalSpace(num value) {
    return SizedBox(width: value.toDouble());
  }

  SizedBox setVerticalSpace(num value) {
    return SizedBox(height: value.toDouble());
  }
}
