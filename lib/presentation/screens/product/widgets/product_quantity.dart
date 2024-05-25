import 'package:bingo/core/custom_widgets/quantity_widget.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/presentation/screens/product/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

class ProductQuantity extends ViewModelWidget<ProductViewModel> {
  const ProductQuantity({super.key});

  @override
  Widget build(BuildContext context, ProductViewModel viewModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        QuantityWidget(
          countController: viewModel.productCountController,
          onDecrement: () => viewModel.onChangeCount('',isIncrement: false),
          onIncrement: () => viewModel.onChangeCount('',isIncrement: true),
          onChanged:  viewModel.onChangeCount,
          focusNode: viewModel.quantityFocus,
        ),
        const Spacer(),
        const Icon(IconlyBold.star, size: 14, color: AppColors.actionColor6),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: ' ${viewModel.product?.rating}',
                  style: Theme.of(context).textTheme.labelLarge),
              TextSpan(
                  text: ' • ',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: AppColors.grey)),
              TextSpan(
                  text: '${viewModel.product?.comments?.length} Отзывов',
                  style: Theme.of(context).textTheme.labelLarge)
            ]))
      ],
    );
  }
}
