import 'package:flutter/material.dart';
import 'package:hadirio/controllers/home_controller.dart';
import 'package:hadirio/presentations/widgets/custom_text_field.dart';
import 'package:hadirio/utils/extensions/space_x.dart';
import 'package:hadirio/utils/function.dart';

class OffDayPresence extends StatelessWidget {
  OffDayPresence({super.key});

  final txtCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            30.verticalSpace,
            Center(
              child: Text(
                'Alasan\nCuti',
                style: textTheme(context).titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            30.verticalSpace,
            CustomTextField(
              hint: 'Tulis keterangan anda',
              minLines: 15,
              textAlign: TextAlign.start,
              controller: txtCtrl,
            ),
            100.verticalSpace,
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 30),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          onPressed: () => HomeController.to.offDayPresence(txtCtrl.text),
          child: const Text('UPLOAD'),
        ),
      ),
    );
  }
}
