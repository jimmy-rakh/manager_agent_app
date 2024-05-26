import 'package:bingo/core/custom_widgets/product_cards/cart_product_widget.dart';
import 'package:bingo/core/custom_widgets/search_empty.dart';
import 'package:bingo/core/custom_widgets/section_title.dart';
import 'package:bingo/core/custom_widgets/string_hightlight.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/is_dark.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/nav_bar/routers/category/categories_router_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:stacked/stacked.dart';

class SearchView extends ViewModelWidget<CategoriesRouterViewModel> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, CategoriesRouterViewModel viewModel) {
    final isDark = isDarkModeEnabled(context);
    return KeyboardDismisser(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        height: double.maxFinite,
        width: double.maxFinite,
        child: viewModel.isSearched || viewModel.isSubCategoriesSelected
            ? viewModel.secondSearchVal?.results?.isEmpty ??
                    viewModel.searchedValues!.results!.isEmpty
                ? const SearchEmpty(isHistory: false)
                : Stack(children: [
                    ListView.separated(
                        controller: viewModel.searchScrollController,
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 124),
                        itemBuilder: (context, index) {
                          final product =
                              viewModel.secondSearchVal?.results?[index] ??
                                  viewModel.searchedValues!.results![index];
                          return CartProductWidget(
                            product: product,
                            onProductTapped: viewModel.onProductTapped,
                            quantityController:
                                viewModel.quantityController[index],
                            onDecrement: () => viewModel
                                .onChangeCount('', index, isIncrement: false),
                            onCountFieldTapped: viewModel.rebuild,
                            onIncrement: () => viewModel
                                .onChangeCount('', index, isIncrement: true),
                            onChange: (s) => viewModel.onChangeCount(s, index),
                            showDeleteAction: true,
                            onDeleteAction: () => product.quantity! >=
                                    int.parse(viewModel
                                        .quantityController[index].text)
                                ? product.inCart!
                                    ? viewModel.delFromCart(
                                        product,
                                      )
                                    : viewModel.onAddToCart(product,
                                        index: index)
                                : null,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return verticalSpace16;
                        },
                        itemCount: viewModel.secondSearchVal?.results?.length ??
                            viewModel.searchedValues?.results?.length ??
                            0),
                    viewModel.isBusy
                        ? const Positioned(
                            bottom: 80,
                            left: 0,
                            right: 0,
                            child: Center(child: CupertinoActivityIndicator()))
                        : const SizedBox()
                  ])
            :  const SizedBox(),
      ),
    );
  }
}
