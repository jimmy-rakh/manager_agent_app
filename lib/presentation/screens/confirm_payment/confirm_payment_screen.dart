import 'package:auto_route/auto_route.dart';
import 'package:bingo/core/custom_widgets/app_bar.dart';
import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/custom_widgets/default_change_card.dart';
import 'package:bingo/core/custom_widgets/section_title.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/formatters.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/confirm_payment/confirm_payment_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class ConfirmPaymentScreen extends StatelessWidget {
  const ConfirmPaymentScreen({super.key, required this.orderId});

  final int orderId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ConfirmPaymentViewModel(),
        onViewModelReady: (viewModel) => viewModel.onReady(orderId),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: CustomAppBar(title: 'orders.order_pay'.tr(args: [orderId.toString()])),
            bottomNavigationBar: ColoredBox(
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                 viewModel.isBusy ? const SizedBox() :  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'orders.order_cost'.tr(),
                        style: Theme.of(context).textTheme.titleMedium!,
                      ),
                      Text.rich(
                        TextSpan(
                            text: Formatters.formattedMoney(viewModel.order?.price),
                            children: [
                              TextSpan(
                                text: ' ${'common.sum'.tr()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: AppColors.grey),
                              )
                            ]),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  verticalSpace16,
                  AppButton(
                      text: 'common.confirm'.tr(),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      fillColor: Theme.of(context).primaryColor,
                      width: double.maxFinite,
                      borderRadius: BorderRadius.circular(12),
                      isActive: viewModel.buttonCondition(),
                      onPressed: viewModel.onPay)
                ]),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                   SectionTitle(title: 'menu.my_cards'.tr()),
                  verticalSpace16,
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            final card = viewModel.cardsList[index];
                            return DefaultChangeCard(
                                title: card.name!,
                                description: card.numberShort,
                                isSelected:
                                    viewModel.selectedCard?.id == card.id,
                                onTap: () => viewModel.chooseMethod(card: card),
                                backgroundColor:
                                    Theme.of(context).colorScheme.background,
                                icon: IconlyLight.wallet);
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(),
                          itemCount: viewModel.cardsList.length)),
                   SectionTitle(title: 'checkout.pay_method'.tr()),
                  verticalSpace16,
                  Expanded(
                      child: Column(
                    children: [
                      DefaultChangeCard(
                          title: 'common.bycash'.tr(),
                          description: 'checkout.when_pickup'.tr(),
                          onTap: () => viewModel.chooseMethod(withCash: true),
                          isSelected: viewModel.withCash,
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          icon: IconlyLight.wallet),
                      verticalSpace12,
                      DefaultChangeCard(
                          title: 'checkout.pay_by_wallet'.tr(),
                          onTap: () => viewModel.chooseMethod(
                                withBalance: true,
                              ),
                          isSelected: viewModel.withBalance,
                          description:
                              '${'common.balance'.tr()}: ${Formatters.formattedMoney(viewModel.balance!.balance)} ${'common.sum'.tr()}\n'
                                  '${'common.limit'.tr()}: ${Formatters.formattedMoney(viewModel.balance!.limit)} ${'common.sum'.tr()}\n',
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          icon: IconlyLight.wallet),
                      verticalSpace12,
                    ],
                  ))
                ],
              ),
            ),
          );
        });
  }
}
