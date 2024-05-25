import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/product/product_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SimilarProducts extends ViewModelWidget<ProductViewModel> {
  const SimilarProducts({super.key});

  @override
  Widget build(BuildContext context, ProductViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'common.similiar_products'.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        verticalSpace16,
        // SizedBox(
        //   height: ScreenSize.height * .28,
        //   child: ListView.separated(
        //       physics: const BouncingScrollPhysics(),
        //       scrollDirection: Axis.horizontal,
        //       padding: const EdgeInsets.symmetric(horizontal: 24),
        //       itemBuilder: (BuildContext context, int index) {
        //         final product = viewModel.product!.similarProducts![index];
        //         return FirstTypeProductCard(
        //           product: product,
        //           onProductTapped: viewModel.onProductTapped,
        //           onAddToCart: (p) =>
        //               viewModel.onAddingToCart(similarProduct: p),
        //         );
        //       },
        //       separatorBuilder: (BuildContext context, int index) =>
        //           horizontalSpace16,
        //       itemCount: viewModel.product!.similarProducts!.length),
        // ),
      ],
    );
  }
}
