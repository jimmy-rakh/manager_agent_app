import 'package:bingo/core/custom_widgets/app_bar.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/presentation/bottom_sheets/search_filter_sheet/search_filter_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FilterBy extends ViewModelWidget<SearchFilterViewModel> {
  const FilterBy({super.key});

  @override
  Widget build(BuildContext context, SearchFilterViewModel viewModel) {
    List<FilterByValues> filteByList = [
      FilterByValues(key: 'created_at', value: 'search.old'.tr()),
      FilterByValues(key: '-created_at', value: 'search.new'.tr()),
      FilterByValues(key: 'rating', value: 'search.low'.tr()),
      FilterByValues(key: '-rating', value: 'search.hight'.tr()),
      FilterByValues(key: 'views', value: 'search.low_view'.tr()),
      FilterByValues(key: '-views', value: 'search.hight_view'.tr()),
      FilterByValues(key: 'sales', value: 'search.low_sales'.tr()),
      FilterByValues(key: '-sales', value: 'search.top_sales'.tr())
    ];
    return Column(children: [
      CustomAppBar(
        title: 'search.sort_by'.tr(),
        textStyle: Theme.of(context).textTheme.titleMedium,
        bgColor: Theme.of(context).cardColor,
        onLeadingTap: () => viewModel.changePage(0),
      ),
      Expanded(
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: filteByList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => viewModel.chooseFilterBy(filteByList[index]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    Text(filteByList[index].value),
                    const Spacer(),
                    if (viewModel.searchRequest.orderBy!
                        .contains(filteByList[index].key))
                      const Icon(Icons.check)
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(height: 1, color: AppColors.grey);
          },
        ),
      )
    ]);
  }
}

class FilterByValues {
  String key;
  String value;

  FilterByValues({required this.key, required this.value});
}
