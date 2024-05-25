import 'package:bingo/core/custom_widgets/product_cards/cart_product_widget.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/checkout/checkout_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CartProductsWidget extends ViewModelWidget<CheckoutViewModel> {
  const CartProductsWidget({super.key});

  @override
  Widget build(BuildContext context, CheckoutViewModel viewModel) {
    return viewModel.isBusy
        ? CupertinoActivityIndicator()
        : Column(children: [
            for (int index = 0;
                index <
                    (viewModel.template?.templateproducts?.length ??
                        viewModel.cartData!.cartproducts!.length);
                index++) ...[
              CartProductWidget(
                  cartProduct: viewModel.template?.templateproducts?[index] ??
                      viewModel.cartData!.cartproducts![index]),
              verticalSpace16
            ],
          ]);
  }
}
