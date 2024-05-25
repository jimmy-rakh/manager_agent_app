import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/data/models/orders/response/order_details_dto.dart';
import 'package:bingo/domain/services/order_service/order_service.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

class ScannerViewModel extends ReactiveViewModel {
  final OrderService _orderService = getIt();

  @override
  List<ListenableServiceMixin> get listenableServices => [_orderService];

  MobileScannerController scannerController = MobileScannerController();

  late OrderDetailsDto order;

  var animationArea = ScreenSize.height * 0.11;

  bool isActive = true;

  Timer? timer;

  void onReady(OrderDetailsDto order) {
    this.order = order;
    scannerController.stop();
    startAnimate();
  }

  startAnimate() {
    timer = Timer.periodic(const Duration(milliseconds: 700), (tick) {
      _lineAnimation(!isActive);
    });
  }

  _lineAnimation(isA) async {
    isActive = isA;
    rebuildUi();
  }

  void onDetect(BarcodeCapture barcode) async {
    if (isBusy) return;
    String data = barcode.barcodes.first.displayValue!;
    if (data.length != 36) return;
    try {
      setBusy(true);
      await _orderService.confirmOrder(order.id!, data);
      scannerController.dispose();
      Navigator.pop(router.navigatorKey.currentContext!, true);
    } catch (e) {
      print(e);
    }
    setBusy(false);
  }

  // void onRequestPermission() {}

  void torchToogle() {
    scannerController.toggleTorch();
  }

  void onScannerStarted(MobileScannerArguments? args) {
    print(args?.numberOfCameras);
  }

  void onError(MobileScannerErrorCode code) async {
    if (code == MobileScannerErrorCode.permissionDenied) {
      var status = await Permission.camera.status;
      if (status.isDenied || status.isPermanentlyDenied) {
        await AppSettings.openAppSettings();
      }
    }
  }

  void onDipose() {
    scannerController.stop();
    scannerController.dispose();
  }
}
