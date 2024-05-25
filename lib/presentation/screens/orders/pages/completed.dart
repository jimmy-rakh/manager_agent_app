import 'package:bingo/core/custom_widgets/order_card.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/orders/orders_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CompletedOrdersView extends ViewModelWidget<OrdersScreenModel> {
  const CompletedOrdersView({super.key});

  @override
  Widget build(BuildContext context, OrdersScreenModel viewModel) {
    return ListView.separated(
      controller: viewModel.scrollController,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
      itemCount: viewModel.completedOrders?.results?.length ?? 0,
      itemBuilder: (BuildContext _, index) {
        final order = viewModel.completedOrders!.results![index];
        return OrderCard(order: order, onTap: viewModel.toOrderView);
      },
      separatorBuilder: (BuildContext _, index) {
        return verticalSpace16;
      },
    );
  }
}
