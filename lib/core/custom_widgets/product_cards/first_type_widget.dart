import 'package:bingo/core/custom_widgets/default_image_container.dart';
import 'package:bingo/core/utils/formatters.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:iconly/iconly.dart';

class FirstTypeProductCard extends StatelessWidget {
  const FirstTypeProductCard({
    Key? key,
    required this.product,
    this.width,
    this.height,
    this.onProductTapped,
    this.onAddToCart,
    this.selected = false,
  }) : super(key: key);

  final ProductDto product;
  final double? width;
  final double? height;
  final void Function({ProductDto product})? onProductTapped;
  final void Function(ProductDto)? onAddToCart;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Vibrate.feedback(FeedbackType.selection);
        onProductTapped!(product: product);
      },
      child: SizedBox(
        width: width ?? ScreenSize.width * .3,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),color: Theme.of(context).cardColor),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    DefaultImageContainer(
                        width: width ?? double.maxFinite,
                        imageUrl: product.imageUrl,
                        height: height ?? ScreenSize.width * .3,
                        heightCache: 250,
                        widthCache: 250,
                        backgroundColor: AppColors.white,
                        fit: BoxFit.contain,
                        radius: 12),
                    if (selected)
                      const Positioned(
                          top: 12,
                          right: 12,
                          child: Icon(
                            IconlyBold.tick_square,
                            color: AppColors.primary,
                          )),
                    if (product.rating != 0)
                      Positioned(
                          right: 10,
                          bottom: 10,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor.withOpacity(.8),
                                borderRadius: BorderRadius.circular(4)),
                            child: Row(
                              children: [
                                const Icon(IconlyBold.star,
                                    size: 10, color: AppColors.actionColor6),
                                horizontalSpace5,
                                Text(
                                  product.rating.toString(),
                                  style: Theme.of(context).textTheme.labelMedium,
                                )
                              ],
                            ),
                          ))
                  ],
                ),
                verticalSpace5,
                Text(
                  product.title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace10,
                Text(
                  '${Formatters.formattedMoney(product.price)} ${'common.sum'.tr()}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (onAddToCart != null) ...[
                  verticalSpace5,
                  GestureDetector(
                    onTap: () =>
                        product.quantity! >= 1 ? onAddToCart!(product) : null,
                    child: Container(
                      height: 30,
                      width: ScreenSize.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: product.inCart!
                              ? Colors.green
                              : AppColors.primary.withOpacity(
                                  (product.quantity ?? 0) >= 1 ? 1 : .5),
                          borderRadius: BorderRadius.circular(4)),
                      child: product.isBusy ?? false
                          ? const CupertinoActivityIndicator(
                              color: AppColors.white,
                            )
                          : Text(
                              (product.quantity ?? 0) >= 1
                                  ? product.inCart!
                                      ? 'common.in_cart'.tr()
                                      : 'common.add_to_cart_short'.tr()
                                  : 'common.unaviable'.tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w700),
                            ),
                    ),
                  )
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
