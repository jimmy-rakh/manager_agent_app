import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/utils/is_dark.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.onRetTry});

  final void Function() onRetTry;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = isDarkModeEnabled(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'errors.undefined'.tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        verticalSpace12,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * .35),
          child: AppButton(
              text: 'common.repeat'.tr(),
              onPressed: onRetTry,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              borderColor: isDarkMode ? AppColors.bgLight : AppColors.bgDark),
        )
      ],
    );
  }
}
