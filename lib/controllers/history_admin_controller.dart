import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hadirio/api/repository.dart';
import 'package:hadirio/models/history_response.dart';
import 'package:hadirio/models/login_response.dart';

class HistoryAdminController extends GetxController {
  static HistoryAdminController get to => Get.find();

  @override
  void onInit() {
    getTodayPresence();
    getUsers();
    super.onInit();
  }

  RxBool loadingToday = RxBool(true);
  RxString errorToday = RxString('');
  RxList<HistoryData> today = RxList.empty();

  Rxn<DateTimeRange> dateRange = Rxn(null);

//ambil data absen hari ini
  void getTodayPresence() async {
    loadingToday(true);
    errorToday('');
    final response = await Repository.getTodayPresence();
    loadingToday(false);
    if (response.errors == null) {
      if (response.data!.isNotEmpty) today(response.data ?? []);
    } else {
      errorToday(response.errors);
    }
  }

//ambil data absen semua user
  RxBool loadingUsers = RxBool(true);
  RxList<LoginResponse> users = RxList.empty();

  void getUsers() async {
    loadingUsers(true);
    final response = await Repository.getUser();
    loadingUsers(false);
    if (response.isNotEmpty) {
      users(response);
    }
  }
}
