import 'dart:io';

import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/enum/user_status.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/formatters.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/presentation/screens/cart/cart_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CheckoutWidget extends ViewModelWidget<CartViewModel> {
  const CheckoutWidget({super.key});

  @override
  Widget build(BuildContext context, CartViewModel viewModel) {
    return viewModel.cartData == null
        ? const SizedBox()
        : Container(
            height: 78,
            width: ScreenSize.width,
            margin: const EdgeInsets.only(bottom: 55,),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -15),
                    blurRadius: 25,
                    color: AppColors.grey.withOpacity(.1),
                  )
                ],
                borderRadius:
                     BorderRadius.circular(16)),
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${'cart.to_pay'.tr()}:',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    RichText(
                        text: TextSpan(
                            text: Formatters.formattedMoney(
                                viewModel.cartData!.price),
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                          TextSpan(
                              text: ' ${'common.sum'.tr()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: AppColors.grey))
                        ]))
                  ],
                ),
                const Spacer(),
                AppButton(
                    text: 'cart.checkout'.tr(),
                    height: 50,
                    isActive: viewModel.userStatus == UserStatus.authorized,
                    borderRadius: BorderRadius.circular(12),
                    textColor: AppColors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    fillColor: AppColors.bgDark,
                    onPressed: viewModel.toCheckoutScreen)
              ],
            ),
          );
  }
}
