import 'package:bingo/core/custom_widgets/app_bar.dart';
import 'package:bingo/core/custom_widgets/category_card.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/data/models/categories/catigories_dto.dart';
import 'package:bingo/presentation/bottom_sheets/search_filter_sheet/search_filter_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CategoriesFilter extends ViewModelWidget<SearchFilterViewModel> {
  const CategoriesFilter({super.key});

  @override
  Widget build(BuildContext context, SearchFilterViewModel viewModel) {
    return Column(children: [
      CustomAppBar(
        title: 'common.categories'.tr(),
        textStyle: Theme.of(context).textTheme.titleMedium,
        bgColor: Theme.of(context).cardColor,
        onLeadingTap: () => viewModel.changePage(0),
      ),
      Expanded(
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: viewModel.categoriesList.length,
          itemBuilder: (context, index) {
            final categoryQuery = viewModel.searchQueries[index];
            final category = CategoriesDto(
                name: categoryQuery.name,
                id: categoryQuery.id,
                imageUrl: categoryQuery.imageUrl);
            return CategoryCard(
              category: category,
              showImage: false,
              // onTap: () => viewModel.chooseCategory(category),
              isSelected: category.id == viewModel.choosedCategory?.id,
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
