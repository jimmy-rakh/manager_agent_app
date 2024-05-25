import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/presentation/screens/template/template_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

class TemplateAction extends ViewModelWidget<TemplateViewModel> {
  const TemplateAction({super.key});

  @override
  Widget build(BuildContext context, TemplateViewModel viewModel) {
    return (viewModel.template.templateproducts?.isEmpty ?? true)
        ? const SizedBox()
        : AppButton(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            fillColor: viewModel.selectedTemplateProductsId.isEmpty
                ? Theme.of(context).primaryColor
                : AppColors.red,
            borderRadius: BorderRadius.circular(8),
            text: viewModel.selectedTemplateProductsId.isEmpty ? '+' : '',
            icon: viewModel.selectedTemplateProductsId.isEmpty
                ? null
                : IconlyBold.delete,
            iconColor: Colors.white,
            showIconSpace: false,
            textStyle: Theme.of(context).textTheme.displaySmall!,
            onPressed: viewModel.selectedTemplateProductsId.isEmpty
                ? viewModel.chooseProducts
                : viewModel.deleteProducts,
          );
  }
}
