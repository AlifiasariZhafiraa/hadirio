import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hadirio/configs/app_assets.dart';
import 'package:hadirio/configs/app_colors.dart';
import 'package:hadirio/controllers/login_controller.dart';
import 'package:hadirio/presentations/widgets/text_dialog.dart';
import 'package:hadirio/presentations/widgets/custom_text_field.dart';
import 'package:hadirio/utils/extensions/space_x.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final usnCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ctrl = LoginController.to;

    return Scaffold(
      backgroundColor: AppColors.whiteColorFFFFFF,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColorFFFFFF,
        elevation: 0,
        toolbarHeight: 10,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.verticalSpace,
            Center(
              child: Image.asset(
                AppAssets.logoPng,
                width: (MediaQuery.of(context).size.width / 1.8),
              ),
            ),
            80.verticalSpace,
            CustomTextField(
              hint: 'Masukan username',
              controller: usnCtrl,
            ),
            CustomTextField(
              hint: 'Masukan password',
              controller: passCtrl,
              inputType: TextInputType.visiblePassword,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 30),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          onPressed: () {
            if (usnCtrl.text.isEmpty || passCtrl.text.isEmpty) {
              Get.dialog(
                const TextDialog(text: 'Lengkapi field terlebih dahulu'),
              );
            } else {
              ctrl.login(
                username: usnCtrl.text,
                password: passCtrl.text,
              );
            }
          },
          child: const Text('LOGIN'),
        ),
      ),
    );
  }
}
