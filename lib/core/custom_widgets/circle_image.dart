import 'package:bingo/core/assets/assets.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:flutter/material.dart';

class CustomCircleImage extends StatelessWidget {
  const CustomCircleImage(
      {super.key, required this.size, this.icon, this.imageUrl, this.iconSize});

  final Size size;
  final IconData? icon;
  final String? imageUrl;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(width: 1, color: AppColors.bgDark),
              image: imageUrl == '' || imageUrl == null
                  ? const DecorationImage(
                      image: AssetImage(AppAssets.profileImage),
                      fit: BoxFit.cover)
                  : DecorationImage(
                      image: NetworkImage(imageUrl!),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) => const DecorationImage(
                          image: AssetImage(AppAssets.profileImage),
                          fit: BoxFit.cover),
                    ),
              shape: BoxShape.circle),
        ),
        if (icon != null)
          Positioned(
            right: 4,
            child: GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: iconSize,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
