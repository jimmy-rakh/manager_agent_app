import 'package:bingo/core/custom_widgets/default_change_card.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/bottom_sheets/address_sheet/address_sheet_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

class AddressSheetView extends StatelessWidget {
  const AddressSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => AddressSheetViewModel(),
        onViewModelReady: (model) => model.onReady(),
        builder: (context, viewModel, child) {
          return viewModel.isBusy
              ? const CupertinoActivityIndicator()
              : SizedBox(
            height: MediaQuery.of(context).size.height * .7,
                child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 12),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final address = viewModel.adresses[index];
                      return DefaultChangeCard(
                          title: address.title!,
                          description: address.phoneNumbers!.join(', '),
                          onTap: () {
                              viewModel.onChooseAddress(address: address);
                              },
                          isSelected: viewModel.selectedAddress?.id == address.id,
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          icon: IconlyLight.location);
                    },
                    separatorBuilder: (context, index) {
                      return verticalSpace16;
                    },
                    itemCount: viewModel.adresses.length,
                  ),
              );
        });
  }
}
