import 'package:bingo/core/utils/is_dark.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';

class ThemeItem extends StatelessWidget {
  const ThemeItem(
      {super.key,
      required this.mode,
      required this.activatedMode,
      required this.onTap,
      required this.color,
      this.secondColor,
      required this.title});

  final Color color;
  final Color? secondColor;
  final ThemeMode mode;
  final ThemeMode activatedMode;
  final String title;
  final void Function(ThemeMode) onTap;

  @override
  Widget build(BuildContext context) {
    bool isDark = isDarkModeEnabled(context);
    return GestureDetector(
      onTap: () => onTap(mode),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: 80,
                child: Row(
                  children: [
                    Container(
                      width: secondColor != null ? 40 : 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: color,
                          border: Border.all(
                              color: isDark
                                  ? AppColors.bgLight
                                  : AppColors.bgDark)),
                    ),
                    if (secondColor != null)
                      Container(
                        width: secondColor != null ? 40 : 80,
                        height: 80,
                        decoration: BoxDecoration(
                            color: secondColor,
                            border: Border.all(
                                color: isDark
                                    ? AppColors.bgLight
                                    : AppColors.bgDark)),
                      ),
                  ],
                ),
              ),
              if (activatedMode == mode)
                const Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: Icon(
                      CupertinoIcons.checkmark_rectangle_fill,
                      color: AppColors.primary,
                      size: 32,
                    ))
            ],
          ),
          verticalSpace5,
          Text(title)
        ],
      ),
    );
  }
}
