import 'package:flutter/material.dart';

class CustomMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function() onTap;
  final bool isShowNextIcon;
  final bool isActive;

  const CustomMenuItem(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onTap,
      this.isShowNextIcon = true,
      this.isActive = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isActive ? 1 : .4,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: isActive ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(icon),
              const SizedBox(width: 12),
              Expanded(child: Text(title)),
              if (isShowNextIcon) const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
