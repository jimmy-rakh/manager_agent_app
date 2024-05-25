import 'package:auto_route/annotations.dart';
import 'package:bingo/core/custom_widgets/app_bar.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/cart/cart_viewmodel.dart';
import 'package:bingo/presentation/screens/cart/widgets/cart_products_widget.dart';
import 'package:bingo/presentation/screens/cart/widgets/checkout_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartViewModel>.reactive(
        viewModelBuilder: () => CartViewModel(),
        onViewModelReady: (model) => model.onReady(),
        builder: (context, viewModel, child) {
          bool keyboardIsOpened =
              MediaQuery.of(context).viewInsets.bottom != 0.0;
          return KeyboardDismisser(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: CustomAppBar(
                  leadingWidth: 5,
                  showLeading: false,
                  title: 'cart.cart_title'.tr(),
                  centeredTitle: false,
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  actions: [
                    if (viewModel.isBusy) const CupertinoActivityIndicator(),
                    if (viewModel.selectedCartProductsId.isNotEmpty &&
                        !viewModel.isBusy)
                      GestureDetector(
                          onTap: viewModel.delFromCart,
                          behavior: HitTestBehavior.opaque,
                          child: const Icon(
                            IconlyLight.delete,
                            color: AppColors.red,
                          )),
                    horizontalSpace15
                  ]),

              bottomNavigationBar: keyboardIsOpened
                  ? null
                  : (viewModel.cartData?.cartproducts?.isNotEmpty ?? false)
                      ? Visibility(
                          visible:
                              MediaQuery.of(Scaffold.of(context).context).viewInsets.bottom == 0.0,
                          child: const CheckoutWidget())
                      : null,
              body: const CartProductsWidget(),
            ),
          );
        });
  }
}
