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
        ]),
      );
    }

    return const SizedBox();
  }
}
