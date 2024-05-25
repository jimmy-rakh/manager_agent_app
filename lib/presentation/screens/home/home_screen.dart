import 'package:auto_route/annotations.dart';
import 'package:bingo/core/custom_widgets/horizontal_products.dart';
import 'package:bingo/core/custom_widgets/product_cards/first_type_widget.dart';
import 'package:bingo/core/custom_widgets/title_section.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/home/home_viewmodel.dart';
import 'package:bingo/presentation/screens/home/widgets/posters_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:stacked/stacked.dart';

import '../../../core/custom_widgets/product_cards/cart_product_widget.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onViewModelReady: (model) => model.onReady(),
        builder: (context, viewModel, child) {
          final screenWidth = ScreenSize.width;
          final pixelRatio = ScreenSize.pixelRatio;
          return RefreshIndicator.adaptive(
            onRefresh: viewModel.onRefresh,
            color: Theme.of(context).primaryColor,
            child: KeyboardDismisser(
              child: Stack(
                children: [
                  ListView(
                      padding: const EdgeInsets.only(bottom: 160),
                      controller: viewModel.homeScreenScrollController,
                      children: [
                        verticalSpace60,
                        const PostersSection(),
                        // Skeletonizer(
                        //     enabled:
                        //         viewModel.popularProducts?.results?.first.infav ==
                        //             null,
                        //     child: HorizontalProducts(
                        //         products: viewModel.popularProducts!,
                        //         onProductTapped: viewModel.onProductTapped,
                        //         onAddToCart: viewModel.onAddToCart,
                        //         onDelFromCart: viewModel.delFromCart,
                        //         onLabelTapped: viewModel.toSpecificProductsPage,
                        //         labelName: 'common.popular'.tr())),
                        if (viewModel.lastViewedProducts?.results?.isNotEmpty ??
                            false)
                          HorizontalProducts(
                              products: viewModel.lastViewedProducts!,
                              onProductTapped: viewModel.onProductTapped,
                              onLabelTapped: viewModel.toSpecificProductsPage,
                              labelName: 'common.viewed'.tr()),
                        // TitleSectionWidget(name: 'search.brands'.tr(), onTap: () {}),
                        // const BrandsList(),
                        if (viewModel.popularProducts?.results?.isNotEmpty ??
                            false) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TitleSectionWidget(name: 'common.popular'.tr()),
                              Padding(
                                padding: const EdgeInsets.all(12),
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
                                    horizontalSpace8,
                                    GestureDetector(
                                        onTap: () {
                                          viewModel.productType();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                              )
                            ],
                          ),
                          viewModel.isType == true
                              ? ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  shrinkWrap: true,
                                  itemCount: viewModel
                                          .popularProducts!.results?.length ??
                                      viewModel.popularProducts!.singleResults!
                                          .length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final product = viewModel.popularProducts
                                                ?.results![index].id ==
                                            null
                                        ? viewModel.popularProducts
                                            ?.singleResults![index].product!
                                        : viewModel
                                            .popularProducts?.results![index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: CartProductWidget(
                                        product: product,
                                        productTapped:
                                            viewModel.onProductTapped,
                                        quantityController:
                                            viewModel.quantityController[index],
                                        onDecrement: () =>
                                            viewModel.onChangeCount('', index,
                                                isIncrement: false),
                                        onCountFieldTapped: viewModel.rebuild,
                                        focusNode:
                                            viewModel.quantityFocus[index],
                                        onIncrement: () =>
                                            viewModel.onChangeCount('', index,
                                                isIncrement: true),
                                        onChange: (s) =>
                                            viewModel.onChangeCount(s, index),
                                        showDeleteAction: true,
                                        onDeleteAction: () => product!
                                                    .quantity! >=
                                                int.parse(viewModel
                                                    .quantityController[index]
                                                    .text)
                                            ? product.inCart!
                                                ? viewModel.delFromCart(
                                                    product,
                                                  )
                                                : viewModel.onAddToCart(product,
                                                    index: index)
                                            : null,
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return verticalSpace5;
                                  },
                                )
                              : GridView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent:
                                              screenWidth > 400 ? 150 : 200,
                                          childAspectRatio: screenWidth > 400
                                              ? .48
                                              : pixelRatio < 3
                                                  ? .68
                                                  : .7,
                                          crossAxisSpacing: 16,
                                          mainAxisSpacing: 16),
                                  padding: const EdgeInsets.only(
                                      left: 25, bottom: 0, right: 25),
                                  itemCount: viewModel
                                          .popularProducts!.results?.length ??
                                      viewModel.popularProducts!.singleResults
                                          ?.length,
                                  itemBuilder: (context, index) {
                                    final product = viewModel.popularProducts
                                                ?.results![index].id ==
                                            null
                                        ? viewModel.popularProducts
                                            ?.singleResults![index].product!
                                        : viewModel
                                            .popularProducts?.results![index];
                                    return FirstTypeProductCard(
                                      product: product!,
                                      width: double.maxFinite,
                                      onProductTapped:
                                          viewModel.onProductTapped,
                                      onAddToCart: product.inCart!
                                          ? viewModel.delFromCart
                                          : viewModel.onAddToCart,
                                    );
                                  })
                        ]
                      ]),
                  viewModel.isBusy
                      ? const Positioned(
                          bottom: 114,
                          left: 0,
                          right: 0,
                          child: Center(child: CupertinoActivityIndicator()))
                      : const SizedBox()
                ],
              ),
            ),
          );
        });
  }
}
