import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/custom_widgets/title_section.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/home/home_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stacked/stacked.dart';

class TemplatesSection extends ViewModelWidget<HomeViewModel> {
  const TemplatesSection({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Skeletonizer(
      enabled: viewModel.isBusyTemplates,
      child: Column(
        children: [
          TitleSectionWidget(
                          name: 'common.sample'.tr(), onTap: () {}),
          viewModel.isBusyTemplates
              ? SizedBox(
                  height: ScreenSize.height * .14,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemBuilder: (_, index) {
                      return Row(
                        children: [
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ecample template',
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const Spacer(),
                                Text('common.products_count'.tr(args: ['3']),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(color: AppColors.grey))
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return horizontalSpace12;
                    },
                    itemCount: 4,
                  ),
                )
              : viewModel.templates.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Center(
                          child: Text(
                        'errors.NOT_FOUND_TEMPLATE_DESCRIPTION'.tr(),
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      )),
                    )
                  : SizedBox(
                      height: ScreenSize.height * .14,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          itemBuilder: (_, index) {
                            final template = viewModel.templates[index];
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () => viewModel.toTamplate(template),
                                  child: Container(
                                    width: 120,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          template.name!,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        const Spacer(),
                                        Text(
                                            'common.products_count'.tr(args: [
                                              (template.productsCount ?? 0)
                                                  .toString()
                                            ]),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge
                                                ?.copyWith(
                                                    color: AppColors.grey))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return horizontalSpace12;
                          },
                          itemCount: viewModel.templates.length),
                    ),
          verticalSpace24,
          AppButton(
            text: 'common.add_template'.tr(),
            textStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w800),
            padding: const EdgeInsets.symmetric(vertical: 12),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            icon: IconlyBold.paper_plus,
            iconColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
            width: double.maxFinite,
            fillColor: AppColors.primary,
            onPressed: viewModel.onCreateTemplate,
          ),
        ],
      ),
    );
  }
}
