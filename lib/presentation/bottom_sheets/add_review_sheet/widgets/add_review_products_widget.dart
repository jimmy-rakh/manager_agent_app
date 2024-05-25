import 'package:bingo/core/custom_widgets/product_cards/cart_product_widget.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/presentation/bottom_sheets/add_review_sheet/add_review_sheet_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddReviewProductsWidget extends ViewModelWidget<AddReviewSheetViewModel> {
  const AddReviewProductsWidget({super.key});

  @override
  Widget build(BuildContext context, AddReviewSheetViewModel viewModel) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => viewModel.onProductTapped(null),
      child: Container(
          height:
              viewModel.product != null && !viewModel.isActiveProductChoosing
                  ? null
                  : ScreenSize.height *
                      (viewModel.isActiveProductChoosing
                          ? viewModel.order.orderDetails!.length > 2
                              ? .3
                              : .21
                          : .08),
          padding:
              viewModel.isActiveProductChoosing || viewModel.product != null
                  ? const EdgeInsets.all(12)
                  : null,
          width: double.maxFinite,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              border: Border.all(color: AppColors.grey, width: 1),
              borderRadius: BorderRadius.circular(12)),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: viewModel.isActiveProductChoosing
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      final order = viewModel.order.orderDetails![index];
                      return order.cartproduct!.product!.hasComment!
                          ? const SizedBox()
                          : CartProductWidget(
                              product: order.cartproduct!.product!,
                              isSmallType: true,
                              cardColor:
                                  Theme.of(context).colorScheme.background,
                              onProductTapped: viewModel.onProductTapped,
                            );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: AppColors.grey,
                      );
                    },
                    itemCount: viewModel.order.orderDetails!.length)
                : viewModel.product != null
                    ? CartProductWidget(
                        product: viewModel.product,
                        isSmallType: true,
                        cardColor: Theme.of(context).colorScheme.background,
                      )
                    :  Text("review.choose_product".tr()),
          )),
    );
  }
}
