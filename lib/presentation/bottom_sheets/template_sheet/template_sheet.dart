import 'package:bingo/core/custom_widgets/default_sheet_parent.dart';
import 'package:bingo/core/custom_widgets/section_title.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/bottom_sheets/template_sheet/template_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TemplateSheet extends StatelessWidget {
  const TemplateSheet({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => TemplateSheetViewModel(),
        onViewModelReady: (viewModel) => viewModel.onReady(id),
        builder: (context, viewModel, child) {
          return DefaultSheetParent(
            padding: 16,
            radius: 12,
            showDragContainer: true,
            child: viewModel.isBusy
                ? const CupertinoActivityIndicator()
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                       SectionTitle(title: 'common.choose_template'.tr()),
                      verticalSpace16,
                      SizedBox(
                        height: ScreenSize.height * .5,
                        child: GridView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: viewModel.templates.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    mainAxisExtent: 100),
                            itemBuilder: (context, index) {
                              final template = viewModel.templates[index];
                              return GestureDetector(
                                onTap: () => viewModel.onSelect(template.id!),
                                child: Container(
                                  width: 120,
                                  height: 80,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        template.name!,
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
          );
        });
  }
}
