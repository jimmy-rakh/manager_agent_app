import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/enum/order_statuses.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/order_details/order_details_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

class OrderActionWidget extends ViewModelWidget<OrderDetailsViewModel> {
  const OrderActionWidget({super.key});

  @override
  Widget build(BuildContext context, OrderDetailsViewModel viewModel) {
    if (viewModel.order?.status == OrderStatuses.needRework.cc) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppButton(
              width: ScreenSize.width *  .4,
              margin: EdgeInsets.fromLTRB(12, 12, 12, ScreenSize.height * .1),
              padding: const EdgeInsets.symmetric(vertical: 10),
              borderRadius: BorderRadius.circular(12),
              fillColor: Theme.of(context).primaryColor,
              text: 'orders.continue'.tr(),
              textStyle: Theme.of(context).textTheme.titleSmall!,
              onPressed: viewModel.submitOrderById),
          AppButton(
              width: ScreenSize.width *  .4,
              margin: EdgeInsets.fromLTRB(12, 12, 12, ScreenSize.height * .1),
              padding: const EdgeInsets.symmetric(vertical: 10),
              borderRadius: BorderRadius.circular(12),
              fillColor: AppColors.blood,
              text: 'orders.cancel'.tr(),
              textStyle: Theme.of(context).textTheme.titleSmall!,
              onPressed: viewModel.cancelOrderById)
        ],
      );
    }

    if ([OrderStatuses.onWay.cc, OrderStatuses.inPickup.cc]
        .contains(viewModel.order?.status)) {
      return AppButton(
          width: double.maxFinite,
          margin: EdgeInsets.fromLTRB(24, 24, 24, ScreenSize.height * .1),
          padding: const EdgeInsets.symmetric(vertical: 15),
          borderRadius: BorderRadius.circular(12),
          fillColor: Theme.of(context).primaryColor,
          text: 'common.confirm'.tr(),
          textStyle: Theme.of(context).textTheme.titleSmall!,
          onPressed: viewModel.onConfirm);
    }

    if (viewModel.order?.status == OrderStatuses.waitPay.cc) {
      return AppButton(
          width: double.maxFinite,
          margin: EdgeInsets.fromLTRB(24, 24, 24, ScreenSize.height * .1),
          padding: const EdgeInsets.symmetric(vertical: 15),
          borderRadius: BorderRadius.circular(12),
          fillColor: Theme.of(context).primaryColor,
          text: 'common.pay'.tr(),
          textStyle: Theme.of(context).textTheme.titleSmall!,
          onPressed: viewModel.onPay);
    }

    if (viewModel.order?.status == OrderStatuses.completed.cc) {
      return Padding(
        padding: EdgeInsets.only(
            bottom: ScreenSize.height * .1, left: 16, right: 16),
        child: Row(children: [
          Expanded(
              child: AppButton(
            text: 'orders.chek'.tr(),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            borderRadius: BorderRadius.circular(12),
            fillColor: Theme.of(context).cardColor,
            onPressed: viewModel.shareInvoice,
            borderColor: Colors.black,
            icon: IconlyBold.paper_download,
          )),
          if (viewModel.order!.orderDetails!
              .any((element) => element.cartproduct!.product!.hasComment! == false)) ...[
            horizontalSpace16,
            Expanded(
              flex: 2,
              child: AppButton(
                text: 'orders.leave_review'.tr(),
                onPressed: viewModel.onAddReviewTapped,
                borderRadius: BorderRadius.circular(12),
                fillColor: Theme.of(context).cardColor,
                borderColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ]
        ]),
      );
    }

    return const SizedBox();
  }
}
