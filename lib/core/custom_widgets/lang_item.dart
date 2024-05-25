import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';

class LangItem extends StatelessWidget {
  const LangItem(
      {super.key,
      required this.title,
      required this.locale,
      required this.icon,
      required this.onTap,
      this.isRow = false});

  final String title;
  final String locale;
  final String icon;
  final bool isRow;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    bool isActive = context.locale.languageCode == locale;
    return GestureDetector(
      onTap: () => onTap(locale),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive && isRow
              ? AppColors.primary
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: isRow
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SvgPicture.asset(
                      icon,
                      width: 54,
                    ),
                  ),
                  horizontalSpace12,
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: isActive ? AppColors.white : null),
                  )
                ],
              )
            : Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SvgPicture.asset(
                      icon,
                      width: 54,
                    ),
                  ),
                  verticalSpace12,
                  Text(
                    title,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
      ),
    );
  }
}
