import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hadirio/configs/app_assets.dart';
import 'package:hadirio/configs/app_colors.dart';
import 'package:hadirio/configs/app_route.dart';
import 'package:hadirio/models/login_response.dart';
import 'package:hadirio/utils/extensions/ext_tap.dart';
import 'package:hadirio/utils/extensions/space_x.dart';
import 'package:hadirio/utils/function.dart';
import 'package:hadirio/utils/extensions/string_extensions.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  LoginResponse? response;

  @override
  void initState() {
    setState(() {
      response = Get.arguments;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColorFFFFFF,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColorFFFFFF,
        elevation: 0,
        toolbarHeight: 10,
      ),
      body: Column(
        children: [
          30.verticalSpace,
          Center(
            child: Image.asset(
              AppAssets.logoPng,
              width: (MediaQuery.of(context).size.width / 1.8),
            ),
          ),
          40.verticalSpace,
          Text(
            'Selamat Datang',
            style: textTheme(context).displayLarge,
          ),
          6.verticalSpace,
          Text(
            response!.username.toCapitalized2(),
            style: textTheme(context).titleMedium,
          ),
          const Spacer(flex: 2),
          RichText(
            text: TextSpan(
              style: textTheme(context).displayMedium,
              children: [
                TextSpan(
                  text:
                      'Lanjutkan sebagai ${response!.username.toCapitalized2()}',
                ),
                WidgetSpan(child: 10.horizontalSpace),
                WidgetSpan(
                  child: SvgPicture.asset(
                    AppAssets.arrowForwardSvg,
                    height: 16,
                    width: 20,
                  ),
                ),
              ],
            ),
          ).extCupertino(
            onTap: () => Get.offNamed(
              AppRoute.home,
              arguments: response,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
