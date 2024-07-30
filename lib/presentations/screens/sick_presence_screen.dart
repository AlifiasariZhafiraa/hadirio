import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hadirio/configs/app_colors.dart';
import 'package:hadirio/controllers/home_controller.dart';
import 'package:hadirio/utils/extensions/space_x.dart';
import 'package:hadirio/utils/function.dart';

class SickPresenceScreen extends StatefulWidget {
  const SickPresenceScreen({super.key});

  @override
  State<SickPresenceScreen> createState() => _SickPresenceScreenState();
}

class _SickPresenceScreenState extends State<SickPresenceScreen> {
  File? file;

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
                'Upload\nSurat',
                style: textTheme(context).titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            50.verticalSpace,
            if (file != null) ...[
              Stack(
                children: [
                  SizedBox(
                    height: 500,
                    width: double.infinity,
                    child: Image.file(
                      file!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.75),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () async {
                          final result = await pickImage();
                          if (result != null) {
                            setState(() {
                              file = File(result.path);
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.add_photo_alternate,
                          color: AppColors.whiteColorFFFFFF,
                          size: 40,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ] else ...[
              20.verticalSpace,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor.withOpacity(0.5),
                  minimumSize: Size(40, Platform.isIOS ? 45 : 50),
                ),
                child: const Text('Pilih File'),
                onPressed: () async {
                  final result = await pickImage();
                  if (result != null) {
                    setState(() {
                      file = File(result.path);
                    });
                  }
                },
              ),
            ],
            100.verticalSpace,
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 30),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          onPressed: () => HomeController.to.sickPresence(file),
          child: const Text('UPLOAD'),
        ),
      ),
    );
  }
}
