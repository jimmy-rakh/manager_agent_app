import 'package:bingo/core/custom_widgets/default_change_card.dart';
import 'package:bingo/presentation/screens/checkout/checkout_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

class DeliverySection extends ViewModelWidget<CheckoutViewModel> {
  const DeliverySection({super.key});

  @override
  Widget build(BuildContext context, CheckoutViewModel viewModel) {
    return DefaultChangeCard(
      title: viewModel.selectedAddress == null
          ? viewModel.pickUp
              ? viewModel.selectedPoint?.title ?? 'checkout.pickup'.tr()
              : 'checkout.choose_delivery_method'.tr()
          : viewModel.selectedAddress!.title!,
      description: viewModel.selectedAddress == null
          ? viewModel.pickUp
              ? '${'checkout.working_time'.tr()}\n9:30 - 22:00'
              : 'checkout.delivery_placeholder'.tr()
          : null,
      onTap: viewModel.showAddressChooser,
      icon: viewModel.pickUp ? IconlyLight.buy : IconlyLight.location,
    );
  }
}
