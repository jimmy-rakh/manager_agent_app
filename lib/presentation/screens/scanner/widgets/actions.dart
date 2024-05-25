import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/presentation/screens/scanner/scanner_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ScannerActions extends ViewModelWidget<ScannerViewModel> {
  const ScannerActions({super.key});

  @override
  Widget build(BuildContext context, ScannerViewModel viewModel) {
    return Positioned(
        bottom: 30,
        left: 0,
        right: 0,
        child: AppButton(
            height: 46,
            width: 46,
            borderRadius: BorderRadius.circular(12),
            text: 'Flash',
            onPressed: viewModel.torchToogle));
  }
}
