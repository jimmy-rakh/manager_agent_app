import 'package:auto_route/auto_route.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/is_dark.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  const CustomAppBar(
      {super.key,
      this.actions,
      required this.title,
      this.textStyle,
      this.leadingWidth = 10,
      this.centeredTitle = false,
      this.bgColor,
      this.onLeadingTap,
      super.child = const SizedBox(),
      this.showLeading = true,
      super.preferredSize = const Size(0, 60)});

  final List<Widget>? actions;
  final String title;
  final double leadingWidth;
  final TextStyle? textStyle;
  final Color? bgColor;
  final bool centeredTitle;
  final void Function()? onLeadingTap;
  final bool showLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: centeredTitle,
        leadingWidth: showLeading
            ? router.canPop() ? 40 : 5: 5,
        leading: showLeading
            ? router.canPop()
                ? AutoLeadingButton(
                    builder: (context, leadingType, action) {
                      return GestureDetector(
                        onTap: () {
                          if (onLeadingTap != null) onLeadingTap!();
                          if (action != null && onLeadingTap == null) action();
                        },
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: isDarkModeEnabled(context)
                              ? AppColors.textDark
                              : AppColors.textLight,
                        ),
                      );
                    },
                  )
                : verticalSpace5
            : const SizedBox(),
        title: Text(
          title,
          style: textStyle ?? Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: bgColor,
        surfaceTintColor: Colors.transparent,
        actions: actions);
  }
}
