import 'package:bingo/core/custom_widgets/section_title.dart';
import 'package:bingo/core/custom_widgets/theme_item.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/account/pages/settings/settings_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ThemesSection extends ViewModelWidget<SettingsScreenViewModel> {
  const ThemesSection({super.key});

  @override
  Widget build(BuildContext context, SettingsScreenViewModel viewModel) {
    return Column(
      children: [
        SectionTitle(title: 'common.theme'.tr()),
        verticalSpace12,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ThemeItem(
              title: "common.system".tr(),
              mode: ThemeMode.system,
              activatedMode: viewModel.themeMode,
              onTap: viewModel.selectThemeMode,
              color: AppColors.bgLight,
              secondColor: AppColors.bgDark,
            ),
            ThemeItem(
              title: "common.dark".tr(),
              mode: ThemeMode.dark,
              activatedMode: viewModel.themeMode,
              onTap: viewModel.selectThemeMode,
              color: AppColors.bgDark,
            ),
            ThemeItem(
              title: "common.light".tr(),
              mode: ThemeMode.light,
              activatedMode: viewModel.themeMode,
              onTap: viewModel.selectThemeMode,
              color: AppColors.bgLight,
            ),
          ],
        )
      ],
    );
  }
}
