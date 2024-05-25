import 'package:bingo/core/custom_widgets/app_bar.dart';
import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/custom_widgets/section_title.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/formatters.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/bottom_sheets/search_filter_sheet/search_filter_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MainFilterView extends ViewModelWidget<SearchFilterViewModel> {
  const MainFilterView({super.key});

  @override
  Widget build(BuildContext context, SearchFilterViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBar(
          title: 'search.filter'.tr(),
          textStyle: Theme.of(context).textTheme.titleMedium,
          centeredTitle: true,
          bgColor: Theme.of(context).cardColor,
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {},
                    child: Text(
                      'common.reset'.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
              ),
            )
          ],
        ),
        const Divider(height: 2, color: AppColors.grey),
        ListTile(
          onTap: () => viewModel.changePage(1),
          title: Text(
            'search.category'.tr(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          trailing: Text(
            viewModel.choosedCategory?.name ?? 'common.not_choosen'.tr(),
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: AppColors.grey),
          ),
        ),
        const Divider(height: 2, color: AppColors.lightGrey),
        Opacity(
          opacity: viewModel.choosedCategory == null ? .4 : 1,
          child: ListTile(
            onTap: () => viewModel.changePage(2),
            title: Text(
              'search.subcategory'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            trailing: Text(
              viewModel.choosedSubcategory?.name ?? 'common.not_choosen'.tr(),
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: AppColors.grey),
            ),
          ),
        ),
        const Divider(height: 2, color: AppColors.lightGrey),
        ListTile(
          onTap: () => viewModel.changePage(3),
          title: Text(
            'search.brand'.tr(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          trailing: Text(
            viewModel.choosedBrand?.name ?? 'common.not_choosen'.tr(),
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: AppColors.grey),
          ),
        ),
        const Divider(height: 2, color: AppColors.lightGrey),
        ListTile(
            onTap: () => viewModel.changePage(4),
            title: Text(
              'search.sort_by'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            trailing: SizedBox(
              width: 200,
              child: RichText(
                  text: TextSpan(
                children: [
                  for (String searchParam in viewModel.filterBySelectedValues)
                    TextSpan(text: " $searchParam,")
                ],
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: AppColors.grey),
              )),
            )),
        const Divider(height: 2, color: AppColors.lightGrey),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 12),
          child: SectionTitle(
            title: 'search.price_range'.tr(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Formatters.formattedMoney(
                  viewModel.searchRequest.priceFrom ?? 0)),
              Text(Formatters.formattedMoney(
                  viewModel.searchRequest.priceTo ?? 10000000))
            ],
          ),
        ),
        RangeSlider(
          min: 0,
          max: 10000000,
          divisions: 100000, //slide interval
          labels: RangeLabels(
              (viewModel.searchRequest.priceFrom ?? 0).toString(),
              (viewModel.searchRequest.priceTo ?? 10000000).toString()),
          values: RangeValues(
              (viewModel.searchRequest.priceFrom ?? 0).toDouble(),
              (viewModel.searchRequest.priceTo ?? 10000000).toDouble()),
          inactiveColor: AppColors.grey,
          activeColor: AppColors.primary,
          onChanged: viewModel.changePriceRange,
        ),
        const Spacer(),
        AppButton(
          text: 'common.apply'.tr(),
          width: double.maxFinite,
          onPressed: viewModel.onSubmit,
          textColor: AppColors.white,
          fillColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(12),
          padding: const EdgeInsets.symmetric(vertical: 16),
          margin: const EdgeInsets.symmetric(horizontal: 16),
        ),
        verticalSpace12
      ],
    );
  }
}
