import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/custom_widgets/app_text_field.dart';
import 'package:bingo/core/custom_widgets/default_sheet_parent.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/bottom_sheets/add_template/add_template_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddTemplateSheet extends StatelessWidget {
  const AddTemplateSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddTemplateViewModel(),
      builder: (
        context,
        viewModel,
        child,
      ) =>
          DefaultSheetParent(
        radius: 12,
        padding: 24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'common.add_template'.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            verticalSpace24,
            AppTextField(
              label: 'common.template_name'.tr(),
              fillColor: Colors.transparent,
              fieldController: viewModel.editingController,
            ),
            verticalSpace16,
            AppButton(
              text: 'common.create'.tr(),
              onPressed: viewModel.createTemplate,
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(vertical: 15),
              borderRadius: BorderRadius.circular(12),
              isLoading: viewModel.isBusy,
              fillColor: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
