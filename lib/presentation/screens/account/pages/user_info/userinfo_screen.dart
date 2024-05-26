import 'package:auto_route/annotations.dart';
import 'package:bingo/core/custom_widgets/app_bar.dart';
import 'package:bingo/core/custom_widgets/app_text_field.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/datetime_utils.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/core/utils/text_masks.dart';
import 'package:bingo/core/utils/user_types.dart';
import 'package:bingo/presentation/screens/account/pages/user_info/userinfo_viewmodel.dart';
import 'package:bingo/presentation/screens/account/pages/user_info/widget/user_image_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserInfoViewModel>.reactive(
        viewModelBuilder: () => UserInfoViewModel(),
        onViewModelReady: (model) => model.onReady(),
        builder: (context, viewModel, child) {
          return Scaffold(
              appBar: CustomAppBar(title: 'profile.profile_title'.tr()),
              body: viewModel.isBusy
                  ? const Center(child: CupertinoActivityIndicator())
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 110),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        // const UserImageSection(),
                        // verticalSpace16,
                        if (viewModel.userRequests.isNotEmpty)
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.5, color: AppColors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'profile.application'.tr(args: [
                                      viewModel.userRequests.last.id.toString()
                                    ]),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  verticalSpace10,
                                  Text('profile.new_type'.tr(args: [
                                    'user_types.${viewModel.userRequests.last.type!}'
                                        .tr()
                                  ])),
                                  verticalSpace10,
                                  Text(
                                      '${'common.status'.tr()}: ${'statuses.${viewModel.userRequests.last.status}'.tr()}'),
                                  verticalSpace10,
                                  Text(
                                      '${'common.date'.tr()}: ${DateTime.parse(viewModel.userRequests.last.createdAt!).dateTimeFormatter()}')
                                ]),
                          ),
                        verticalSpace12,
                        AppTextField(
                          readOnly: true,
                          label: 'profile.your_name'.tr(),
                          fieldController: viewModel.nameController,
                        ),
                        verticalSpace12,
                        if (viewModel.user.type != UserTypes.USER_RETAIL.name ||
                            viewModel.user.surname != null) ...[
                          AppTextField(
                            readOnly: true,
                            label: 'profile.your_surename'.tr(),
                            fieldController: viewModel.surnameController,
                          ),
                          verticalSpace12
                        ],
                        if (viewModel.user.type != UserTypes.USER_RETAIL.name ||
                            viewModel.user.lastname != null) ...[
                          AppTextField(
                            readOnly: true,
                            label: 'profile.your_last_name'.tr(),
                            fieldController: viewModel.lastnameController,
                          ),
                          verticalSpace12
                        ],
                        AppTextField(
                          label: 'profile.your_phone'.tr(),
                          readOnly: true,
                          textInputFormatter: [phoneMask],
                          fieldController: viewModel.phoneController,
                        ),
                        verticalSpace12,
                        if (viewModel.user.type ==
                                UserTypes.USER_WHOLESALE_ENTITY.name ||
                            viewModel.user.type ==
                                UserTypes.USER_WHOLESALE_INDIVIDUAL.name) ...[
                          verticalSpace12,
                          AppTextField(
                            label: 'profile.company_adress'.tr(),
                            fieldController: viewModel.addressController,
                            suffix: const Icon(
                              IconlyLight.location,
                              color: AppColors.grey,
                              size: 24,
                            ),
                          )
                        ],
                        if (viewModel.user.type ==
                                UserTypes.USER_WHOLESALE_ENTITY.name ||
                            viewModel.user.type ==
                                UserTypes.USER_WHOLESALE_INDIVIDUAL.name) ...[
                          verticalSpace12,
                          AppTextField(
                            label: 'profile.company_business_type'.tr(),
                            fieldController: viewModel.activityContoller,
                          )
                        ],
                        if (viewModel.user.type ==
                                UserTypes.USER_WHOLESALE_ENTITY.name ||
                            viewModel.user.type ==
                                UserTypes.USER_WHOLESALE_INDIVIDUAL.name) ...[
                          verticalSpace12,
                          AppTextField(
                            label: 'profile.job_title'.tr(),
                            fieldController: viewModel.positionController,
                          )
                        ],
                      ],
                    ));
        });
  }
}
