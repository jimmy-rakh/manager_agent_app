import 'package:bingo/core/assets/assets.dart';
import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/custom_widgets/review_widget.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ProductReviewSheet extends StatelessWidget {
  const ProductReviewSheet({super.key, required this.reviews});

  final List<ProductCommentsDto> reviews;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: reviews.isEmpty ? .7 : .4,
        minChildSize: reviews.isEmpty ? .7 : .4,
        maxChildSize: .9,
        builder: (context, controller) {
          return Container(
              padding: const EdgeInsets.only(bottom: 100),
              color: Theme.of(context).cardColor,
              child: reviews.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(AppAssets.reviews, height: 240),
                          Text(
                            'product.empty_reviews'.tr(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          verticalSpace24,
                          AppButton(
                              text: 'common.close'.tr(),
                              width: 200,
                              fillColor: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(12),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 42, vertical: 16),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          verticalSpace45
                        ],
                      ),
                    )
                  : ListView.separated(
                      controller: controller,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(24),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        return index == 0
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Product Reviews',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () => Navigator.pop(context),
                                        child: Icon(
                                          IconlyLight.close_square,
                                          size: 32,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                        ),
                                      )
                                    ],
                                  ),
                                  verticalSpace12,
                                  ReviewWidget(review: review),
                                ],
                              )
                            : ReviewWidget(review: review);
                      },
                      separatorBuilder: (context, child) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(height: 1, color: AppColors.grey),
                        );
                      },
                      itemCount: reviews.length));
        });
  }
}
