import 'package:bingo/core/assets/assets.dart';
import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/custom_widgets/product_cards/cart_product_widget.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/cart/cart_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CartProductsWidget extends ViewModelWidget<CartViewModel> {
  const CartProductsWidget({super.key});

  @override
  Widget build(BuildContext context, CartViewModel viewModel) {
    return viewModel.cartData == null
        ? const Center(child: CupertinoActivityIndicator())
        : viewModel.cartData!.cartproducts!.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.emptyCart, height: 240),
                    Text(
                      'cart.empty_cart'.tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    verticalSpace12,
                    AppButton(
                        text: 'common.to_products'.tr(),
                        width: 200,
                        textColor: AppColors.white,
                        fillColor: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 42, vertical: 16),
                        onPressed: () {
                          viewModel.toCategoryScreen();
                        })
                  ],
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 150),
                shrinkWrap: true,
                itemCount: viewModel.cartData?.cartproducts?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  final cartProduct = viewModel.cartData!.cartproducts![index];
                  return CartProductWidget(
                    cartProduct: cartProduct,
                    quantityController: viewModel.productsQuantity[index],
                    onDecrement: () =>
                        viewModel.onChangeCount('', index, isIncrement: false),
                    onCountFieldTapped: viewModel.rebuild,
                    onIncrement: () =>
                        viewModel.onChangeCount('', index, isIncrement: true),
                    onChange: (s) => viewModel.onChangeCount(s, index),

                    focusNode: viewModel.quantityFocus[index],
                    isSelected: viewModel.selectedCartProductsId
                        .contains(cartProduct.product!.id),
                    onProductTapped: viewModel.showCheckboxes
                        ? (product) => viewModel.onProductSelect(product.id!)
                        : viewModel.onProductTapped,
                    onSelect: viewModel.onProductSelect,
                    showCheckbox: viewModel.showCheckboxes,
                    showDeleteAction: true,
                    onDeleteAction: () =>
                        viewModel.delFromCart(product: cartProduct.product),
                  );
                },
                separatorBuilder: (context, index) {
                  return verticalSpace12;
                },
              );
  }
}
