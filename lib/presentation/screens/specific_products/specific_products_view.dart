import 'package:auto_route/auto_route.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/data/models/categories/catigories_dto.dart';
import 'package:bingo/presentation/screens/specific_products/specific_products_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bingo/core/custom_widgets/product_cards/first_type_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:stacked/stacked.dart';

import '../../../core/custom_widgets/product_cards/cart_product_widget.dart';
import '../../../core/styles/colors.dart';
import '../../../core/utils/spaces.dart';

@RoutePage()
class SpecificProductsScreen extends StatelessWidget {
  const SpecificProductsScreen({
    super.key,
    required this.category,
    required this.subcategory,
  });

  final CategoriesDto category, subcategory;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SpecificProductsViewModel>.reactive(
        onViewModelReady: (model) => model.onReady(subcategory),
        viewModelBuilder: () => SpecificProductsViewModel(),
        builder: (context, viewModel, child) {
          final currentWidth = MediaQuery.of(context).size.width;
          final crossCount = (currentWidth/ 300).floor();
          return KeyboardDismisser(
            child: Scaffold(
              body:  Stack(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.arrow_back_ios_outlined),
                              ),
                            ),
                            horizontalSpace10,
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  '${category.name!} - ${subcategory.name!}',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        viewModel.productType();
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: viewModel.isType == true
                                                ? AppColors.primary
                                                : AppColors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Icon(
                                              Icons.menu,
                                              color: viewModel.isType == true
                                                  ? AppColors.white
                                                  : AppColors.bgDark,
                                            ),
                                          ))),
                                  horizontalSpace10,
                                  GestureDetector(
                                      onTap: () {
                                        viewModel.productType();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: viewModel.isType == false
                                              ? AppColors.primary
                                              : AppColors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Icon(
                                            Icons.crop_square_outlined,
                                            color: viewModel.isType == false
                                                ? AppColors.white
                                                : AppColors.bgDark,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                viewModel.isBusy && viewModel.getProduct == true
                    ? const Center(child: CupertinoActivityIndicator())
                    :  Padding(
                        padding: const EdgeInsets.only(top: 45),
                        child: viewModel.isType == true
                            ? ListView.separated(
                          controller: viewModel.scrollController,
                                padding:
                                    const EdgeInsets.fromLTRB(20, 16, 20, 120),
                                shrinkWrap: true,
                                itemCount: viewModel
                                    .products!.results?.length ??
                                    viewModel
                                        .products!.singleResults!.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  final product = viewModel
                                              .products?.results![index].id ==
                                          null
                                      ? viewModel.products
                                          ?.singleResults![index].product!
                                      : viewModel.products?.results![index];
                                  return CartProductWidget(
                                    product: product,
                                    productTapped: viewModel.onProductTapped,
                                    quantityController:
                                        viewModel.quantityController[index],
                                    onDecrement: () =>
                                        viewModel.onChangeCount('', index,
                                            isIncrement: false),
                                    onCountFieldTapped: viewModel.rebuild,
                                    onIncrement: () =>
                                        viewModel.onChangeCount('', index,
                                            isIncrement: true),
                                    onChange: (s) =>
                                        viewModel.onChangeCount(s, index),
                                    showDeleteAction: true,
                                    onDeleteAction: () => product!.quantity! >= int.parse(viewModel.quantityController[index].text) ? product!.inCart!
                                        ? viewModel.delFromCart(
                                      product,
                                    )
                                        : viewModel.onAddToCart(product,
                                        index: index) : null,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return verticalSpace8;
                                },
                              )
                            : GridView.builder(
                            controller: viewModel.scrollController,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:currentWidth < 1400 && currentWidth > 1200 ? 4 : currentWidth < 1300 && currentWidth > 700 ? 3 : currentWidth < 600 ? 2 : crossCount,
                                        childAspectRatio: .6,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16),
                                padding: const EdgeInsets.only(
                                    left: 25, bottom: 120, right: 25),
                                itemCount: viewModel
                                    .products!.results?.length ??
                                    viewModel
                                        .products!.singleResults!.length,
                                itemBuilder: (context, index) {
                                  final product = viewModel
                                      .products?.results![index].id ==
                                      null
                                      ? viewModel.products
                                      ?.singleResults![index].product!
                                      : viewModel.products?.results![index];
                                  return FirstTypeProductCard(
                                    product: product!,
                                    width: double.maxFinite,
                                    onProductTapped:
                                        viewModel.onProductTapped,
                                    onAddToCart: product.inCart!
                                        ? viewModel.delFromCart
                                        : viewModel.onAddToCart,
                                  );
                                }),
                      ),
                      viewModel.isBusy && viewModel.loadmore == true
                          ? const Positioned(
                              bottom: 80,
                              left: 0,
                              right: 0,
                              child: Center(child: CupertinoActivityIndicator()))
                          : const SizedBox()
                    ]),
            ),
          );
        });
  }
}
