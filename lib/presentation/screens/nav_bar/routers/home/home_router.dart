import 'package:auto_route/auto_route.dart';
import 'package:bingo/presentation/screens/nav_bar/routers/home/home_router_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class HomeRouterScreen extends StatelessWidget {
  const HomeRouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeRouterViewModel>.reactive(
        viewModelBuilder: () => HomeRouterViewModel(),
        onViewModelReady: (viewModel) => viewModel.onReady(),
        builder: (context, viewModel, child) => const Scaffold(
              body: AutoRouter(),
            ));
  }
}
