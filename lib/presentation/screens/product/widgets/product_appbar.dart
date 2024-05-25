import 'package:auto_route/auto_route.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/is_dark.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/product/product_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

class ProductAppBar extends ViewModelWidget<ProductViewModel> {
  const ProductAppBar({super.key});

  @override
  Widget build(BuildContext context, ProductViewModel viewModel) {
    return Stack(children: [
      Positioned(
        left: 24,
        top: 48,
        child: AutoLeadingButton(
          builder: (context, leadingType, action) => GestureDetector(
            onTap: () {
              if (action != null) action();
            },
            child: Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                child: Icon(
                  IconlyLight.arrow_left_2,
                  color: isDarkModeEnabled(context)
                      ? AppColors.textDark
                      : AppColors.textLight,
                )),
          ),
        ),
      ),
      Positioned(
        right: 24,
        top: 48,
        child: Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ]),
            child: PopupMenuButton<Text>(
              color: Theme.of(context).cardColor,
              surfaceTintColor:
                  isDarkModeEnabled(context) ? Colors.black : Colors.white,
              elevation: 15,
              iconSize: 20,
              itemBuilder: (context) {
                return [
                  // PopupMenuItem(
                  //   onTap: viewModel.showTemplate,
                  //   child: Row(
                  //     children: [
                  //       Opacity(
                  //           opacity: viewModel.isBusy ? .5 : 1,
                  //           child: Icon(
                  //             IconlyLight.paper_plus,
                  //             color: isDarkModeEnabled(context)
                  //                 ? AppColors.textDark
                  //                 : AppColors.textLight,
                  //           )),
                  //       horizontalSpace10,
                  //       Text(
                  //         'common.add_to_template'.tr(),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  PopupMenuItem(
                    onTap: viewModel.isBusy
                        ? null
                        : viewModel.product?.infav ?? false
                            ? viewModel.delFromFav
                            : viewModel.addToFav,
                    child: Row(
                      children: [
                        Opacity(
                            opacity: viewModel.isBusy ? .5 : 1,
                            child: Icon(
                              viewModel.product?.infav ?? false
                                  ? IconlyBold.heart
                                  : IconlyLight.heart,
                              color: isDarkModeEnabled(context)
                                  ? AppColors.textDark
                                  : AppColors.textLight,
                            )),
                        horizontalSpace10,
                        Text(
                          'common.add_like'.tr(),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: viewModel.onShare,
                    child: Row(
                      children: [
                        Icon(
                          IconlyLight.send,
                          color: isDarkModeEnabled(context)
                              ? AppColors.textDark
                              : AppColors.textLight,
                        ),
                        horizontalSpace10,
                        Text(
                          'common.share'.tr(),
                        ),
                      ],
                    ),
                  ),
                ];
              },
            )),
      ),
    ]);
  }
}
