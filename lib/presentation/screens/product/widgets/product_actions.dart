import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/product/product_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

class ProductActions extends ViewModelWidget<ProductViewModel> {
  const ProductActions({super.key});

  @override
  Widget build(BuildContext context, ProductViewModel viewModel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (viewModel.product?.productcharacters?.isNotEmpty ?? false) ...[
          verticalSpace16,
          GestureDetector(
            onTap: viewModel.showProductDetails,
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                const Icon(IconlyLight.document),
                horizontalSpace12,
                Text('product.product_details'.tr()),
                const Spacer(),
                const Icon(CupertinoIcons.forward)
              ],
            ),
          ),
          verticalSpace16,
          const Divider(
            height: 2,
            color: AppColors.grey,
          ),
          verticalSpace16,
        ],
        if (viewModel.product?.comments?.isNotEmpty ?? false) ...[
          GestureDetector(
            onTap: viewModel.showComments,
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                const Icon(IconlyLight.message),
                horizontalSpace12,
                Text('product.reviews'.tr()),
                const Spacer(),
                Text(
                  'product.review_count'.tr(args: [
                    viewModel.product?.comments?.length.toString() ?? ''
                  ]),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: AppColors.grey),
                ),
                horizontalSpace10,
                const Icon(CupertinoIcons.forward)
              ],
            ),
          ),
          verticalSpace16
        ],
      ],
    );
  }
}
