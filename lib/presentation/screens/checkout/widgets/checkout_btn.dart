import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/is_dark.dart';
import 'package:bingo/presentation/screens/checkout/checkout_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CheckoutButton extends ViewModelWidget<CheckoutViewModel> {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context, CheckoutViewModel viewModel) {
    final isDarkMode = isDarkModeEnabled(context);
    return AppButton(
      width: double.maxFinite,
      text: 'cart.checkout'.tr(),
      onPressed: viewModel.onOrder,
      textStyle: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(fontWeight: FontWeight.bold),
      borderRadius: BorderRadius.circular(50),
      padding: const EdgeInsets.symmetric(vertical: 18),
      isActive: viewModel.orderButtonStatus(),
      isLoading: viewModel.isBusy,
      textColor: isDarkMode ? AppColors.bgDark : AppColors.bgLight,
      fillColor: isDarkMode ? AppColors.bgLight : AppColors.bgDark,
    );
  }
}
