import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OrdersRouterScreen extends StatelessWidget {
  const OrdersRouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
