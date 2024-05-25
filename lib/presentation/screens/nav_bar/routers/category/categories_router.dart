import 'package:auto_route/auto_route.dart';
import 'package:bingo/core/custom_widgets/custom_search_appbar.dart';
import 'package:bingo/presentation/screens/nav_bar/routers/category/categories_router_viewmodel.dart';
import 'package:bingo/presentation/screens/nav_bar/routers/category/widgets/search_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class CategoriesRouterScreen extends StatelessWidget {
  const CategoriesRouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoriesRouterViewModel>.reactive(
        viewModelBuilder: () => CategoriesRouterViewModel(),
        onViewModelReady: (viewModel) => viewModel.onReady(),
        builder: (context, viewModel, child) => Scaffold(
            appBar: CustomSearchAppBar(
                isBusy: viewModel.isBusy,
                isSearched: viewModel.isSearched,
                isSearching: viewModel.isSearching,
                onClear: viewModel.onClear,
                onChanged: (v) => viewModel.onSearch(v, onValueSearch: true),
                showFilter: true,
                onSearchFieldTapped: viewModel.onSearchFieldTapped,
                onSubmit: viewModel.onSearch,
                onFilterTapped: viewModel.onFilterTapped,
                focusNode: viewModel.searchFocusNode,
                searchController: viewModel.searchFieldController),
            body: Stack(
              children: [
                const AutoRouter(),
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: viewModel.isSearching ? const SearchView() : null),
              ],
            )));
  }
}
