import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/formatters.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/template/template_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TemplateNavBar extends ViewModelWidget<TemplateViewModel> {
  const TemplateNavBar({super.key});

  @override
  Widget build(BuildContext context, TemplateViewModel viewModel) {
    return (viewModel.template.templateproducts?.isEmpty ?? true)
        ? const SizedBox()
        : SizedBox(
            height: 100,
            width: ScreenSize.width,
            child: ColoredBox(
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${'cart.to_pay'.tr()}:',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        RichText(
                            text: TextSpan(
                                text: Formatters.formattedMoney(
                                    viewModel.template.price),
                                style: Theme.of(context).textTheme.titleMedium,
                                children: [
                              TextSpan(
                                  text: ' ${'common.sum'.tr()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.grey))
                            ]))
                      ],
                    ),
                    horizontalSpace25,
                    Expanded(
                      child: AppButton(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        fillColor: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        text: 'cart.checkout'.tr(),
                        onPressed: viewModel.toCheckout,
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
