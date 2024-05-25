import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/custom_widgets/app_text_field.dart';
import 'package:bingo/core/custom_widgets/default_sheet_parent.dart';
import 'package:bingo/core/custom_widgets/rating_widget.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/data/models/orders/response/order_details_dto.dart';
import 'package:bingo/presentation/bottom_sheets/add_review_sheet/add_review_sheet_viewmodel.dart';
import 'package:bingo/presentation/bottom_sheets/add_review_sheet/widgets/add_review_products_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddReviewSheetView extends StatelessWidget {
  const AddReviewSheetView({super.key, required this.order});

  final OrderDetailsDto order;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddReviewSheetViewModel>.reactive(
        viewModelBuilder: () => AddReviewSheetViewModel(),
        onViewModelReady: (model) => model.onReady(order),
        builder: (context, viewModel, child) {
          return DefaultSheetParent(
            padding: 12,
            radius: 12,
            child: SizedBox(
              height: 390,
              child: ListView(
                children: [
                  const AddReviewProductsWidget(),
                  verticalSpace16,
                  AppTextField(
                      fieldController: viewModel.commentController,
                      label: 'review.review_comment'.tr(),
                      isRequired: true,
                      maxLines: 5,
                      alignLabelWithHint: true),
                  verticalSpace10,
                  CustomRatingWidget(
                    onRatingUpdate: viewModel.onRatingChanged,
                    rating: viewModel.rating,
                  ),
                  verticalSpace20,
                  AppButton(
                      width: double.maxFinite,
                      fillColor: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      text: 'review.add_review'.tr(),
                      isLoading: viewModel.isBusy,
                      isActive: viewModel.product != null &&
                          viewModel.commentController.text.length > 2 &&
                          viewModel.rating != 0,
                      onPressed: viewModel.onAddReview),
                  verticalSpace10
                ],
              ),
            ),
          );
        });
  }
}
