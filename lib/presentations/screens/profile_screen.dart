import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hadirio/configs/app_assets.dart';
import 'package:hadirio/configs/app_colors.dart';
import 'package:hadirio/configs/app_route.dart';
import 'package:hadirio/controllers/home_controller.dart';
import 'package:hadirio/presentations/widgets/custom_dropdown.dart';
import 'package:hadirio/presentations/widgets/custom_text_field.dart';
import 'package:hadirio/utils/extensions/ext_tap.dart';
import 'package:hadirio/utils/extensions/space_x.dart';
import 'package:hadirio/utils/extensions/string_extensions.dart';
import 'package:hadirio/utils/function.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = HomeController.to;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          Obx(() {
            if (ctrl.isEdit.value) {
              return const Text('Simpan').extCupertino(
                onTap: ctrl.doEditFunc,
              );
            }
            return const Text('Edit').extCupertino(
              onTap: ctrl.doEditFunc,
            );
          }),
          15.horizontalSpace,
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(
          () => Column(
            children: [
              50.verticalSpace,
              Center(
                child: Image.asset(
                  AppAssets.logoCenterPng,
                  width: (MediaQuery.of(context).size.width / 2),
                ),
              ),
              80.verticalSpace,
              if (ctrl.isEdit.value) ...[
                CustomTextField(
                  readOnly: true,
                  hint: 'Nama akun',
                  controller: ctrl.usnCtrl,
                  inputType: TextInputType.number,
                  formatter: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  inputAction: TextInputAction.done,
                ),
                CustomDropdown(
                  onChange: ctrl.pickGender,
                  items: ctrl.genderList,
                  value: ctrl.gender.value,
                  hint: 'Jenis kelamin',
                ),
                CustomTextField(
                  hint: 'Nomor telpon',
                  controller: ctrl.phoneCtrl,
                  inputType: TextInputType.number,
                  formatter: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  inputAction: TextInputAction.done,
                ),
              ] else ...[
                16.verticalSpace,
                profileComponent(
                  context,
                  ctrl.user.value.username.toCapitalized2(),
                ),
                profileComponent(
                  context,
                  ctrl.user.value.gender ?? '-',
                ),
                profileComponent(
                  context,
                  ctrl.user.value.phone ?? '-',
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 30),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red[600]),
          onPressed: () => Get.offAllNamed(AppRoute.login),
          child: const Text('LOGOUT'),
        ),
      ),
    );
  }

  Widget profileComponent(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.blackColorAFAFAF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: textTheme(context).displayMedium,
      ),
    );
  }
}
