import 'package:auto_route/annotations.dart';
import 'package:bingo/core/custom_widgets/category_card.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/presentation/screens/categories/categories_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoriesViewModel>.reactive(
        viewModelBuilder: () => CategoriesViewModel(),
        onViewModelReady: (model) => model.onReady(),
        builder: (context, viewModel, child) {
          return viewModel.isBusy
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : ListView.separated(
                  padding: const EdgeInsets.only(bottom: 24),
                  shrinkWrap: true,
                  cacheExtent: 999,
                  itemBuilder: (context, index) {
                    final category = viewModel.categoriesList[index];
                    return CategoryCard(category: category);
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 1,
                      color: AppColors.grey,
                    );
                  },
                  itemCount: viewModel.categoriesList.length);
        });
  }
}
