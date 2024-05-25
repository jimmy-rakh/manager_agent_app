import 'package:auto_route/auto_route.dart';
import 'package:bingo/core/custom_widgets/badge_icon.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/presentation/screens/nav_bar/navbar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' hide TabsRouter;

class BottomBar extends ViewModelWidget<NavBarViewModel> {
  const BottomBar({
    Key? key,
    required this.tabsRouter,
  }) : super(key: key);

  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context, NavBarViewModel viewModel) {
    return Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                    color: AppColors.grey.withOpacity(.3), spreadRadius: 1),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
              child: BottomNavigationBar(
                backgroundColor: Theme.of(context).cardColor,
                currentIndex: tabsRouter.activeIndex,
                elevation: 0,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                enableFeedback: false,
                type: BottomNavigationBarType.fixed,
                items: List.generate(
                    viewModel.navBarItems.length,
                    (index) => BottomNavigationBarItem(
                        icon: BadgeIcon(
                            icon: Icon(
                              tabsRouter.activeIndex == index
                                  ? viewModel.navBarItems[index].activeIcon
                                  : viewModel.navBarItems[index].icon,
                              color: tabsRouter.activeIndex == index
                                  ? AppColors.primary
                                  : AppColors.grey,
                            ),
                            itemCount: index == 2 &&
                                    (viewModel.cartData?.cartproducts
                                            ?.isNotEmpty ??
                                        false)
                                ? viewModel.cartData!.cartproducts!.length
                                : null),
                        label: '')),
                onTap: tabsRouter.setActiveIndex,
              ),
            )));
  }
}

class NavBarItem {
  final IconData icon, activeIcon;
  NavBarItem({required this.icon, required this.activeIcon});
}
