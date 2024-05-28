import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/share_utils.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/data/models/orders/response/order_details_dto.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:bingo/domain/services/navigation_service/navigation_service.dart';
import 'package:bingo/domain/services/order_service/order_service.dart';
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
    // await _orderService.fetchOrders();
    isReviewed();
  }

  onProductTapped(ProductDto? product) async {
    router.navigate(OrdersProductRoute(incomingProduct: product));
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


}
