import 'package:bingo/core/custom_widgets/product_cards/first_type_widget.dart';
import 'package:bingo/core/custom_widgets/title_section.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:flutter/material.dart';
import 'package:bingo/core/utils/spaces.dart';

class HorizontalProducts extends StatelessWidget {
  const HorizontalProducts(
      {super.key,
      required this.products,
      required this.onProductTapped,
       this.onAddToCart,
       this.onDelFromCart,
      required this.onLabelTapped,
      required this.labelName});

  final ProductsPagination products;
  final void Function({ProductDto product}) onProductTapped;
  final void Function(ProductDto)? onAddToCart;
  final void Function(ProductDto)? onDelFromCart;
  final void Function(String) onLabelTapped;
  final String labelName;

  @override
  Widget build(BuildContext context) {
    final screenHeight = ScreenSize.height;
    final pixelRatio = ScreenSize.pixelRatio;
    final horizontalListHeight = screenHeight / (pixelRatio < 2.8 ? 4 : 3.8);
    return Column(
      children: [
        TitleSectionWidget(
            name: labelName, onTap: () => onLabelTapped(labelName)),
        SizedBox(
          height: horizontalListHeight,
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final product = products.results![index].id == null
                    ? products.singleResults![index].product!
                    : products.results![index];
                return FirstTypeProductCard(
                  product: product,
                  onProductTapped: onProductTapped,
                  onAddToCart: product.inCart! ? onDelFromCart : onAddToCart,
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  horizontalSpace16,
              itemCount: products.results?.length ?? 0),
        ),
      ],
    );
  }
}
