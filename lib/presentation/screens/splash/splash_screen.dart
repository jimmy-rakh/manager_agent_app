import 'package:auto_route/auto_route.dart';
import 'package:bingo/presentation/screens/splash/splash_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/styles/colors.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
        viewModelBuilder: () => SplashViewModel(),
        onViewModelReady: (model) => model.onReady(),
        builder: (context, viewModel, child) {
          return const Scaffold(
              body: Center(
                  child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: 'logo',
                child: Text(
                  'ClientApp',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 55),
                ),
              ),
              CupertinoActivityIndicator(),
            ],
          )));
        });
  }
}
