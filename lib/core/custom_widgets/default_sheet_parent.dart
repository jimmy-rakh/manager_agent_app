import 'package:bingo/core/utils/is_dark.dart';
import 'package:flutter/material.dart';
import 'package:bingo/core/styles/colors.dart';

class DefaultSheetParent extends StatelessWidget {
  const DefaultSheetParent(
      {Key? key,
      required this.child,
      this.padding = 0,
      this.isAcitveShadow = false,
      this.radius = 0,
      this.showDragContainer = false,
      this.backgroundColor})
      : super(key: key);

  final Widget child;
  final bool isAcitveShadow;
  final double padding;
  final double radius;
  final bool showDragContainer;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = isDarkModeEnabled(context);
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showDragContainer)
              Container(
                  height: 5,
                  width: 52,
                  decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.bgLight : AppColors.bgDark,
                      borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.only(bottom: 10, top: 10)),
            Container(
                padding: EdgeInsets.fromLTRB(padding, padding, padding, 32),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: backgroundColor ?? Theme.of(context).cardColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(radius)),
                    boxShadow: isAcitveShadow
                        ? [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 8,
                              offset: const Offset(3, 0),
                            ),
                          ]
                        : null),
                child: child),
          ],
        ),
      ),
    );
  }
}
