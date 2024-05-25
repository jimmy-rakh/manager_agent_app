import 'package:bingo/core/custom_widgets/product_cards/cart_product_widget.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/account/pages/favorites/favorites_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FavoritesBody extends ViewModelWidget<FavoritesViewModel> {
  const FavoritesBody({super.key});

  @override
  Widget build(BuildContext context, FavoritesViewModel viewModel) {
    return  ListView.separated(
        itemBuilder: (context, index) {
          final favorite = viewModel.favorites![index];

          return CartProductWidget(
            onProductTapped: viewModel.onProductTapped,
            product: favorite.product,
            isFavorite: true,
            showDeleteAction: true,
            onDeleteAction: () => viewModel.delFromFavorites(favorite.product.id!),
          );
        },
        separatorBuilder: (context, index) {
          return verticalSpace16;
        },
        itemCount: viewModel.favorites?.length ?? 0,
        padding: const EdgeInsets.symmetric(horizontal: 24),);
  }
}
