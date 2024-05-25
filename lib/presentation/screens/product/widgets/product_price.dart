import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/formatters.dart';
import 'package:bingo/presentation/screens/product/product_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProductPrice extends ViewModelWidget<ProductViewModel> {
  const ProductPrice({super.key});

  @override
  Widget build(BuildContext context, ProductViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
            text: TextSpan(
                text: viewModel.productCountController.text.isEmpty
                    ? Formatters.formattedMoney(viewModel.product!.price!)
                    : Formatters.formattedMoney(viewModel.product!.price! *
                        int.parse(viewModel.productCountController.text)),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w400),
                children: [
              TextSpan(
                text: ' ${'common.sum'.tr()}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: AppColors.grey),
              )
            ])),
        const Spacer(),
        AppButton(
          text: 'common.add_to_cart'.tr(),
          borderRadius: BorderRadius.circular(24),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          borderColor: Theme.of(context).primaryColor,
          isLoading: viewModel.product!.isBusy!,
          isActive: viewModel.productCountController.text.isEmpty
              ? false
              : int.parse(viewModel.productCountController.text) <=
                  viewModel.product!.quantity!,
          onPressed: viewModel.product!.quantity! >=
                  int.parse(viewModel.productCountController.text == ""
                      ? "0"
                      : viewModel.productCountController.text)
              ? viewModel.product!.inCart!
                  ? () {}
                  : viewModel.onAddingToCart
              : null,
        )
      ],
    );
  }
}
