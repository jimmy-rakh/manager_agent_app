import 'package:flutter/material.dart';
import 'package:bingo/core/styles/colors.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    this.isActive = true,
    required this.value,
    required this.action,
    required this.isSelected,
    this.width,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
  });

  final bool isActive;
  final bool isSelected;
  final String value;
  final double? width;
  final EdgeInsets padding;
  final void Function(String) action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? () => action(value) : null,
      child: Opacity(
        opacity: isActive ? 1 : .5,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          width: width,
          padding: padding,
          decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8)),
          child: Text(value,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: isSelected ? AppColors.white : null)),
        ),
      ),
    );
  }
}
