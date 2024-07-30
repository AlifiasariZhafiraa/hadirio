import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hadirio/configs/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hadirio/configs/app_page.dart';
import 'package:hadirio/configs/app_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        physics: const ClampingScrollPhysics(),
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
        ),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: AppColors.whiteColorFFFFFF,
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor101828,
          ),
          titleSpacing: 5,
          iconTheme: IconThemeData(
            color: AppColors.primaryColor,
            size: Platform.isAndroid ? 24 : 28,
          ),
          backgroundColor: AppColors.whiteColorFFFFFF,
          centerTitle: false,
          toolbarHeight: Platform.isAndroid ? 60 : 45,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
            minimumSize: WidgetStatePropertyAll(
              Size(double.infinity, Platform.isIOS ? 56 : 61),
            ),
            backgroundColor: const WidgetStatePropertyAll(
              AppColors.primaryColor,
            ),
            foregroundColor: const WidgetStatePropertyAll(
              AppColors.whiteColorFFFFFF,
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            textStyle: WidgetStatePropertyAll(
              GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 5,
              ),
            ),
          ),
        ),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.inter(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: AppColors.blackColor101828,
          ),

          /// welcome text 2
          titleMedium: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.blackColor101828,
          ),

          titleSmall: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor101828,
          ),

          /// welcome text 1
          displayLarge: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColorAFAFAF,
          ),

          /// textfield
          displayMedium: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor101828,
          ),

          /// welcome text 3
          displaySmall: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor121926,
          ),
        ),
      ),
      initialRoute: AppRoute.splash,
      getPages: AppPage.pages,
    );
  }
}
