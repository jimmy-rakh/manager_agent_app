import 'package:bingo/core/assets/assets.dart';
import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/custom_widgets/product_cards/cart_product_widget.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/template/template_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class TemplateBody extends ViewModelWidget<TemplateViewModel> {
  const TemplateBody({super.key});

  @override
  Widget build(BuildContext context, TemplateViewModel viewModel) {
    return viewModel.isBusy
        ? const Center(child: CupertinoActivityIndicator())
        : (viewModel.template.templateproducts?.isEmpty ?? true)
            ? Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: ScreenSize.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppAssets.emprtyBox),
                      verticalSpace12,
                      Text(
                        'common.template_empty'.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      verticalSpace24,
                      AppButton(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        borderRadius: BorderRadius.circular(12),
                        fillColor: Theme.of(context).primaryColor,
                        text: 'common.to_products'.tr(),
                        onPressed: viewModel.chooseProducts,
                      )
                    ],
                  ),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final product = viewModel.template.templateproducts![index];
                  return CartProductWidget(
                    cartProduct: product,
                    quantityController: viewModel.productsQuantity[index],
                    focusNode: viewModel.quantityFocus[index],
                    showDeleteAction: true,
                    showCheckbox: viewModel.showCheckboxes,
                    isSelected: viewModel.selectedTemplateProductsId
                        .contains(product.product!.id),
                    onDecrement: () =>
                        viewModel.onChangeCount('', index, isIncrement: false),
                    onIncrement: () =>
                        viewModel.onChangeCount('', index, isIncrement: true),
                    onChange: (s) => viewModel.onChangeCount(s, index),
                    onDeleteAction: () =>
                        viewModel.onDeleteProduct(product: product),
                    onProductTapped: viewModel.onProductTapped,
                    onSelect: viewModel.onProductSelect,
                  );
                },
                separatorBuilder: (context, index) => verticalSpace16,
                itemCount: viewModel.template.templateproducts!.length,
              );
  }
}
