import 'package:auto_route/annotations.dart';
import 'package:bingo/core/custom_widgets/app_bar.dart';
import 'package:bingo/core/extensions/order.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/order_details/order_details_viewmodel.dart';
import 'package:bingo/presentation/screens/order_details/widgets/action.dart';
import 'package:bingo/presentation/screens/order_details/widgets/order_info_view.dart';
import 'package:bingo/presentation/screens/order_details/widgets/product_section_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.orderId});

  final int orderId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderDetailsViewModel>.reactive(
        viewModelBuilder: () => OrderDetailsViewModel(),
        onViewModelReady: (model) => model.onReady(orderId),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: CustomAppBar(
              title: 'orders.order_number'.tr(args: [orderId.toString()]),
              actions: [
                if (!viewModel.isBusy || viewModel.order != null)
                  Container(
                    margin: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: viewModel.order!.status!.orederColor(),
                        borderRadius: BorderRadius.circular(4)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      'orders.${viewModel.order!.status!.toLowerCase()}'.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.white),
                    ),
                  )
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton:
            viewModel.isBusy ? const SizedBox()  :  const OrderActionWidget(),
            body: viewModel.isBusy || viewModel.order == null
                ? const Center(child: CupertinoActivityIndicator())
                : ListView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 160),
                    children: const [
                      OrderInfoView(),
                      verticalSpace16,
                      ProductSerctionView()
                    ],
                  ),
          );
        });
  }
}
