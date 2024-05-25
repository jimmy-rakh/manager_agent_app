import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/data/models/orders/response/order_details_dto.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:bingo/domain/services/navigation_service/navigation_service.dart';
import 'package:bingo/domain/services/order_service/order_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

class AddReviewSheetViewModel extends BaseViewModel {
  final OrderService _orderService = getIt();

  late OrderDetailsDto order;
  TextEditingController commentController = TextEditingController();
  bool isActiveProductChoosing = false;
  ProductDto? product;
  double rating = 0;

  onReady(OrderDetailsDto order) {
    this.order = order;
    commentController.addListener(notifyListeners);
  }

  onRatingChanged(double rating) {
    this.rating = rating;
    notifyListeners();
  }

  onAddReview() async {
    setBusy(true);
    try {
      await _orderService.addReview(
          productId: product!.id!,
          comment: commentController.text,
          rating: rating.toInt());

      NavigationService.showSnackBar(
          snackBar: SnackBar(
              backgroundColor: AppColors.green,
              content: Row(
                children: [
                  const Icon(
                    IconlyLight.shield_done,
                    color: Colors.white,
                    size: 32,
                  ),
                  horizontalSpace12,
                  Text(
                    'review.thanks'.tr(),
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              )));
    } catch (e) {
      NavigationService.showErrorToast(e.toString());
    }
    setBusy(false);
    Navigator.pop(router.navigatorKey.currentContext!);
  }

  onProductTapped(ProductDto? product) {
    if (product == null) {
      isActiveProductChoosing = true;
    } else {
      this.product = product;
      isActiveProductChoosing = false;
    }

    notifyListeners();
  }

  isReviewAviable() {
    for (final product in order.orderDetails!) {
      if (product.cartproduct!.product!.hasComment == false) {
        break;
      }
    }
    return false;
  }
}
