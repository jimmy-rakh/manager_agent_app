import 'package:bingo/core/custom_widgets/app_bar.dart';
import 'package:bingo/core/custom_widgets/category_card.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/presentation/bottom_sheets/search_filter_sheet/search_filter_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BrandsFilter extends ViewModelWidget<SearchFilterViewModel> {
  const BrandsFilter({super.key});

  @override
  Widget build(BuildContext context, SearchFilterViewModel viewModel) {
    return Column(children: [
      CustomAppBar(
        title: 'search.brands'.tr(),
        textStyle: Theme.of(context).textTheme.titleMedium,
        bgColor: Theme.of(context).cardColor,
        onLeadingTap: () => viewModel.changePage(0),
      ),
      if (viewModel.searchBrandResponse != null)
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: viewModel.searchBrandResponse!.length,
            padding: const EdgeInsets.only(right: 24),
            itemBuilder: (context, index) {
              final brand = viewModel.searchBrandResponse![index];
              return CategoryCard(
                category: brand,
                // onTap: () => viewModel.chooseBrand(brand),
                isSelected: viewModel.choosedBrand?.name == brand.name,
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 1,
                color: AppColors.lightGrey,
              );
            },
          ),
        )
    ]);
  }
}
