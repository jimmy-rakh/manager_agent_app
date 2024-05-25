import 'package:auto_route/annotations.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:bingo/presentation/screens/product/product_page.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CartProductScreen extends StatelessWidget {
  const CartProductScreen(
      {super.key,
      this.isFromSearch = false,
      this.incomingProduct,
      this.incomingProductId});

  final bool isFromSearch;
  final ProductDto? incomingProduct;
  final int? incomingProductId;

  @override
  Widget build(BuildContext context) {
    return ProductScreen(
      incomingNavIndex: 2,
      isFromSearch: isFromSearch,
      incomingProduct: incomingProduct,
      incomingProductId: incomingProductId,
    );
  }
}
