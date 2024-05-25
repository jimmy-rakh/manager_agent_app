import 'package:flutter/material.dart';

class RowText extends StatelessWidget {
  const RowText(
      {super.key,
      required this.valueKey,
      required this.value,
      required this.color,
      this.isBold = false});

  final String valueKey;
  final String value;
  final Color color;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          valueKey,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: color, fontWeight: isBold ? FontWeight.bold : null),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: color, fontWeight: isBold ? FontWeight.bold : null),
        )
      ],
    );
  }
}
