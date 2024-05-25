import 'package:bingo/core/utils/mediaquery.dart';
import 'package:flutter/material.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';

class DefaultChangeCard extends StatelessWidget {
  const DefaultChangeCard(
      {super.key,
      required this.title,
      this.description,
      this.changeText,
      this.onTap,
      required this.icon,
      this.backgroundColor,
      this.isSelected});

  final String title;
  final String? description;
  final String? changeText;
  final Color? backgroundColor;
  final bool? isSelected;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                        color: isSelected ?? false
                            ? Theme.of(context).primaryColor
                            : backgroundColor ?? Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: Icon(
                      icon,
                      color: isSelected ?? false ? Colors.white : null,
                    ),
                  ),
                  horizontalSpace8,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace5,
                      SizedBox(
                        width: ScreenSize.width * .6,
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (description != null) ...[
                        Text(description!,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: AppColors.grey))
                      ]
                    ],
                  )
                ]),
            if (changeText != null)
              Text(
                changeText!,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      decoration: TextDecoration.underline,
                    ),
              )
          ],
        ),
      ),
    );
  }
}
