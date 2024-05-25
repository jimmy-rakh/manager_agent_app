import 'package:bingo/core/custom_widgets/default_image_container.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BrandsList extends ViewModelWidget<HomeViewModel> {
  const BrandsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return SizedBox(
      height: ScreenSize.height * .08,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: DefaultImageContainer(
                  height: ScreenSize.height * .08,
                  width: ScreenSize.width * .28,
                  fit: BoxFit.scaleDown,
                  backgroundColor: AppColors.white,
                  alignment: Alignment.center,
                  isActiveShadow: true,
                  imageUrl: viewModel.allBrands[index].imageUrl,
                  radius: 12,
                  children: [
                    Positioned(
                        bottom: 4,
                        left: 8,
                        child: Text(viewModel.allBrands[index].name!,
                        maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: AppColors.white,
                                )))
                  ],
                ));
          },
          separatorBuilder: (BuildContext context, int index) =>
              horizontalSpace16,
          itemCount: viewModel.allBrands.length),
    );
  }
}
