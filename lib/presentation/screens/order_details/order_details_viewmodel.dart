import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/utils/share_utils.dart';
import 'package:bingo/data/models/orders/response/order_details_dto.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:bingo/domain/services/order_service/order_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';

import '../../../domain/services/client_service.dart';

class OrderDetailsViewModel extends ReactiveViewModel {
  final OrderService _orderService = getIt();
  final ClientService _clientService = getIt();
  @override
  List<ListenableServiceMixin> get listenableServices => [_orderService];
  int? get inn => _clientService.inn;
  late int orderId;
  OrderDetailsDto? order;

  onReady(int orderId) {
    this.orderId = orderId;
    getData();
  }

  Future<void> getData() async {
    setBusy(true);
    try {
      print("----------------${order?.id}");
      order = await _orderService.getOrder(inn,orderId);
      print("----------------${order?.id}");
    } catch (e) {
     print(e);
    }
    setBusy(false);
    // await _orderService.fetchOrders();
    // isReviewed();
  }

  onProductTapped(ProductDto? product) async {
    router.navigate(OrdersProductRoute(incomingProduct: product));
  }


  // isReviewed() {
  //   if (order != null) {
  //     for (final product in order!.orderDetails!) {
  //       print(product.cartproduct!.product!.hasComment);
  //     }
  //   }
  // }

  void shareInvoice() {
    ShareService.share('https://test-api.okans.uz${order!.invoice!}',
        subject: 'common.receipt'.tr(),
        title: 'orders.order_number'.tr(args: [orderId.toString()]));
  }


}
