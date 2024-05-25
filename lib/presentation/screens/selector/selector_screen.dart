import 'package:auto_route/auto_route.dart';
import 'package:bingo/core/custom_widgets/custom_search_appbar.dart';
import 'package:bingo/presentation/screens/selector/selector_viewmodel.dart';
import 'package:bingo/presentation/screens/selector/widgets/body.dart';
import 'package:bingo/presentation/screens/selector/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class SelectorScreen extends StatelessWidget {
  const SelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SelectorViewModel(),
      onViewModelReady: (viewModel) => viewModel.onReady(),
      builder: (context, viewModel, child) => Scaffold(
          appBar: CustomSearchAppBar(
              isSearching: true,
              searchController: viewModel.textEditingController,
              onClear: (d) {},
              isBusy: false,
              onChanged: (value) => viewModel.search(name: value),
              isSearched: false,
              allowAction: true,
              showFilter: false,
              onSearchFieldTapped: () {}),
          body: const SelectorBody(),
          bottomNavigationBar: const SelectorNavBar()),
    );
  }
}
