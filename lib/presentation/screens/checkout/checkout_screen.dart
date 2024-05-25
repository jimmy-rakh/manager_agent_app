import 'package:auto_route/annotations.dart';
import 'package:bingo/core/custom_widgets/app_bar.dart';
import 'package:bingo/core/custom_widgets/section_title.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/checkout/checkout_viewmodel.dart';
import 'package:bingo/presentation/screens/checkout/widgets/about_order_section.dart';
import 'package:bingo/presentation/screens/checkout/widgets/cart_products_widget.dart';
import 'package:bingo/presentation/screens/checkout/widgets/checkout_btn.dart';
import 'package:bingo/presentation/screens/checkout/widgets/delivery_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, this.templateId});

  final String? templateId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckoutViewModel>.reactive(
        viewModelBuilder: () => CheckoutViewModel(),
        onViewModelReady: (viewModel) => viewModel.onReady(templateId),
        onDispose: (model) => model.onDispose(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: CustomAppBar(
              title: 'checkout.checkout_title'.tr(),
              centeredTitle: true,
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: AnimatedScale(
              scale: viewModel.orderButtonStatus() ? 1 : 0,
              duration: const Duration(milliseconds: 400),
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: CheckoutButton()),
            ),
            body: ListView(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                children: [
                  // SectionTitle(
                  //   title: "checkout.my_cart".tr(),
                  // ),
                  // verticalSpace12,
                  // const CartProductsWidget(),
                  verticalSpace10,
                  SectionTitle(
                    title: 'checkout.delivery_method'.tr(),
                  ),
                  verticalSpace12,
                  const DeliverySection(),
                  // verticalSpace12,
                  // SectionTitle(
                  //   title: "checkout.pay_method".tr(),
                  // ),
                  // verticalSpace12,
                  // const CardSection(),
                  verticalSpace16,
                  SectionTitle(
                    title: "checkout.about_order".tr(),
                  ),
                  const AboutOrderSection(),
                  const SizedBox(
                    height: 100,
                  )
                ]),
          );
        });
  }
}
