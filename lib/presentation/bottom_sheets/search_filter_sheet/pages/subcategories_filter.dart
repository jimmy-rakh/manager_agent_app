import 'package:bingo/core/custom_widgets/app_bar.dart';
import 'package:bingo/core/custom_widgets/category_card.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/presentation/bottom_sheets/search_filter_sheet/search_filter_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SubcategoriesFilter extends ViewModelWidget<SearchFilterViewModel> {
  const SubcategoriesFilter({super.key});

  @override
  Widget build(BuildContext context, SearchFilterViewModel viewModel) {
    return Column(children: [
      CustomAppBar(
        title: 'common.subcategories'.tr(),
        textStyle: Theme.of(context).textTheme.titleMedium,
        bgColor: Theme.of(context).cardColor,
        onLeadingTap: () => viewModel.changePage(0),
      ),
      Expanded(
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: viewModel.subcategoriesList.length,
          itemBuilder: (context, index) {
            final query = viewModel.subcategoriesList;
            final subcategory = query[index];
            return CategoryCard(
              category: subcategory,
              showImage: false,
              // onTap: () => viewModel.chooseSubcategory(subcategory),
              isSelected: viewModel.choosedSubcategory == subcategory,
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(height: 1, color: AppColors.lightGrey);
          },
        ),
      )
    ]);
  }
}
