import 'package:bingo/core/custom_widgets/circle_image.dart';
import 'package:bingo/core/network/constants.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/account/pages/user_info/userinfo_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UserImageSection extends ViewModelWidget<UserInfoViewModel> {
  const UserImageSection({super.key});

  @override
  Widget build(BuildContext context, UserInfoViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCircleImage(
          size: const Size(100, 100),
          iconSize: 24,
          imageUrl: viewModel.user.avatarUrl == null
              ? null
              : NetworkConstants.okansBaseUrl + viewModel.user.avatarUrl!,
        ),
        horizontalSpace16,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace10,
            Text("${'profile.kind_of_activity'.tr()}: ",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColors.grey,
                    )),
            Text('user_types.${viewModel.user.type}'.tr()),
          ],
        )
      ],
    );
  }
}
