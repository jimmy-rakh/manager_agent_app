import 'package:bingo/core/custom_widgets/default_image_container.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/data/models/products/response/posters_model.dart';
import 'package:bingo/presentation/screens/home/home_viewmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stacked/stacked.dart';

class PostersSection extends ViewModelWidget<HomeViewModel> {
  const PostersSection({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return  Skeletonizer(
      enabled: viewModel.postersList.isEmpty,
      child: viewModel.postersList.isEmpty ? const SizedBox() : CarouselSlider.builder(
        itemCount:
            viewModel.postersList.isEmpty ? 0 : viewModel.postersList.length,
        itemBuilder: (context, index, page) {
          final poster = viewModel.postersList.isEmpty
              ? PostersDto(
                  id: 0,
                  productId: 0,
                  imageUrl:
                      'https://media.wired.com/photos/6500ad57fe61eb702d721b58/master/w_2240,c_limit/Apple-iPhone-15-Pro-Hero-Gear.jpg')
              : viewModel.postersList[index];
          return GestureDetector(
            onTap: () => viewModel.onProductTapped(productId: poster.productId),
            child: DefaultImageContainer(
              width: ScreenSize.width,
              margin: const EdgeInsets.fromLTRB(24, 12, 24, 12),
              radius: 12,
              imageUrl: poster.imageUrl,
            ),
          );
        },
        options: CarouselOptions(
          autoPlay: viewModel.postersList.isNotEmpty &&
              viewModel.postersList.length != 1,
          enlargeCenterPage: true,
          viewportFraction: 1,
          aspectRatio: 2.0,
          initialPage: 2,
        ),
      ),
    );
  }
}
