import 'package:bingo/core/utils/datetime_utils.dart';
import 'package:bingo/data/models/orders/response/order_list_dto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/core/extensions/order.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
    required this.onTap,
  });

  final OrderDto order;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(order.id!),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border:
                Border.all(color: order.status!.orederColor().withOpacity(.6)),
            borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Text(
                  '№ ${order.id}',
                  style: Theme.of(context).textTheme.titleMedium,
                )),
                Text(
                  'common.products_count'.tr(args: [order.count.toString()]),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.grey),
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'common.status'.tr(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      verticalSpace5,
                      Text('orders.${order.status!.toLowerCase()}'.tr(),
                          style: Theme.of(context).textTheme.labelLarge)
                    ],
                  ),
                ),
                horizontalSpace10,
                SizedBox(
                  height: 40,
                  child: VerticalDivider(
                    width: 1,
                    color: AppColors.grey.withOpacity(.5),
                  ),
                ),
                horizontalSpace10,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          order.deliveryTime != null
                              ? 'orders.will_be_delivered'.tr()
                              : 'common.date'.tr(),
                          style: Theme.of(context).textTheme.labelSmall),
                      verticalSpace5,
                      Text(
                          order.deliveryTime != null
                              ? DateTime.parse(order.deliveryTime!)
                                  .dateTimeFormatter()
                              : DateTime.parse('${order.createdAt!}Z')
                                  .dateTimeFormatter(),
                          style: Theme.of(context).textTheme.labelLarge)
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color returnColor() {
    switch (order.status) {
      case 'NEW':
        return AppColors.primary;
      case 'ACCEPTED':
        return AppColors.actionColor5;
      case 'CANCELED':
        return AppColors.red;
      case 'COMPLETED':
        return AppColors.green;
      default:
        return AppColors.bgDark;
    }
  }
}
