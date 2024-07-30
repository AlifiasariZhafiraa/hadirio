import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeX on DateTime? {
  String toFormatGeneralDate() {
    if (this == null) {
      return '-';
    }
    try {
      DateFormat dateFormat = DateFormat('dd MMM yyyy');

      return dateFormat.format(this!);
    } catch (_) {
      return '-';
    }
  }

  String toFormatShorDate() {
    if (this == null) {
      return '-';
    }
    try {
      DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');

      return dateFormat.format(this!);
    } catch (_) {
      return '-';
    }
  }

  String toFormatTime() {
    if (this == null) {
      return '-';
    }
    try {
      DateFormat dateFormat = DateFormat('HH:mm');

      return dateFormat.format(this!);
    } catch (_) {
      return '-';
    }
  }

  String toFormatDateParams() {
    if (this == null) {
      return '-';
    }
    try {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

      return dateFormat.format(this!);
    } catch (_) {
      return '-';
    }
  }

  String toShortDateParams() {
    if (this == null) {
      return '-';
    }
    try {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');

      return dateFormat.format(this!);
    } catch (_) {
      return '-';
    }
  }

  String replaceStartDateParams() {
    if (this == null) {
      return '-';
    }
    try {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');

      String data = dateFormat.format(this!);
      return '$data 00:00:00';
    } catch (_) {
      return '-';
    }
  }

  String replaceEndDateParams() {
    if (this == null) {
      return '-';
    }
    try {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');

      String data = dateFormat.format(this!);
      return '$data 23:59:59';
    } catch (_) {
      return '-';
    }
  }
}

extension StringDate on String? {
  DateTime toFormatDateToDate() {
    if (this == null) {
      return DateTime.now();
    }
    try {
      DateTime date = DateFormat("yyyy-MM-dd HH:mm:ss").parse(this!);

      return date;
    } catch (_) {
      return DateTime.now();
    }
  }
}

extension StringTimeX on String? {
  String toFormatDate() {
    if (this == null) {
      return '-';
    }
    try {
      DateTime tempDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(this!);

      return tempDate.toFormatGeneralDate();
    } catch (_) {
      return '-';
    }
  }

  String toFormatShortDate() {
    if (this == null) {
      return '-';
    }
    try {
      DateTime tempDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(this!);

      return tempDate.toFormatShorDate();
    } catch (_) {
      return '-';
    }
  }

  String toShortDateParams() {
    if (this == null) {
      return '-';
    }
    try {
      DateTime tempDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(this!);

      return tempDate.toShortDateParams();
    } catch (_) {
      return '-';
    }
  }

  String toFormatTime() {
    if (this == null) {
      return '-';
    }
    try {
      DateTime tempDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(this!);

      return tempDate.toFormatTime();
    } catch (_) {
      return '-';
    }
  }

  String replaceStartDateParams() {
    if (this == null) {
      return '-';
    }
    try {
      DateTime tempDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(this!);

      return tempDate.replaceStartDateParams();
    } catch (_) {
      return '-';
    }
  }

  String replaceEndDateParams() {
    if (this == null) {
      return '-';
    }
    try {
      DateTime tempDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(this!);

      return tempDate.replaceEndDateParams();
    } catch (_) {
      return '-';
    }
  }
}

extension DateRangeX on DateTimeRange? {
  String formatGeneral() {
    if (this == null) {
      return 'Pilih tanggal';
    }
    try {
      String start = this!.start.toFormatGeneralDate();
      String end = this!.end.toFormatGeneralDate();
      return '$start - $end';
    } catch (e) {
      log(e.toString());
      return '-';
    }
  }
}
