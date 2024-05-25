import 'package:auto_route/annotations.dart';
import 'package:bingo/core/custom_widgets/app_bar.dart';
import 'package:bingo/presentation/screens/account/pages/address/address_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddressScreenViewModel>.reactive(
        viewModelBuilder: () => AddressScreenViewModel(),
        onViewModelReady: (model) => model.onReady(),
        builder: (context, viewModel, child) {
          // final isDarkMode = isDarkModeEnabled(context);
          return Scaffold(
            appBar: CustomAppBar(title: 'menu.my_addresses'.tr()),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: viewModel.isBusy
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : Column(
                    children: [],
                  ),
          );
        });
  }
}
