import 'package:bingo/core/utils/is_dark.dart';
import 'package:bingo/core/utils/user_types.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';

class UserTypeWidget extends StatelessWidget {
  const UserTypeWidget({
    super.key,
    required this.type,
    required this.isActive,
    required this.description,
    required this.onTap,
  });

  final UserTypes type;
  final bool isActive;
  final String description;
  final void Function(UserTypes) onTap;

  @override
  Widget build(BuildContext context) {
    bool isDark = isDarkModeEnabled(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(type),
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.maxFinite,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: isActive
                  ? isDark
                      ? AppColors.white
                      : AppColors.bgDark
                  : null,
              border: Border.all(
                  color: isDark ? AppColors.bgLight : AppColors.bgDark)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('user_types.${type.name}'.tr(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: isDark
                            ? isActive
                                ? AppColors.bgDark
                                : AppColors.white
                            : isActive
                                ? AppColors.white
                                : AppColors.bgDark,
                      )),
              verticalSpace12,
              Text(
                  isActive
                      ? 'profile.complete_and_send_request'.tr()
                      : description,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: isDark
                            ? isActive
                                ? AppColors.bgDark
                                : AppColors.white
                            : isActive
                                ? AppColors.white
                                : AppColors.bgDark,
                      )),
            ],
          )),
    );
  }
}
