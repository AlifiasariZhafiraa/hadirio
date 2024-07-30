import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hadirio/api/repository.dart';
import 'package:hadirio/controllers/home_controller.dart';
import 'package:hadirio/models/history_response.dart';
import 'package:hadirio/models/login_response.dart';
import 'package:hadirio/models/my_dropdown_item.dart';
import 'package:hadirio/utils/extensions/date_format.dart';
import 'package:hadirio/utils/function.dart';

class HistoryController extends GetxController {
  static HistoryController get to => Get.find();

  Rx<LoginResponse> user = HomeController.to.user;
  Rxn<LoginResponse> userDetail = Rxn(null);

  @override
  void onInit() {
    if (Get.arguments != null) {
      userDetail(Get.arguments);
    }
    getTodayPresence();
    super.onInit();
  }

  RxBool loadingToday = RxBool(true);
  RxString errorToday = RxString('');
  Rxn<HistoryData> today = Rxn(null);

  void getTodayPresence() async {
    loadingToday(true);
    errorToday('');
    final response = await Repository.getTodayPresence(
      id: userDetail.value?.id ?? user.value.id,
    );
    loadingToday(false);
    if (response.errors == null) {
      if (response.data!.isNotEmpty) today(response.data?.first);
    } else {
      errorToday(response.errors);
    }
  }

  Rxn<DateTimeRange> dateRange = Rxn(null);

  void pickDateRange() async {
    final result = await showDateRangePicker(
      context: Get.context!,
      initialDateRange: dateRange.value,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (result != null) {
      dateRange(result);
      getHistory(
        startDate: result.start.replaceStartDateParams(),
        endDate: result.end.replaceEndDateParams(),
      );
    }
  }

  RxList<MyDropdownItem> dropdowns = RxList([
    MyDropdownItem(value: '7 hari kebelakang', id: '2'),
    MyDropdownItem(value: 'Bulan ini', id: '3'),
    MyDropdownItem(value: 'Pilih Tanggal', id: '4'),
  ]);

  Rxn<MyDropdownItem> selected = Rxn(null);

  bool get isCustomDateRange => selected.value?.id == '4';

  void selectDropdown(dynamic value) {
    if (value is MyDropdownItem && value.id != selected.value?.id) {
      selected(value);
      DateTime now = DateTime.now();
      history.clear();
      if (value.id == '2') {
        String endDate = now.replaceEndDateParams();
        String startDate = DateTime(
          now.year,
          now.month,
          now.day - 7,
        ).replaceStartDateParams();

        getHistory(
          startDate: startDate,
          endDate: endDate,
        );
      } else if (value.id == '3') {
        String startDate = DateTime(
          now.year,
          now.month,
          1,
        ).replaceStartDateParams();
        String endDate = DateTime(
          now.year,
          now.month + 1,
          0,
        ).replaceEndDateParams();
        getHistory(
          startDate: startDate,
          endDate: endDate,
        );
      } else {
        dateRange.value = null;
      }
    }
  }

  RxBool loadingHistory = RxBool(false);
  RxString errorHistory = RxString('');
  RxList<HistoryData> history = RxList.empty();

  RxInt total = RxInt(0);
  RxInt ontime = RxInt(0);
  RxInt late = RxInt(0);
  RxInt offDay = RxInt(0);
  RxInt sick = RxInt(0);
  RxInt absent = RxInt(0);

  void getHistory({
    required String startDate,
    required String endDate,
  }) async {
    loadingHistory(true);
    errorHistory('');
    total(countDay(startDate, endDate));
    ontime(0);
    late(0);
    offDay(0);
    sick(0);
    absent(0);
    final response = await Repository.getHistory(
      id: userDetail.value?.id ?? user.value.id,
      startDate: startDate,
      endDate: endDate,
    );
    loadingHistory(false);
    for (final item in response.data ?? <HistoryData>[]) {
      if (item.status == 'Masuk') {
        ontime(ontime.value + 1);
      }
      if (item.status == 'Terlambat') {
        late(late.value + 1);
      }
      if (item.status == 'Sakit') {
        sick(sick.value + 1);
      }
      if (item.status == 'Izin') {
        offDay(offDay.value + 1);
      }
    }
    absent(
      total.value - ontime.value - late.value - offDay.value - sick.value,
    );
    if (response.errors == null) {
      if (response.data!.isNotEmpty) {
        history(response.data ?? []);
      }
    } else {
      errorHistory(response.errors);
    }
  }
}
