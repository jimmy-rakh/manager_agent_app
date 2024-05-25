import 'package:auto_route/auto_route.dart';
import 'package:bingo/core/custom_widgets/app_bar.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/data/models/orders/response/order_details_dto.dart';
import 'package:bingo/presentation/screens/scanner/scanner_viewmodel.dart';
import 'package:bingo/presentation/screens/scanner/widgets/body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key, required this.order});

  final OrderDetailsDto order;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => ScannerViewModel(),
      onViewModelReady: (viewModel) => viewModel.onReady(order),
      onDispose: (viewModel) => viewModel.onDipose(),
      builder: (context, viewModel, child) => Stack(
        children: [
          Scaffold(
            appBar: CustomAppBar(title: 'orders.accept_order'.tr()),
            body: const ScannerBody(),
          ),
          if (viewModel.isBusy)
            SizedBox(
              height: ScreenSize.height,
              width: ScreenSize.width,
              child: const ColoredBox(
                color: Colors.black45,
                child: Center(
                    child: SizedBox(
                        height: 54,
                        width: 54,
                        child: CircularProgressIndicator())),
              ),
            )
        ],
      ),
    );
  }
}
