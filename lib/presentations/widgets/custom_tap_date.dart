import 'package:flutter/material.dart';
import 'package:hadirio/configs/app_colors.dart';
import 'package:hadirio/utils/extensions/date_format.dart';
import 'package:hadirio/utils/function.dart';

class CustomTapDate extends StatelessWidget {
  const CustomTapDate({
    super.key,
    required this.hint,
    this.value,
    required this.onTapDate,
  });

  final String hint;
  final DateTimeRange? value;
  final Function() onTapDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 16,
      ),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: onTapDate,
              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.blackColor9AA4B2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    if (value == null) ...[
                      Expanded(
                        child: Text(
                          hint,
                          style: textTheme(context).displayMedium?.copyWith(
                                color: AppColors.blackColor9AA4B2,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ] else ...[
                      Expanded(
                        child: Text(
                          value.formatGeneral(),
                          style: textTheme(context).displayMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
