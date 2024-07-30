import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hadirio/configs/app_colors.dart';
import 'package:hadirio/configs/app_route.dart';
import 'package:hadirio/models/login_response.dart';
import 'package:hadirio/utils/extensions/string_extensions.dart';
import 'package:hadirio/utils/function.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.user});

  final LoginResponse user;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: AppColors.blackColor667085,
        ),
      ),
      child: ListTile(
        title: Text(
          user.username.toCapitalized2(),
          style: textTheme(context)
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          user.phone ?? '-',
          style: textTheme(context).bodyMedium,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Get.toNamed(
            AppRoute.history,
            arguments: user,
          );
        },
      ),
    );
  }
}
