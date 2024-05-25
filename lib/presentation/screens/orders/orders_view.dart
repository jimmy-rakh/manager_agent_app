import 'package:auto_route/annotations.dart';
import 'package:bingo/core/custom_widgets/app_bar.dart';
import 'package:bingo/core/custom_widgets/floating_tabbar.dart';
import 'package:bingo/presentation/screens/orders/orders_viewmodel.dart';
import 'package:bingo/presentation/screens/orders/pages/active.dart';
import 'package:bingo/presentation/screens/orders/pages/all.dart';
import 'package:bingo/presentation/screens/orders/pages/completed.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrdersScreenModel>.reactive(
        viewModelBuilder: () => OrdersScreenModel(),
        onViewModelReady: (model) => model.onReady(mixin: this),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: CustomAppBar(
              title: 'orders.orders_title'.tr(),
              showLeading: false,
              textStyle: Theme.of(context).textTheme.titleLarge,
            ),
            body: const AllOrdersView(),
          );
        });
  }
}
