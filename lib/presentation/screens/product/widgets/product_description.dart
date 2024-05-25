import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/presentation/screens/product/product_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:stacked/stacked.dart';

class ProductDescription extends ViewModelWidget<ProductViewModel> {
  const ProductDescription({super.key});

  @override
  Widget build(BuildContext context, ProductViewModel viewModel) {
    return viewModel.isBusy ||
            viewModel.product?.description == null ||
            viewModel.product!.description!.isEmpty
        ? const SizedBox()
        : Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12)),
            width: ScreenSize.width,
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'product.description'.tr(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Html(
                  data: viewModel.product?.description ?? '',
                ),
              ],
            ),
          );
  }
}
