import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hadirio/constants/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

TextTheme textTheme(BuildContext context) => Theme.of(context).textTheme;

Future<XFile?> pickImage() async {
  final imagePicker = ImagePicker();
  final pickedImage = await imagePicker.pickImage(
    source: ImageSource.gallery,
  );
  return pickedImage;
}

Uint8List? toImage(String? fileData) {
  if (fileData == null) return null;
  try {
    String base64String = fileData.replaceAll(RegExp(r'\s+'), '');

    while (base64String.length % 4 != 0) {
      base64String += '=';
    }
    return base64Decode(base64String);
  } catch (e) {
    log(e.toString(), name: 'Error to image');
    return null;
  }
}

bool isLate(String checkinStr) {
  DateTime checkinTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(checkinStr);
  DateTime comparisonTime = DateFormat('HH:mm:ss').parse(clockIn);
  comparisonTime = DateTime(
    checkinTime.year,
    checkinTime.month,
    checkinTime.day,
    comparisonTime.hour,
    comparisonTime.minute,
    comparisonTime.second,
  );
  return checkinTime.isAfter(comparisonTime);
}

int countDay(String start, String end) {
  DateTime startDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(start);
  DateTime endDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(end);
  return endDate.difference(startDate).inDays;
}
