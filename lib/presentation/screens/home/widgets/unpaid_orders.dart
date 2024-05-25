import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/custom_widgets/section_title.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/datetime_utils.dart';
import 'package:bingo/core/utils/formatters.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/home/home_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UnpaidOrders extends ViewModelWidget<HomeViewModel> {
  const UnpaidOrders({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SectionTitle(
              title: 'common.invoices'.tr(),
              trailing: AppButton(
                  text:'(${viewModel.unpaidOrders!.length})',
                  onPressed: () {})),
        ),
        verticalSpace12,
        SizedBox(
          height: 160,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.unpaidOrders?.length ?? 0,
            separatorBuilder: (context, index) => horizontalSpace20,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemBuilder: (_, index) {
              final order = viewModel.unpaidOrders![index];
              return GestureDetector(
                onTap: () => viewModel.toOrder(order.id!),
                child: Container(
                  width: ScreenSize.width - 48,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'orders.order_number'.tr(args: [order.id.toString()]),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            DateTime.parse(order.createdAt!)
                                .dateTimeFormatter(),
                            style: Theme.of(context).textTheme.labelMedium,
                          )
                        ],
                      ),
                      verticalSpace10,
                      const Divider(
                        color: AppColors.grey,
                        height: 0,
                      ),
                      verticalSpace10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                                  'checkout.${order.delivery!.toLowerCase()}'
                                      .tr(),maxLines: 1,style: const TextStyle(fontSize: 11),)),
                          Text.rich(
                            TextSpan(
                                text: Formatters.formattedMoney(order.price),
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
                      verticalSpace10,
                      AppButton(
                          text: 'common.pay'.tr(),
                          textStyle: Theme.of(context).textTheme.titleSmall!,
                          fillColor: Theme.of(context).primaryColor,
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          borderRadius: BorderRadius.circular(14),
                          onPressed: () => viewModel.onPay(order.id!))
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
