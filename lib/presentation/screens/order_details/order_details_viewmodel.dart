import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/share_utils.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/data/models/orders/response/order_details_dto.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:bingo/domain/services/navigation_service/navigation_service.dart';
import 'package:bingo/domain/services/order_service/order_service.dart';
import 'package:bingo/presentation/bottom_sheets/add_review_sheet/add_review_sheet_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

class OrderDetailsViewModel extends ReactiveViewModel {
  final OrderService _orderService = getIt();

  @override
  List<ListenableServiceMixin> get listenableServices => [_orderService];

  late int orderId;
  OrderDetailsDto? order;

  onReady(int orderId) {
    this.orderId = orderId;
    getData();
  }

  Future<void> getData() async {
    setBusy(true);
    try {
      order = await _orderService.getOrder(orderId);
    } catch (e) {
      // TODO NavigationService.back(navIndex: 3);
      // NavigationService.showCustomDialog(
      //     dialog: const ErrorDialogView(), padding: 24);
      // NavigationService.showErrorToast(e.toString());
    }
    setBusy(false);
    await _orderService.fetchOrders();
    isReviewed();
  }

  onProductTapped(ProductDto? product) async {
    router.navigate(OrdersProductRoute(incomingProduct: product));
  }

  onAddReviewTapped() async {
    await NavigationService.showBottomSheet(
        sheet: AddReviewSheetView(order: order!));
    getData();
  }

  isReviewed() {
    if (order != null) {
      for (final product in order!.orderDetails!) {
        print(product.cartproduct!.product!.hasComment);
      }
    }
  }

  void shareInvoice() {
    ShareService.share('https://test-api.okans.uz${order!.invoice!}',
        subject: 'common.receipt'.tr(),
        title: 'orders.order_number'.tr(args: [orderId.toString()]));
  }

  void onPay() async {
    final res =
        await router.push(ConfirmPaymentRoute(orderId: orderId)) ?? false;

    if (res as bool) {
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
                    'common.pay_comfirm'.tr(),
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              )));
      getData();
    }
  }

  void onConfirm() async {
    final res = await router.push(ScannerRoute(order: order!)) ?? false;

    if (res as bool) {
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
                    'common.order_comfirm'.tr(),
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              )));
      getData();
    }
  }

  void submitOrderById() async {
    setBusy(true);
    try {
      await _orderService.submitOrderById(orderId);
    } catch (e) {
      debugPrintStack(label: e.toString());
    }
    setBusy(false);

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
                  'common.order_comfirm'.tr(),
                  style: const TextStyle(color: Colors.white),
                )
              ],
            )));
    getData();
  }

  void cancelOrderById() async {
    setBusy(true);
    try {
      await _orderService.cancelOrderById(orderId);
    } catch (e) {
      debugPrintStack(label: e.toString());
    }
    setBusy(false);

    NavigationService.showSnackBar(
        snackBar: SnackBar(
            backgroundColor: AppColors.red,
            content: Row(
              children: [
                const Icon(
                  IconlyLight.shield_done,
                  color: Colors.white,
                  size: 32,
                ),
                horizontalSpace12,
                Text(
                  'common.order_cancel'.tr(),
                  style: const TextStyle(color: Colors.white),
                )
              ],
            )));
    getData();
  }
}
