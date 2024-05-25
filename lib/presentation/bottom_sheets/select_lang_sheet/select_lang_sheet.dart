import 'package:bingo/core/assets/assets.dart';
import 'package:bingo/core/custom_widgets/default_sheet_parent.dart';
import 'package:bingo/core/custom_widgets/lang_item.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/bottom_sheets/select_lang_sheet/select_lang_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SelectLangSheet extends StatelessWidget {
  const SelectLangSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectLangViewModel>.reactive(
        viewModelBuilder: () => SelectLangViewModel(),
        builder: (context, viewModel, child) {
          return DefaultSheetParent(
            radius: 16,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            showDragContainer: true,
            padding: 24,
            child: Row(
              children: [
                Expanded(
                    child: LangItem(
                        title: 'Продолжить на Русском!',
                        locale: 'ru',
                        icon: AppAssets.ruFlag,
                        onTap: viewModel.setLocale)),
                horizontalSpace20,
                Expanded(
                    child: LangItem(
                        title: 'O`zbek tilida davom ettirish!',
                        locale: 'uz',
                        icon: AppAssets.uzFlag,
                        onTap: viewModel.setLocale)),
              ],
            ),
          );
        });
  }
}
