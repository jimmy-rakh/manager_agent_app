import 'package:bingo/presentation/screens/search/search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SearchViewModel(),
      builder: (context, viewModel, child) => const Scaffold(
        body: Column(),
      ),
    );
  }
}
