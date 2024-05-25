import 'package:auto_route/auto_route.dart';
import 'package:bingo/presentation/screens/order_details/order_details_view.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OrdersOrderScreen extends StatelessWidget {
  const OrdersOrderScreen({super.key, required this.orderId});
  final int orderId;

  @override
  Widget build(BuildContext context) {
    return OrderDetailsScreen(orderId: orderId);
  }
}
