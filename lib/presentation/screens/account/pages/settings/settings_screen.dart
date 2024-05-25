import 'package:auto_route/annotations.dart';
import 'package:bingo/core/custom_widgets/app_bar.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/account/pages/settings/settings_viewmodel.dart';
import 'package:bingo/presentation/screens/account/pages/settings/widgets/language_section.dart';
import 'package:bingo/presentation/screens/account/pages/settings/widgets/themes_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsScreenViewModel>.reactive(
        viewModelBuilder: () => SettingsScreenViewModel(),
        builder: (context, viewMOdel, child) {
          return Scaffold(
            appBar: CustomAppBar(title: 'menu.settings'.tr()),
            body: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ThemesSection(), verticalSpace12, LanguageSection()],
              ),
            ),
          );
        });
  }
}
