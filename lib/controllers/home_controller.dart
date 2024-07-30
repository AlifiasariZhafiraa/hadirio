import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hadirio/api/repository.dart';
import 'package:hadirio/configs/app_route.dart';
import 'package:hadirio/enums/presence_type_enums.dart';
import 'package:hadirio/models/login_response.dart';
import 'package:hadirio/models/my_dropdown_item.dart';
import 'package:hadirio/presentations/widgets/text_dialog.dart';
import 'package:hadirio/utils/dialog_helper.dart';
import 'package:hadirio/utils/extensions/date_format.dart';
import 'package:hadirio/utils/extensions/string_extensions.dart';
import 'package:hadirio/utils/function.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  @override
  void onInit() {
    user(Get.arguments);
    super.onInit();
  }

  Rx<LoginResponse> user = Rx(LoginResponse());

  bool get isAdmin => user.value.role == 'admin';

  RxBool isEdit = RxBool(false);

  void doEditFunc() {
    if (isEdit.value) {
      updateProfile();
    } else {
      usnCtrl.text = user.value.username.toCapitalized();
      phoneCtrl.text = user.value.phone ?? '';
      final jk = user.value.gender;
      if (jk == 'Laki-laki') {
        gender(MyDropdownItem(value: 'Laki-laki'));
      } else if (jk == 'Perempuan') {
        gender(MyDropdownItem(value: 'Perempuan'));
      } else {
        gender.value = null;
      }
      isEdit(true);
    }
  }

  Rxn<MyDropdownItem> gender = Rxn(null);

  final genderList = [
    MyDropdownItem(value: 'Laki-laki'),
    MyDropdownItem(value: 'Perempuan'),
  ];

  void pickGender(dynamic value) {
    closeKeyboard();
    if (value is MyDropdownItem) {
      gender(value);
    }
  }

  final usnCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  void updateProfile({String? id}) async {
    if (phoneCtrl.text.isEmpty || gender.value == null) {
      Get.dialog(
        const TextDialog(text: 'Lengkapi field terlebih dahulu'),
      );
      return;
    }
    closeKeyboard();
    DialogHelper.showLoadingDialog(Get.context!);
    final response = await Repository.updateProfile(
      id: id ?? user.value.id ?? '',
      gender: gender.value!.value,
      phone: phoneCtrl.text,
    );
    Get.back();
    if (response.errors == null) {
      user(response);
      isEdit(false);
    } else {
      Get.dialog(
        TextDialog(text: response.errors ?? 'Errors'),
      );
    }
  }

  void checkIn() async {
    DialogHelper.showLoadingDialog(Get.context!);
    final response = await Repository.doPresence(
      type: PresenceTypeEnums.checkin,
      date: DateTime.now().toFormatDateParams(),
      userId: user.value.id,
      userName: user.value.username,
    );
    Get.back();
    if (response.isSuccess) {
      Get.dialog(
        TextDialog(
          text: 'Berhasil Checkin',
          onTap: () {
            Get.back();
            Get.toNamed(AppRoute.history);
          },
        ),
      );
    } else {
      Get.dialog(
        TextDialog(text: response.errors ?? 'Errors'),
      );
    }
  }

  void checkOut() async {
    DialogHelper.showLoadingDialog(Get.context!);
    final response = await Repository.doPresence(
      type: PresenceTypeEnums.checkout,
      date: DateTime.now().toFormatDateParams(),
      userId: user.value.id,
      userName: user.value.username,
    );
    Get.back();
    if (response.isSuccess) {
      Get.dialog(
        TextDialog(
          text: 'Berhasil Checkout',
          onTap: () {
            Get.back();
            Get.toNamed(AppRoute.history);
          },
        ),
      );
    } else {
      Get.dialog(
        TextDialog(text: response.errors ?? 'Errors'),
      );
    }
  }

  void offDayPresence(String reason) async {
    if (reason.isEmpty) {
      Get.dialog(
        const TextDialog(text: 'Lengkapi field terlebih dahulu'),
      );
      return;
    }
    closeKeyboard();
    DialogHelper.showLoadingDialog(Get.context!);
    final response = await Repository.doPresence(
      type: PresenceTypeEnums.sickAbsence,
      date: DateTime.now().toFormatDateParams(),
      userId: user.value.id,
      userName: user.value.username,
      reason: reason,
    );
    Get.back();
    if (response.isSuccess) {
      Get.dialog(
        TextDialog(
          text: 'Berhasil mengisi ketidakhadiran (Izin)',
          onTap: () {
            Get.close(2);
            Get.toNamed(AppRoute.history);
          },
        ),
      );
    } else {
      Get.dialog(
        TextDialog(text: response.errors ?? 'Errors'),
      );
    }
  }

  void sickPresence(File? file) async {
    if (file == null) {
      Get.dialog(
        const TextDialog(text: 'Lengkapi field terlebih dahulu'),
      );
      return;
    }
    closeKeyboard();
    DialogHelper.showLoadingDialog(Get.context!);
    final bytes = await file.readAsBytes();
    final base64Image = base64Encode(bytes);
    final response = await Repository.doPresence(
      type: PresenceTypeEnums.offDayAbsence,
      date: DateTime.now().toFormatDateParams(),
      userId: user.value.id,
      userName: user.value.username,
      file: base64Image,
    );
    Get.back();
    if (response.isSuccess) {
      Get.dialog(
        TextDialog(
          text: 'Berhasil mengisi ketidakhadiran (Sakit)',
          onTap: () {
            Get.close(2);
            Get.toNamed(AppRoute.history);
          },
        ),
      );
    } else {
      Get.dialog(
        TextDialog(text: response.errors ?? 'Errors'),
      );
    }
  }
}
