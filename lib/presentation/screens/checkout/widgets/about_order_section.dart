import 'package:bingo/core/custom_widgets/row_text.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/formatters.dart';
import 'package:bingo/core/utils/is_dark.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/checkout/checkout_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AboutOrderSection extends ViewModelWidget<CheckoutViewModel> {
  const AboutOrderSection({super.key});

  @override
  Widget build(BuildContext context, CheckoutViewModel viewModel) {
    final isDarkMode = isDarkModeEnabled(context);
    return Column(
      children: [
        verticalSpace5,
        RowText(
          valueKey: 'checkout.subtotal'.tr(),
          value:
              '${Formatters.formattedMoney(viewModel.template?.price ?? viewModel.cartData!.price)} ${'common.sum'.tr()}',
          color: AppColors.grey,
        ),
        if (viewModel.deliveryCost != null) ...[
          verticalSpace5,
          RowText(
            valueKey: 'checkout.delivery'.tr(),
            value:
                '${Formatters.formattedMoney(viewModel.deliveryCost)} ${'common.sum'.tr()}',
            color: AppColors.grey,
          )
        ],
        verticalSpace5,
        RowText(
          valueKey: 'checkout.total'.tr(),
          value:
              '${Formatters.formattedMoney(viewModel.template?.price ?? viewModel.cartData!.price!.toDouble() + (viewModel.deliveryCost ?? 0))} ${'common.sum'.tr()}',
          color: isDarkMode ? AppColors.bgLight : AppColors.bgDark,
          isBold: true,
        ),
      ],
    );
  }
}
