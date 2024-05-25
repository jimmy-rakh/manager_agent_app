import 'package:bingo/core/custom_widgets/product_cards/cart_product_widget.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/data/models/orders/response/order_details_dto.dart';
import 'package:bingo/presentation/screens/order_details/order_details_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProductSerctionView extends ViewModelWidget<OrderDetailsViewModel> {
  const ProductSerctionView({super.key});

  @override
  Widget build(BuildContext context, OrderDetailsViewModel viewModel) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).cardColor),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'orders.order_products'.tr(),
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              verticalSpace12,
              for (OrderProductsDto order in viewModel.order!.orderDetails!) ...[
                CartProductWidget(
                  product: order.cartproduct!.product!,
                  quantity: order.cartproduct!.quantity,
                  existsQuantity: order.existsQuantity,
                  isSmallType: true,
                  onProductTapped: viewModel.onProductTapped,
                ),
                verticalSpace16
              ],
            ]));
  }
}
