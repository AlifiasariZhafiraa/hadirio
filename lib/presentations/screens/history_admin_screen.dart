import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hadirio/configs/app_colors.dart';
import 'package:hadirio/controllers/history_admin_controller.dart';
import 'package:hadirio/presentations/widgets/history_item.dart';
import 'package:hadirio/presentations/widgets/user_item.dart';
import 'package:hadirio/utils/extensions/ext_tap.dart';
import 'package:hadirio/utils/extensions/space_x.dart';
import 'package:hadirio/utils/extensions/string_extensions.dart';
import 'package:hadirio/utils/extensions/date_format.dart';
import 'package:hadirio/utils/function.dart';

class HistoryAdminScreen extends StatelessWidget {
  const HistoryAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = HistoryAdminController.to;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Kehadiran Karyawan'),
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
              'Data hari ini',
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
                return ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: ctrl.today.length,
                  separatorBuilder: (_, i) => 10.verticalSpace,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, i) {
                    final data = ctrl.today[i];

                    return HistoryItem(
                      name: data.userName,
                      checkin: data.checkin?.toFormatTime(),
                      checkout: data.checkout?.toFormatTime(),
                      reason: data.reason,
                      status: data.status?.replaceStatus() ?? 'Belum absen',
                      file: data.file,
                    );
                  },
                );
              }
            }),
            30.verticalSpace,
            Text(
              'Lihat Daftar User',
              style: textTheme(context).titleSmall,
            ),
            5.verticalSpace,
            Obx(() {
              if (ctrl.loadingUsers.value) {
                return Text(
                  '...',
                  style: textTheme(context).displayLarge,
                );
              } else if (ctrl.users.isEmpty) {
                return Row(
                  children: [
                    Text(
                      'Data Kosong',
                      style: textTheme(context).displayLarge,
                    ),
                    30.horizontalSpace,
                    Text(
                      'Refresh',
                      style: textTheme(context).displayMedium,
                    ).extCupertino(onTap: ctrl.getUsers),
                  ],
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: ctrl.users.length,
                  separatorBuilder: (_, i) => 5.verticalSpace,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, i) {
                    return UserItem(user: ctrl.users[i]);
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
