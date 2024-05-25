import 'package:bingo/core/assets/assets.dart';
import 'package:bingo/core/custom_widgets/lang_item.dart';
import 'package:bingo/core/custom_widgets/section_title.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/account/pages/settings/settings_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LanguageSection extends ViewModelWidget<SettingsScreenViewModel> {
  const LanguageSection({super.key});

  @override
  Widget build(BuildContext context, SettingsScreenViewModel viewModel) {
    return Column(children: [
       SectionTitle(title: 'common.language'.tr()),
      verticalSpace12,
      Row(
        children: [
          Expanded(
              child: LangItem(
                  title: 'Русский',
                  locale: 'ru',
                  isRow: true,
                  icon: AppAssets.ruFlag,
                  onTap: viewModel.setLocale)),
          horizontalSpace20,
          Expanded(
              child: LangItem(
                  title: "O'zbekcha",
                  locale: 'uz',
                  isRow: true,
                  icon: AppAssets.uzFlag,
                  onTap: viewModel.setLocale)),
        ],
      ),
    ]);
  }
}
