import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:iconly/iconly.dart';

class CustomRatingWidget extends StatelessWidget {
  const CustomRatingWidget(
      {super.key,
      required this.rating,
      this.onRatingUpdate,
      this.isActive = false, this.size = 35});

  final double rating;
  final bool isActive;
  final double size;
  final void Function(double)? onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RatingBar.builder(
            initialRating: rating,
            itemCount: 5,
            itemSize: size,
            itemBuilder: (context, index) {
              return Icon(
                rating <= index ? IconlyLight.star : IconlyBold.star,
                color: AppColors.actionColor5,
              );
            },
            onRatingUpdate: onRatingUpdate ?? (rating) {}),
        if (!isActive)
          Container(
            height: 12,
            width: 100,
            color: Colors.transparent,
          )
      ],
    );
  }
}
