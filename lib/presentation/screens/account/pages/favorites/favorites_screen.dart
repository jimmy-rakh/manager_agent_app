import 'package:auto_route/annotations.dart';
import 'package:bingo/core/custom_widgets/app_bar.dart';
import 'package:bingo/presentation/screens/account/pages/favorites/widgets/favorites_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'favorites_viewmodel.dart';

@RoutePage()
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoritesViewModel>.reactive(
        viewModelBuilder: () => FavoritesViewModel(),
        onViewModelReady: (model) => model.onReady(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: CustomAppBar(title: 'menu.favorites'.tr()),
            body: const FavoritesBody(),
          );
        });
  }
}
