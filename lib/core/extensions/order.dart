import 'dart:ui';
import 'package:collection/collection.dart';
import 'package:bingo/core/enum/order_statuses.dart';
import 'package:bingo/core/styles/colors.dart';

extension OrderExtension on String {
  Color orederColor() {
    OrderStatuses statusData =
        OrderStatuses.values.firstWhereOrNull((element) => element.cc == this) ?? OrderStatuses.newOrder;
    switch (statusData) {
      case OrderStatuses.newOrder:
        return AppColors.primary;
      case OrderStatuses.caceled:
        return AppColors.red;
      case OrderStatuses.isBeingCollectedWait:
        return AppColors.actionColor7;
      case OrderStatuses.isBeingCollected:
        return AppColors.actionColor6;
      case OrderStatuses.needRework:
        return AppColors.blood;
      case OrderStatuses.waitPay:
        return AppColors.cider;
      case OrderStatuses.paid:
        return AppColors.pine;
      case OrderStatuses.onWay:
        return AppColors.cornFlowerBlue;
      case OrderStatuses.inPickup:
        return AppColors.mediumPurple;
      case OrderStatuses.completed:
        return AppColors.green;
      default:
        return AppColors.bgDark;
    }
  }
}
