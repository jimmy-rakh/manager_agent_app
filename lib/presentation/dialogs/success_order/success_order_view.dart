import 'package:bingo/core/assets/assets.dart';
import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/datetime_utils.dart';
import 'package:bingo/core/utils/formatters.dart';
import 'package:bingo/core/utils/is_dark.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/dialogs/success_order/success_order_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class SuccessOrderView extends StatelessWidget {
  const SuccessOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SuccessOrderViewModel>.reactive(
        viewModelBuilder: () => SuccessOrderViewModel(),
        builder: (context, viewModel, child) {
          bool isDark = isDarkModeEnabled(context);
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.fromLTRB(32, ScreenSize.height * .2, 32, 42),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.checkSuccess,
                      height: 120,
                      color: isDark ? AppColors.white : AppColors.bgDark,
                    ),
                    verticalSpace20,
                    Text('orders.success_order'.tr(),
                        style: Theme.of(context).textTheme.titleMedium),
                    verticalSpace16,
                    Text(
                        'orders.success_order_description'.tr(
                            args: [viewModel.lastCreatedOrder.id.toString()]),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.grey,
                            )),
                    verticalSpace45,
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: AppColors.grey.withOpacity(.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: isDark
                                  ? AppColors.bgLight
                                  : AppColors.bgDark)),
                      child: Column(children: [
                        Row(
                          children: [
                            Text('common.date'.tr()),
                            const Spacer(),
                            Text(DateTime.parse(
                                    '${viewModel.lastCreatedOrder.createdAt!}Z')
                                .dateTimeFormatter())
                          ],
                        ),
                        verticalSpace10,
                        Row(
                          children: [
                            Text('checkout.subtotal'.tr()),
                            const Spacer(),
                            Text(
                                '${Formatters.formattedMoney(viewModel.lastCreatedOrder.price)} ${'common.sum'.tr()}')
                          ],
                        ),
                        verticalSpace10,
                        if (viewModel.lastCreatedOrder.deliveryCost != null)
                          Row(
                            children: [
                              Text('checkout.delivery'.tr()),
                              const Spacer(),
                              Text(
                                  '${Formatters.formattedMoney(num.parse(viewModel.lastCreatedOrder.deliveryCost!))} ${'common.sum'.tr()}')
                            ],
                          ),
                        verticalSpace5,
                        Divider(
                          color: isDark ? AppColors.bgLight : AppColors.bgDark,
                        ),
                        verticalSpace5,
                        Row(
                          children: [
                            Text('checkout.total'.tr()),
                            const Spacer(),
                            Text(
                              "${Formatters.formattedMoney(viewModel.lastCreatedOrder.price! + (num.tryParse(viewModel.lastCreatedOrder.deliveryCost ?? '') ?? 0))} ${'common.sum'.tr()}",
                            )
                          ],
                        ),
                      ]),
                    ),
                    const Spacer(),
                    AppButton(
                      text: 'common.continue'.tr(),
                      textStyle: Theme.of(context).textTheme.bodyLarge!,
                      width: double.maxFinite,
                      onPressed: viewModel.closeDialog,
                      textColor: AppColors.white,
                      fillColor: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
