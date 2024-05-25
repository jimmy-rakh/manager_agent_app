import 'package:bingo/core/custom_widgets/product_cards/first_type_widget.dart';
import 'package:bingo/presentation/screens/selector/selector_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SelectorBody extends ViewModelWidget<SelectorViewModel> {
  const SelectorBody({super.key});

  @override
  Widget build(BuildContext context, SelectorViewModel viewModel) {
    return viewModel.isBusy
        ? const Center(child: CupertinoActivityIndicator())
        : GridView.builder(
            controller: viewModel.scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: viewModel.searchResponse.results?.length ?? 0,
            itemBuilder: (context, index) => FirstTypeProductCard(
              product: viewModel.searchResponse.results![index],
              onProductTapped: viewModel.onAddProduct,
              selected: viewModel.selectedProducts.contains(
                viewModel.searchResponse.results![index],
              ),
            ),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              childAspectRatio: .65,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
          );
  }
}
