import 'package:auto_route/auto_route.dart';
import 'package:bingo/core/custom_widgets/app_bar.dart';
import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/data/models/template/response.dart';
import 'package:bingo/presentation/screens/template/template_viewmodel.dart';
import 'package:bingo/presentation/screens/template/widgets/action.dart';
import 'package:bingo/presentation/screens/template/widgets/body.dart';
import 'package:bingo/presentation/screens/template/widgets/nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class TemplateScreen extends StatelessWidget {
  const TemplateScreen({super.key, required this.template});

  final TemplateResponse template;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => TemplateViewModel(),
      onViewModelReady: (viewModel) => viewModel.onReady(template),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: template.name!,
            actions: [
              AppButton(
                text: 'common.delete'.tr(),
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.w700,
                    ),
                onPressed: viewModel.deleteTemplate,
              ),
              horizontalSpace20,
            ],
          ),
          body: const TemplateBody(),
          bottomNavigationBar: const TemplateNavBar(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButton: const TemplateAction(),
        );
      },
    );
  }
}
