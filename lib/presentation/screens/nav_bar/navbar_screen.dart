import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/presentation/screens/nav_bar/navbar_viewmodel.dart';
import 'package:bingo/presentation/screens/nav_bar/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' hide TabsRouter;

@RoutePage()
class NavBarScreen extends StatelessWidget {
  const NavBarScreen({Key? key, this.initialRoute}) : super(key: key);

  final String? initialRoute;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavBarViewModel>.nonReactive(
        viewModelBuilder: () => NavBarViewModel(),
        onViewModelReady: (model) => model.onReady(),
        builder: (context, viewModel, child) {
          return AutoTabsRouter.builder(
              routes: const [
                // HomeRouterRoute(),
                CategoriesRouterRoute(),
                CartRouterRoute(),
                OrdersRouterRoute(),
                // AccountRouterRoute()
              ],
              builder: (context, children, tabsRouter) => Scaffold(
                appBar: AppBar(
                  leading: const BackButton(),
                  title: const Text('client'),),
                    resizeToAvoidBottomInset: true,
                    extendBody: true,
                    body: IndexedStack(
                      index: tabsRouter.activeIndex,
                      children: children,
                    ),
                    bottomNavigationBar: BottomBar(tabsRouter: tabsRouter),
                  ));
        });
  }
}
