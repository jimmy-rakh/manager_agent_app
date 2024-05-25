import 'package:flutter/material.dart';

class KeyboardEscape extends StatelessWidget {
  final Widget child;
  final void Function()? onUnFocus;

  const KeyboardEscape({Key? key, required this.child, this.onUnFocus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (onUnFocus != null) {
          onUnFocus!();
        }
      },
      child: child,
    );
  }
}
