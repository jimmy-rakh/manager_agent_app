

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/router.dart';
import '../../../core/custom_widgets/app_button.dart';
import '../../../core/custom_widgets/app_text_field.dart';
import '../../../core/styles/colors.dart';
import 'client_by_inn_viewmodel.dart';

@RoutePage()
class ClientByInnScreen extends StatelessWidget {
  const ClientByInnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ClientByInnViewModel(),
        onViewModelReady: (viewModel) => viewModel.onReady(),
        builder: (context, viewModel, child) {
          return  Scaffold(
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ListView(
                      children: [
                        const Text(
                          'Client Inn',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 35),
                        ),


                        AppTextField(
                            fieldController: viewModel.usernameController,
                            label: 'Login'),

                       Spacer(),
                        AppButton(
                            width: 150,
                            text: 'Add order',
                            textStyle: Theme.of(context).textTheme.bodyLarge!,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            borderRadius: BorderRadius.circular(10),
                            fillColor: Theme.of(context).primaryColor,
                            isLoading: viewModel.isBusy,
                            onPressed: (){
                              router.push( NavBarRoute());
                            }),
                      ]),
                )
// jl;
          );
        });
  }
}
