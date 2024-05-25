import 'package:auto_route/auto_route.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/custom_widgets/app_bar.dart';
import 'package:bingo/core/custom_widgets/menu_item.dart';
import 'package:bingo/core/enum/user_status.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/account/account_viewmodel.dart';
import 'package:bingo/presentation/screens/account/widgets/user_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

import '../../../core/custom_widgets/search_bar_widget.dart';

@RoutePage()
class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final isDarkMode = isDarkModeEnabled(context);
    return ViewModelBuilder<AccountViewModel>.reactive(
        viewModelBuilder: () => AccountViewModel(),
        onViewModelReady: (model) => model.onReady(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: CustomAppBar(
              title: 'profile.profile_title'.tr(),
              textStyle: Theme.of(context).textTheme.titleLarge,
              showLeading: false,
              // actions: [
              //   Padding(
              //     padding: const EdgeInsets.only(right: 16, top: 8),
              //     child: BadgeIcon(
              //       icon: Icon(
              //         IconlyLight.notification,
              //         color: isDarkMode ? AppColors.bgLight : AppColors.bgDark,
              //       ),
              //       itemCount: 1,
              //     ),
              //   ),
              // ],
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const UserSection(),
                verticalSpace35,
                CustomMenuItem(
                  title: 'menu.my_addresses'.tr(),
                  icon: IconlyLight.location,
                  isActive: viewModel.userStatus == UserStatus.authorized,
                  onTap: () => viewModel.toPage(const AddressRoute()),
                ),
                CustomMenuItem(
                  title: 'menu.favorites'.tr(),
                  icon: IconlyLight.paper,
                  onTap: () => viewModel.toPage(const FavoritesRoute()),
                ),
                // CustomMenuItem(
                //     title: 'menu.my_reviews'.tr(),
                //     icon: IconlyLight.chat,
                //     isActive: viewModel.userStatus == UserStatus.haveToLogIn,
                //     onTap: () {}),
                CustomMenuItem(
                  title: 'menu.settings'.tr(),
                  icon: IconlyLight.setting,
                  onTap: () => viewModel.toPage(const SettingsRoute()),
                ),
              ],
            ),
          );
        });
  }
}
