import 'package:bingo/core/custom_widgets/circle_image.dart';
import 'package:bingo/core/custom_widgets/rating_widget.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:flutter/material.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key, required this.review});

  final ProductCommentsDto review;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCircleImage(
          size: const Size(40, 40),
          imageUrl: 'https://test-api.okans.uz${review.client?.avatarUrl}',
        ),
        horizontalSpace10,
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(review.client?.name ?? 'Anonim'),
                  horizontalSpace10,
                  CustomRatingWidget(
                      rating: review.rating!.toDouble(), size: 15)
                ],
              ),
              Text(
                review.comment!,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w800, color: AppColors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
