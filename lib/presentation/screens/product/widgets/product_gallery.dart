import 'package:bingo/core/assets/assets.dart';
import 'package:bingo/core/network/constants.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/presentation/screens/product/product_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

class ProductGallery extends ViewModelWidget<ProductViewModel> {
  const ProductGallery({super.key});

  @override
  Widget build(BuildContext context, ProductViewModel viewModel) {
    return Stack(
      children: [
        viewModel.product?.gallery?.isEmpty ?? true
            ? Container(
                color: AppColors.white,
                height: ScreenSize.height * .3,
                width: ScreenSize.width,
                child: viewModel.incomingProduct!.imageUrl == null
                    ? Image.asset(AppAssets.noPhoto)
                    : CachedNetworkImage(
                        errorWidget: (context, url, error) =>
                            const Icon(IconlyBold.close_square),
                        imageUrl: NetworkConstants.okansBaseUrl +
                            (viewModel.product?.imageUrl ??
                                viewModel.incomingProduct!.imageUrl!)),
              )
            : CarouselSlider.builder(
                itemCount: viewModel.product?.gallery?.length ?? 1,
                itemBuilder: (context, index, page) {
                  final image = viewModel.product?.gallery?[index];
                  return Container(
                    color: AppColors.white,
                    width: ScreenSize.width,
                    child: CachedNetworkImage(
                        errorWidget: (context, url, error) =>
                            const Icon(IconlyBold.close_square),
                        imageUrl: NetworkConstants.okansBaseUrl +
                            (image?.imageUrl ??
                                viewModel.incomingProduct!.imageUrl!)),
                  );
                },
                options: CarouselOptions(
                  height: ScreenSize.height * .3,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: viewModel.product != null &&
                      viewModel.product?.gallery?.length != 1,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(milliseconds: 1200),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0,
                  scrollDirection: Axis.horizontal,
                )),
        if (viewModel.product != null)
          Positioned(
              right: 24,
              bottom: 16,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(
                        viewModel.product?.quantity == null ? 0 : 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(4)),
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 6),
                child: Text(
                  '${'product.remain'.tr()}: ${viewModel.product?.quantity ?? ''}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ))
      ],
    );
  }
}
