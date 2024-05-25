import 'package:bingo/app/router.dart';
import 'package:bingo/core/custom_widgets/circle_image.dart';
import 'package:bingo/core/enum/user_status.dart';
import 'package:bingo/core/network/constants.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/formatters.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/account/account_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

class UserSection extends ViewModelWidget<AccountViewModel> {
  const UserSection({super.key});

  @override
  Widget build(BuildContext context, AccountViewModel viewModel) {
    return viewModel.userData == null &&
            viewModel.userStatus == UserStatus.authorized
        ? const CupertinoActivityIndicator()
        : Column(children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                viewModel.userData == null ? const SizedBox() :   GestureDetector(
                  onTap: () => viewModel.toPage(const UserInfoRoute()),
                  child: CustomCircleImage(
                    size: const Size(70, 70),
                    imageUrl: viewModel.userData!.avatarUrl == null
                        ? null
                        : NetworkConstants.okansBaseUrl +
                            viewModel.userData!.avatarUrl!,
                  ),
                ),
                horizontalSpace12,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.userStatus == UserStatus.authorized
                          ? 'profile.welcome'.tr()
                          : 'profile.login_placeholder'.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.grey),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                        '${viewModel.userData?.firstName ?? ''} ${viewModel.userData?.surname ?? ''}',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const Spacer(),
                if (viewModel.userStatus == UserStatus.authorized)
                  GestureDetector(
                      onTap: viewModel.logOut,
                      child: const Icon(IconlyLight.logout)),
              ],
            ),
            verticalSpace24,
            // if (viewModel.userStatus == UserStatus.authorized) ...[
            //   Container(
            //     width: double.maxFinite,
            //     padding: const EdgeInsets.all(16),
            //     decoration: BoxDecoration(
            //         color: Theme.of(context).primaryColor,
            //         borderRadius: BorderRadius.circular(12)),
            //     child: Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text('common.balance'.tr(),
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .bodyLarge!
            //                   .copyWith(color: AppColors.white)),
            //           RichText(
            //               text: TextSpan(
            //                   text: Formatters.formattedMoney(
            //                       viewModel.balance?.balance ?? 0),
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .displaySmall!
            //                       .copyWith(color: AppColors.white),
            //                   children: [
            //                 TextSpan(
            //                   text: ' ${'common.sum'.tr()}',
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .titleMedium!
            //                       .copyWith(
            //                           color: AppColors.white.withOpacity(.8)),
            //                 )
            //               ])),
            //           verticalSpace10,
            //           Text('common.limit'.tr(),
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .bodyLarge!
            //                   .copyWith(color: AppColors.white)),
            //           RichText(
            //               text: TextSpan(
            //                   text: Formatters.formattedMoney(
            //                       viewModel.balance?.limit ?? 0),
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .displaySmall!
            //                       .copyWith(color: AppColors.white),
            //                   children: [
            //                 TextSpan(
            //                   text: ' ${'common.sum'.tr()}',
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .titleMedium!
            //                       .copyWith(
            //                           color: AppColors.white.withOpacity(.8)),
            //                 )
            //               ]))
            //         ]),
            //   ),
            // ],
            verticalSpace24,
            Divider(
              height: 2,
              color: AppColors.grey.withOpacity(.3),
            ),
          ]);
  }
}
