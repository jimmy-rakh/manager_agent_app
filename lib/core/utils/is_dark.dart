import 'package:flutter/material.dart';

bool isDarkModeEnabled(BuildContext? context) {
  if (context == null) {
    return false;
  }

  return Theme.of(context).colorScheme.brightness == Brightness.dark;
}
