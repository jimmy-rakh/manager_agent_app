import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/custom_widgets/default_image_container.dart';
import 'package:bingo/core/custom_widgets/quantity_widget.dart';
import 'package:bingo/core/utils/formatters.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/data/models/products/response/cart_model.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:iconly/iconly.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class CartProductWidget extends StatelessWidget {
  const CartProductWidget({
    super.key,
    this.quantityController,
    this.cartProduct,
    this.onSelect,
    this.onIncrement,
    this.onDecrement,
    this.onChange,
    this.focusNode,
    this.isSelected,
    this.onProductTapped,
    this.productTapped,
    this.product,
    this.onAddToCart,
    this.isFavorite = false,
    this.showCheckbox = false,
    this.showDeleteAction = false,
    this.onDeleteAction,
    this.isSmallType = false,
    this.cardColor,
    this.quantity,
    this.existsQuantity,
    this.onCountFieldTapped,
  });

  final Cartproducts? cartProduct;
  final ProductDto? product;
  final TextEditingController? quantityController;
  final bool? isSelected;
  final void Function(int)? onSelect;
  final void Function()? onIncrement;
  final void Function()? onDecrement;
  final void Function(ProductDto)? onProductTapped;
  final void Function({ProductDto product})? productTapped;
  final void Function(String)? onChange;
  final void Function()? onAddToCart;
  final void Function()? onDeleteAction;
  final FocusNode? focusNode;
  final bool isFavorite;
  final bool showCheckbox;
  final bool showDeleteAction;
  final bool isSmallType;
  final Color? cardColor;
  final int? quantity;
  final int? existsQuantity;
  final VoidCallback? onCountFieldTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onProductTapped != null
          ? () {
              Vibrate.feedback(FeedbackType.selection);
              onProductTapped!(cartProduct?.product ?? product!);
            }
          : () {productTapped!(product: product!);},
      onLongPress: onSelect != null
          ? () => onSelect!(cartProduct?.product?.id ?? product!.id!)
          : null,
      child: Stack(
        children: [
          Container(
            width: double.maxFinite,
            padding: isSmallType
                ? EdgeInsets.zero
                : EdgeInsets.fromLTRB(
                    12, 16, showDeleteAction && !showCheckbox ? 32 : 16, 16),
            decoration: BoxDecoration(
                color: cardColor ?? Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: isSmallType
                    ? null
                    : [
                        BoxShadow(
                            blurRadius: 5,
                            color: AppColors.grey.withOpacity(.2))
                      ]),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DefaultImageContainer(
                      imageUrl:
                          cartProduct?.product?.imageUrl ?? product?.imageUrl,
                      height: ScreenSize.height * (isSmallType ? .08 : .1),
                      width: ScreenSize.height * (isSmallType ? .08 : .1),
                      widthCache:180,
                      heightCache: 180,
                      backgroundColor: AppColors.white,
                      radius: 12),
                  horizontalSpace10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(cartProduct?.product?.title ?? product!.title!,
                              maxLines: 2, overflow: TextOverflow.ellipsis),
                        ),
                        quantityController == null && product == null
                            ? verticalSpace35
                            : verticalSpace10,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: Formatters.formattedMoney(
                                            (cartProduct?.quantity ?? 1) *
                                                (cartProduct?.product?.price ??
                                                    product!.price!))
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                    children: [
                                  TextSpan(
                                      text: ' ${'common.sum'.tr()}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: AppColors.grey)),
                                ])),
                            if ((quantityController == null &&
                                    cartProduct != null) ||
                                quantity != null)
                              ...[],
                            verticalSpace10,
                            if (quantity != null)
                              Text(
                                  '${'checkout.quantity_title'.tr()}: ${cartProduct?.quantity ?? quantity ?? 0} ${'common.piece'.tr()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: existsQuantity == null
                                              ? AppColors.green
                                              : AppColors.grey)),
                            if (existsQuantity != null)
                              Text(
                                  '${'checkout.exists_title'.tr()}: $existsQuantity ${'common.piece'.tr()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.green))
                          ],
                        ),
                        if (product != null && onAddToCart != null) ...[
                          verticalSpace5,
                          AppButton(
                            text: product!.inCart ?? false
                                ? 'common.in_cart'.tr()
                                : 'common.add_to_cart_short'.tr(),
                            onPressed: onAddToCart,
                            height: 30,
                            width: 120,
                            isActive: product!.quantity! >= 1,
                            textStyle: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                            borderRadius: BorderRadius.circular(4),
                            fillColor: product!.inCart ?? false
                                ? Colors.green
                                : AppColors.primary,
                          )
                        ],
                        if (quantityController != null)
                         product != null ? product!.inCart! ? const SizedBox() :  Row(
                            children: [
                              QuantityWidget(
                                countController: quantityController!,
                                onIncrement: onIncrement!,
                                onDecrement: onDecrement!,
                                onChanged: onChange!,
                                focusNode: focusNode,
                                onFieldTapped: onCountFieldTapped,
                              ),
                              const Spacer(),
                              if (showCheckbox)
                                MSHCheckbox(
                                  size: 18,
                                  value: isSelected!,
                                  isDisabled: false,
                                  colorConfig: MSHColorConfig
                                      .fromCheckedUncheckedDisabled(
                                    checkedColor:
                                        Theme.of(context).primaryColor,
                                    uncheckedColor: AppColors.grey,
                                  ),
                                  style: MSHCheckboxStyle.fillScaleColor,
                                  onChanged: (selected) => onSelect!(
                                      cartProduct?.product?.id ?? product!.id!),
                                ),
                            ],
                          ) :  Row(
                           children: [
                             QuantityWidget(
                               countController: quantityController!,
                               onIncrement: onIncrement!,
                               onDecrement: onDecrement!,
                               onChanged: onChange!,
                               focusNode: focusNode,
                               onFieldTapped: onCountFieldTapped,
                             ),
                             const Spacer(),
                             if (showCheckbox)
                               MSHCheckbox(
                                 size: 18,
                                 value: isSelected!,
                                 isDisabled: false,
                                 colorConfig: MSHColorConfig
                                     .fromCheckedUncheckedDisabled(
                                   checkedColor:
                                   Theme.of(context).primaryColor,
                                   uncheckedColor: AppColors.grey,
                                 ),
                                 style: MSHCheckboxStyle.fillScaleColor,
                                 onChanged: (selected) => onSelect!(
                                     cartProduct?.product?.id ?? product!.id!),
                               ),
                           ],
                         ),
                      ],
                    ),
                  ),
                ]),
          ),
          if (showDeleteAction && !showCheckbox)
            Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: onDeleteAction,
                  child: Container(
                    width: 40,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration:  BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        color:product == null ? AppColors.red : product!.inCart! ? AppColors.red : AppColors.green),
                    child:
                        product?.isBusy ?? cartProduct?.product?.isBusy ?? false
                            ? const CupertinoActivityIndicator(
                                color: AppColors.white,
                              )
                            : product == null ? const Icon(
                          IconlyLight.delete,
                          color: AppColors.white,
                        )  : product!.inCart! ? const Icon(
                                IconlyLight.delete,
                                color: AppColors.white,
                              ) : const Icon(
                          IconlyLight.buy,
                          color: AppColors.white,
                        ),
                  ),
                ))
        ],
      ),
    );
  }
}
