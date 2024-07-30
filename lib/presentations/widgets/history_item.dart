import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hadirio/configs/app_colors.dart';
import 'package:hadirio/presentations/widgets/image_dialog.dart';
import 'package:hadirio/utils/extensions/ext_tap.dart';
import 'package:hadirio/utils/extensions/space_x.dart';
import 'package:hadirio/utils/function.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    super.key,
    this.date,
    this.name,
    this.checkin,
    this.checkout,
    this.reason,
    this.file,
    this.status,
  });

  final String? date;
  final String? name;
  final String? status;
  final String? checkin;
  final String? checkout;
  final String? reason;
  final String? file;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: name != null
          ? const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            )
          : const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(name != null ? 5 : 10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (name != null)
                Text(
                  name!,
                  style: textTheme(context).bodyLarge,
                )
              else if (date != null)
                Text(
                  date!,
                  style: textTheme(context).bodyLarge,
                ),
              if (checkin != null)
                Text(
                  checkin!,
                  style: textTheme(context).bodyLarge,
                ),
            ],
          ),
          2.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (status != null)
                Text(
                  status!,
                  style: textTheme(context).displayLarge?.copyWith(
                        fontSize: 16,
                        color: status == 'Belum absen' ? Colors.red : null,
                        fontWeight:
                            status == 'Belum absen' ? FontWeight.w600 : null,
                      ),
                ),
              if (checkout != null)
                Text(
                  checkout!,
                  style: textTheme(context).bodyLarge,
                ),
              if (file != null) ...[
                Text(
                  'Lihat bukti',
                  style: textTheme(context).displayLarge?.copyWith(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        color: AppColors.blackColor1E1E1E,
                      ),
                ).extCupertino(
                  onTap: () {
                    Get.dialog(ImageDialog(base64: file ?? ''));
                  },
                ),
              ],
            ],
          ),
          if (reason != null) ...[
            10.verticalSpace,
            Text(
              'Alasan: $reason',
              style: textTheme(context).bodyLarge,
            ),
          ],
        ],
      ),
    );
  }
}
