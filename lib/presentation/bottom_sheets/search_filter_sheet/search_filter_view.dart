import 'package:bingo/core/custom_widgets/default_sheet_parent.dart';
import 'package:bingo/data/models/search/search_request.dart';
import 'package:bingo/presentation/bottom_sheets/search_filter_sheet/pages/brands_filter.dart';
import 'package:bingo/presentation/bottom_sheets/search_filter_sheet/pages/categories_filter.dart';
import 'package:bingo/presentation/bottom_sheets/search_filter_sheet/pages/filter_by.dart';
import 'package:bingo/presentation/bottom_sheets/search_filter_sheet/pages/main_filter_view.dart';
import 'package:bingo/presentation/bottom_sheets/search_filter_sheet/pages/subcategories_filter.dart';
import 'package:bingo/presentation/bottom_sheets/search_filter_sheet/search_filter_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SearchFilterView extends StatelessWidget {
  const SearchFilterView({super.key, required this.searchRequest});

  final SearchRequest searchRequest;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchFilterViewModel>.reactive(
        viewModelBuilder: () => SearchFilterViewModel(),
        onViewModelReady: (model) => model.onReady(searchRequest),
        builder: (context, viewModel, child) {
          return DefaultSheetParent(
              radius: 12,
              child: SizedBox(
                height: 500,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: viewModel.pageController,
                  scrollDirection: Axis.vertical,
                  children: const [
                    MainFilterView(),
                    CategoriesFilter(),
                    SubcategoriesFilter(),
                    BrandsFilter(),
                    FilterBy()
                  ],
                ),
              ));
        });
  }
}
