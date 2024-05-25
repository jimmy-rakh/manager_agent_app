import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/custom_widgets/product_cards/first_type_widget.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/selector/selector_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/styles/colors.dart';

class SelectorNavBar extends ViewModelWidget<SelectorViewModel> {
  const SelectorNavBar({super.key});

  @override
  Widget build(BuildContext context, SelectorViewModel viewModel) {
    return ColoredBox(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (viewModel.selectedProducts.isNotEmpty) ...[
              Row(
                children: [
                  Text(
                    '${"product.product".tr()}: ${viewModel.selectedProducts.length}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                   CircleAvatar(
                     backgroundColor: AppColors.primary,
                    radius: 12,
                    child: GestureDetector(
                      onTap: viewModel.selectedProductsVisibilityToogle,
                      child: Icon(
                        viewModel.showSelectedProducts ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                        color: AppColors.white,
                      ),
                    ),
                  )
                ],
              ),
              if (viewModel.showSelectedProducts)
                SizedBox(
                  height: 184,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.selectedProducts.length,
                    itemBuilder: (context, index) => FirstTypeProductCard(
                      product: viewModel.selectedProducts[index],
                      onProductTapped: viewModel.onAddProduct,
                    ),
                    separatorBuilder: (context, index) => horizontalSpace12,
                  ),
                ),
            ],
            if (viewModel.selectedProducts.isEmpty) ...[
               Text('review.choose_product'.tr())
            ],
            verticalSpace24,
            AppButton(
              text: 'card.add'.tr(),
              width: double.maxFinite,
              fillColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 15),
              borderRadius: BorderRadius.circular(12),
              isActive: viewModel.selectedProducts.isNotEmpty &&
                  viewModel.selectedProducts.length <= 100,
              onPressed: viewModel.onDone,
            ),
          ],
        ),
      ),
    );
  }
}
