import 'package:auto_route/auto_route.dart';
import 'package:bingo/core/assets/assets.dart';
import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/custom_widgets/app_text_field.dart';
import 'package:bingo/core/custom_widgets/keyboard_escape.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/login/login_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => LoginViewModel(),
        onViewModelReady: (viewModel) => viewModel.onReady(),
        builder: (context, viewModel, child) {
          return KeyboardEscape(
            child: Scaffold(
                body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Stack(
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Agent manager',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 35),
                        ),
                        // verticalSpace5,
                        // Text(
                        //   'profile.login'.tr(),
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodyMedium!
                        //       .copyWith(color: AppColors.grey),
                        // ),
                        verticalSpace30,
                        AppTextField(
                            fieldController: viewModel.usernameController,
                            label: 'Login'),
                        verticalSpace16,
                        AppTextField(
                          fieldController: viewModel.passwordController,
                          label: 'profile.password'.tr(),
                          obscureText: viewModel.invisiblePassword,
                          suffix: IconButton(
                              onPressed: viewModel.togglePasswordVisibility,
                              splashColor: Colors.transparent,
                              icon: Icon(
                                viewModel.invisiblePassword
                                    ? IconlyLight.show
                                    : IconlyLight.hide,
                                size: 24,
                                color: AppColors.grey,
                              )),
                        ),
                        // verticalSpace10,
                        // Row(
                        //   children: [
                        //     MSHCheckbox(
                        //       size: 18,
                        //       value: viewModel.remember,
                        //       isDisabled: false,
                        //       duration: const Duration(milliseconds: 300),
                        //       colorConfig:
                        //           MSHColorConfig.fromCheckedUncheckedDisabled(
                        //         checkedColor: Theme.of(context).primaryColor,
                        //         uncheckedColor: AppColors.grey,
                        //       ),
                        //       style: MSHCheckboxStyle.fillScaleColor,
                        //       onChanged: viewModel.rememberToggle,
                        //     ),
                        //     horizontalSpace12,
                        //     GestureDetector(
                        //         onTap: () => viewModel.rememberToggle(null),
                        //         child: const Text('Запомнить меня')),
                        //     const Spacer(),
                        //     AppButton(
                        //         text: 'Забыли пароль?',
                        //         textColor: Theme.of(context).primaryColor,
                        //         onPressed: () {}),
                        //   ],
                        // ),
                        verticalSpace30,
                        AppButton(
                            width: 150,
                            text: 'profile.login'.tr(),
                            textStyle: Theme.of(context).textTheme.bodyLarge!,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            borderRadius: BorderRadius.circular(10),
                            fillColor: Theme.of(context).primaryColor,
                            isLoading: viewModel.isBusy,
                            onPressed: viewModel.onLogin),
                      ]),
                  Positioned(
                      top: 52,
                      right: 0,
                      child: AppButton(
                          icon: context.locale.languageCode == 'uz'
                              ? AppAssets.uzFlag
                              : AppAssets.ruFlag,
                          text:
                              context.locale.languageCode == 'uz' ? 'Uz' : 'Ру',
                          borderColor: AppColors.grey,
                          padding: const EdgeInsets.all(8),
                          textStyle: Theme.of(context).textTheme.bodyMedium!,
                          borderRadius: BorderRadius.circular(10),
                          onPressed: viewModel.onChooseLang))
                ],
              ),
            )),
          );
        });
  }
}
