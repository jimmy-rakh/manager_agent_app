import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(
      {super.key, required this.title, this.style, this.trailing});

  final String title;
  final Widget? trailing;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: style ??
              Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        trailing ?? const SizedBox()
      ],
    );
  }
}
