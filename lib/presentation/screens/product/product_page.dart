import 'package:auto_route/annotations.dart';
import 'package:bingo/core/custom_widgets/error_widget.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:bingo/presentation/screens/product/product_viewmodel.dart';
import 'package:bingo/presentation/screens/product/widgets/product_actions.dart';
import 'package:bingo/presentation/screens/product/widgets/product_appbar.dart';
import 'package:bingo/presentation/screens/product/widgets/product_description.dart';
import 'package:bingo/presentation/screens/product/widgets/product_gallery.dart';
import 'package:bingo/presentation/screens/product/widgets/product_price.dart';
import 'package:bingo/presentation/screens/product/widgets/product_quantity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class ProductScreen extends StatelessWidget {
  const ProductScreen(
      {Key? key,
      required this.incomingNavIndex,
      this.incomingProduct,
      this.isFromSearch = false,
      this.incomingProductId})
      : super(key: key);

  final int incomingNavIndex;
  final bool isFromSearch;
  final ProductDto? incomingProduct;
  final int? incomingProductId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductViewModel>.reactive(
        viewModelBuilder: () => ProductViewModel(),
        onDispose: (model) => model.onDispose(),
        onViewModelReady: (model) => model.onReady(
            incomingNavIndex: incomingNavIndex,
            isFromSearch: isFromSearch,
            incomingProduct: incomingProduct,
            incomingProductId: incomingProductId),
        builder: (context, viewModel, child) {
          return KeyboardDismisser(
            child: Scaffold(
                key: viewModel.scaffoldKey,
                body: RefreshIndicator.adaptive(
                    onRefresh: viewModel.onRefresh,
                    child: viewModel.incomingProduct == null &&
                            viewModel.product == null
                        ? const Center(
                            child: CupertinoActivityIndicator(),
                          )
                        : Stack(
                            children: [
                              ListView(
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.only(bottom: 100),
                                children: [
                                  const ProductGallery(),
                                  verticalSpace20,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            viewModel.incomingProduct?.title ??
                                                viewModel.product!.title!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    fontWeight: FontWeight.w300)),
                                        verticalSpace20,
                                        if (viewModel.isBusy &&
                                            viewModel.product == null)
                                          const Center(
                                              child:
                                                  CupertinoActivityIndicator()),
                                        if (viewModel.product != null) ...[
                                          const ProductQuantity(),
                                          verticalSpace20,
                                          const ProductPrice(),
                                        ],
                                        verticalSpace20,
                                        if (viewModel.product != null)
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 150,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("Бренд"),
                                                      Text(':'),
                                                    ],
                                                  ),
                                                ),
                                                horizontalSpace10,
                                                Text(
                                                    viewModel.product?.brand?.name ?? '')
                                              ],
                                            ),
                                            verticalSpace12,
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 150,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("Подкатегория"),
                                                      Text(':'),
                                                    ],
                                                  ),
                                                ),
                                                horizontalSpace10,
                                                SizedBox(width: 180,
                                                child: viewModel.product == null || viewModel.product!.subcategories!.isEmpty ? const SizedBox() : Text(viewModel.product?.subcategories
                                                    ?.first.name ??
                                                    '',maxLines: 1,),
                                                )
                                              ],
                                            ),
                                            verticalSpace12,
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 150,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("Цена"),
                                                      Text(':'),
                                                    ],
                                                  ),
                                                ),
                                                horizontalSpace10,
                                                Text("${viewModel.product?.price} сум")
                                              ],
                                            ),
                                            verticalSpace12,
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 150,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("Ед. измерение"),
                                                      Text(':'),
                                                    ],
                                                  ),
                                                ),
                                                horizontalSpace10,
                                                Text("${viewModel.product?.quantityInBox} ${viewModel.product?.measure}" ?? '')
                                              ],
                                            ),
                                            verticalSpace12,
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 150,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("Статус"),
                                                      Text(':'),
                                                    ],
                                                  ),
                                                ),
                                                horizontalSpace10,
                                                Text(viewModel.product?.status ?? '')
                                              ],
                                            ),
                                          ],
                                        ),
                                          verticalSpace16,
                                          const ProductDescription(),
                                          verticalSpace16,
                                        if (viewModel.product != null)
                                          const ProductActions(),
                                      ],
                                    ),
                                  ),
                                  // if (viewModel.product != null)
                                  //   const SimilarProducts(),
                                  if (viewModel.hasError)
                                    CustomErrorWidget(onRetTry: viewModel.getData)
                                ],
                              ),
                              const ProductAppBar(),

                            ],
                          ))),
          );
        });
  }
}
