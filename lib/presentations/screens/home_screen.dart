import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hadirio/configs/app_assets.dart';
import 'package:hadirio/configs/app_colors.dart';
import 'package:hadirio/configs/app_route.dart';
import 'package:hadirio/controllers/home_controller.dart';
import 'package:hadirio/utils/extensions/space_x.dart';
import 'package:hadirio/utils/extensions/string_extensions.dart';
import 'package:hadirio/utils/function.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = HomeController.to;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColorFFFFFF,
        elevation: 0,
        leading: const SizedBox(),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Obx(
              () => MenuAnchor(
                builder: (context, controller, child) {
                  return IconButton(
                    onPressed: () {
                      if (controller.isOpen) {
                        controller.close();
                      } else {
                        controller.open();
                      }
                    },
                    icon: const Icon(Icons.menu),
                    tooltip: 'Show menu',
                  );
                },
                menuChildren: [
                  ListTile(
                    title: const Text('Profile'),
                    onTap: () {
                      ctrl.isEdit(false);
                      Get.toNamed(AppRoute.profile);
                    },
                  ),
                  if (ctrl.isAdmin) ...[
                    ListTile(
                      title: const Text('Riwayat'),
                      onTap: () => Get.toNamed(AppRoute.history),
                    ),
                    ListTile(
                      title: const Text('Semua Riwayat'),
                      onTap: () => Get.toNamed(AppRoute.historyAdmin),
                    ),
                  ] else ...[
                    ListTile(
                      title: const Text('Riwayat'),
                      onTap: () => Get.toNamed(AppRoute.history),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                30.verticalSpace,
                Image.asset(
                  AppAssets.logoCenterPng,
                  width: (MediaQuery.of(context).size.width / 2),
                ),
                30.verticalSpace,
                Text(
                  'User',
                  style: textTheme(context).displayLarge,
                ),
                6.verticalSpace,
                Obx(
                  () => Text(
                    ctrl.user.value.username.toCapitalized2(),
                    style: textTheme(context).titleMedium,
                  ),
                ),
                30.verticalSpace,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 60),
                  ),
                  onPressed: ctrl.checkIn,
                  child: const Text('CHECK IN'),
                ),
                if (!ctrl.isAdmin) ...[
                  16.verticalSpace,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    child: const Text('SAKIT'),
                    onPressed: () => Get.toNamed(AppRoute.sickPresence),
                  ),
                  16.verticalSpace,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    child: const Text('IZIN'),
                    onPressed: () => Get.toNamed(AppRoute.offDayPresence),
                  ),
                ],
                16.verticalSpace,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 60),
                  ),
                  onPressed: ctrl.checkOut,
                  child: const Text('CHECK OUT'),
                ),
                30.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
