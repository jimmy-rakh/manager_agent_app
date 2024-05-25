import 'package:bingo/core/assets/assets.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/datetime_utils.dart';
import 'package:bingo/core/utils/formatters.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/order_details/order_details_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/custom_widgets/default_image_container.dart';
import '../../../../core/utils/mediaquery.dart';

class OrderInfoView extends ViewModelWidget<OrderDetailsViewModel> {
  const OrderInfoView({
    super.key,
  });

  @override
  Widget build(BuildContext context, OrderDetailsViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).cardColor),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'orders.manager'.tr(),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            verticalSpace12,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultImageContainer(
                        imageUrl: viewModel.order!.manager?.avatarUrl,
                        height: ScreenSize.height * .055,
                        backgroundColor: AppColors.white,
                        radius: 12),
                    horizontalSpace10,
                    SizedBox(
                      width: ScreenSize.width * .35,
                      child: Text(
                        viewModel.order!.manager?.fullName ?? '',
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        UrlLauncher.launchUrl(
                            Uri.parse(
                                'https://t.me/${viewModel.order?.manager?.messengers?.first}'),
                            mode: LaunchMode.externalApplication);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: ScreenSize.height * .05,
                        width: ScreenSize.width * .1,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset(
                            AppAssets.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    horizontalSpace10,
                    GestureDetector(
                      onTap: () {
                        UrlLauncher.launchUrl(Uri(
                          scheme: "tel",
                          path: viewModel.order?.manager?.phoneNumbers?.first,
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: ScreenSize.height * .05,
                        width: ScreenSize.width * .1,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset(
                            AppAssets.phone,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            verticalSpace12,
            Text(
              'checkout.about_order'.tr(),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            verticalSpace12,
            Row(
              children: [
                Text('common.date'.tr()),
                const Spacer(),
                Text(DateTime.parse(viewModel.order!.createdAt!)
                    .dateTimeFormatter())
              ],
            ),
            verticalSpace10,
            Row(
              children: [
                Text('orders.get_method'.tr()),
                const Spacer(),
                Text(
                    'checkout.${viewModel.order!.delivery!.toLowerCase()}'.tr())
              ],
            ),
            verticalSpace10,
            if (viewModel.order?.paymethod != null)
              Row(
                children: [
                  Text('checkout.pay_method'.tr()),
                  const Spacer(),
                  Text(
                      'common.${viewModel.order!.paymethod?.toLowerCase() ?? ''}'
                          .tr())
                ],
              ),
            verticalSpace10,
            if (viewModel.order!.delivery != 'pickup'.toUpperCase()) ...[
              Row(
                children: [
                  Text('orders.delivery_cost'.tr()),
                  const Spacer(),
                  RichText(
                      text: TextSpan(
                          text: viewModel.order!.deliveryCost ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text: ' ${'common.sum'.tr()}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.grey)),
                      ])),
                ],
              ),
              verticalSpace10,
            ],
            Row(
              children: [
                Text('orders.order_cost'.tr()),
                const Spacer(),
                RichText(
                    text: TextSpan(
                        text: Formatters.formattedMoney(viewModel.order!.price),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                        children: [
                      TextSpan(
                          text: ' ${'common.sum'.tr()}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.grey)),
                    ])),
              ],
            ),
            verticalSpace10,
            if (viewModel.order!.address != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('checkout.delivery_time'.tr()),
                  viewModel.order?.deliveryTime == null
                      ? const SizedBox()
                      : Text(DateTime.parse(viewModel.order!.deliveryTime!)
                          .dateTimeFormatter())
                ],
              ),
              verticalSpace10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('common.address'.tr()),
                  horizontalSpace25,
                  Flexible(child: Text(viewModel.order!.address!))
                ],
              ),
              verticalSpace10,
            ],
          ]),
    );
  }
}
