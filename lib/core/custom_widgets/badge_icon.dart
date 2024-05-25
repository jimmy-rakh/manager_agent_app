import 'package:bingo/core/styles/colors.dart';
import 'package:flutter/material.dart';

class BadgeIcon extends StatelessWidget {
  const BadgeIcon({super.key, required this.icon, this.itemCount});

  final Icon icon;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        icon,
        if (itemCount != null && itemCount != 0)
          Positioned(
            top: -8,
            right: -5,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.red),
              child: Text(
                '$itemCount',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppColors.white, fontWeight: FontWeight.w700),
              ),
            ),
          )
      ],
    );
  }
}
