import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hadirio/configs/app_colors.dart';
import 'package:hadirio/controllers/history_controller.dart';
import 'package:hadirio/presentations/widgets/custom_dropdown.dart';
import 'package:hadirio/presentations/widgets/custom_loading.dart';
import 'package:hadirio/presentations/widgets/custom_tap_date.dart';
import 'package:hadirio/presentations/widgets/history_item.dart';
import 'package:hadirio/presentations/widgets/image_dialog.dart';
import 'package:hadirio/utils/extensions/date_format.dart';
import 'package:hadirio/utils/extensions/ext_tap.dart';
import 'package:hadirio/utils/extensions/space_x.dart';
import 'package:hadirio/utils/extensions/string_extensions.dart';
import 'package:hadirio/utils/function.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = HistoryController.to;

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final data = ctrl.userDetail.value?.username.toCapitalized2() ?? '';
          
          return Text(
            'Kehadiran $data',
          );
        }),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
            const Text(
              'Presensi hari ini',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.blackColor697586,
                fontWeight: FontWeight.w600,
              ),
            ),
            5.verticalSpace,
            Obx(() {
              if (ctrl.loadingToday.value) {
                return Text(
                  '...',
                  style: textTheme(context).displayLarge,
                );
              } else if (ctrl.errorToday.value.isNotEmpty) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      ctrl.errorToday.value,
                      style: textTheme(context).displayLarge,
                    ),
                    30.horizontalSpace,
                    Text(
                      'Refresh',
                      style: textTheme(context).displayMedium,
                    ).extCupertino(onTap: ctrl.getTodayPresence),
                  ],
                );
              } else {
                final data = ctrl.today.value;
                final userDetail = ctrl.userDetail.value?.username.toCapitalized2();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (data?.status == null) ...[
                      Text(
                        '${userDetail ?? 'Anda'} belum melakukan absensi',
                        style: textTheme(context).displayLarge,
                      ),
                    ] else ...[
                      Text(
                        'Status : ${data?.status.replaceStatus()}',
                        style: textTheme(context).displayLarge,
                      ),
                      5.verticalSpace,
                      if (data?.file != null) ...[
                        5.verticalSpace,
                        Text(
                          'Lihat bukti',
                          style: textTheme(context).displayLarge?.copyWith(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                color: AppColors.blackColor1E1E1E,
                              ),
                        ).extCupertino(
                          onTap: () {
                            Get.dialog(ImageDialog(base64: data?.file ?? ''));
                          },
                        ),
                      ] else if (data?.reason != null) ...[
                        Text(
                          'Alasan : ${data?.reason ?? '-'}',
                          style: textTheme(context).displayLarge?.copyWith(
                                color: AppColors.blackColor1E1E1E,
                              ),
                        ),
                      ] else ...[
                        Text(
                          'Checkin : ${data!.checkin.toFormatTime()}',
                          style: textTheme(context).displayLarge?.copyWith(
                                color: AppColors.blackColor1E1E1E,
                              ),
                        ),
                        5.verticalSpace,
                        if (data.checkout != null) ...[
                          Text(
                            'Checkout : ${data.checkout.toFormatTime()}',
                            style: textTheme(context).displayLarge?.copyWith(
                                  color: AppColors.blackColor1E1E1E,
                                ),
                          ),
                        ],
                      ],
                    ],
                  ],
                );
              }
            }),
            30.verticalSpace,
            Text(
              'Lihat Riwayat Kehadiran',
              style: textTheme(context).titleSmall,
            ),
            Obx(
              () => CustomDropdown(
                onChange: ctrl.selectDropdown,
                items: ctrl.dropdowns,
                value: ctrl.selected.value,
                hint: 'Pilih periode',
              ),
            ),
            Obx(
              () => ctrl.isCustomDateRange
                  ? CustomTapDate(
                      onTapDate: ctrl.pickDateRange,
                      value: ctrl.dateRange.value,
                      hint: 'Pilih durasi tanggal',
                    )
                  : const SizedBox(),
            ),
            Obx(() {
              if (ctrl.selected.value == null) {
                return const SizedBox();
              } else if (ctrl.loadingHistory.value) {
                return const CustomLoading();
              } else if (ctrl.errorHistory.value.isNotEmpty) {
                return Text(
                  ctrl.errorHistory.value,
                  style: textTheme(context).displayMedium,
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    30.verticalSpace,
                    generateComponent(
                      context,
                      'Hari Kerja',
                      ctrl.total.value,
                    ),
                    generateComponent(
                      context,
                      'Tepat Waktu',
                      ctrl.ontime.value,
                    ),
                    generateComponent(
                      context,
                      'Terlambat',
                      ctrl.late.value,
                    ),
                    generateComponent(
                      context,
                      'Sakit',
                      ctrl.sick.value,
                    ),
                    generateComponent(
                      context,
                      'Izin',
                      ctrl.offDay.value,
                    ),
                    generateComponent(
                      context,
                      'Tidak ada keterangan',
                      ctrl.absent.value,
                    ),
                    20.verticalSpace,
                    Text(
                      'Riwayat Data',
                      style: textTheme(context).titleSmall?.copyWith(
                            fontSize: 16,
                          ),
                    ),
                    15.verticalSpace,
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: ctrl.history.length,
                      separatorBuilder: (_, i) => 10.verticalSpace,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, i) {
                        final data = ctrl.history[i];

                        return HistoryItem(
                          date: data.checkin.toFormatDate(),
                          checkin: data.checkin.toFormatTime(),
                          checkout: data.checkout?.toFormatTime(),
                          reason: data.reason,
                          status: data.status.replaceStatus(),
                          file: data.file,
                        );
                      },
                    ),
                    50.verticalSpace,
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget generateComponent(
    BuildContext context,
    String status,
    int count, {
    bool isAlfa = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            status,
            style: textTheme(context).displayMedium,
          ),
          Text(
            '$count Hari',
            style: textTheme(context).displayMedium,
          ),
        ],
      ),
    );
  }
}
