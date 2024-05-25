import 'package:bingo/app/router.dart';
import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ErrorDialogView extends StatelessWidget {
  const ErrorDialogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.background,
      ),
      padding: const EdgeInsets.all(24),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(
          Icons.error,
          color: AppColors.red,
          size: 100,
        ),
        verticalSpace12,
        Text(
          'errors.BAD_REQUEST'.tr(),
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        verticalSpace24,
        AppButton(
            text: "OK",
            padding: const EdgeInsets.symmetric(vertical: 12),
            fillColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12),
            onPressed: router.back)
      ]),
    );
  }
}
