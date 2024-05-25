import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/data/models/orders/response/order_details_dto.dart';
import 'package:bingo/domain/services/navbar_service/navbar_service.dart';
import 'package:bingo/domain/services/order_service/order_service.dart';
import 'package:stacked/stacked.dart';

class SuccessOrderViewModel extends ReactiveViewModel {
  final NavBarService _navBarService = getIt();
  final OrderService _orderService = getIt();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_navBarService, _orderService];

  OrderDetailsDto get lastCreatedOrder => _orderService.lastCreatedOrder!;

  closeDialog({int index = 0}) {
    _navBarService.onChange(index);
    router.replace(const SplashRoute());
  }
}
