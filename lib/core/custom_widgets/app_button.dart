import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.fillColor,
    this.icon,
    this.height,
    this.width,
    required this.text,
    this.textStyle = const TextStyle(),
    required this.onPressed,
    this.isActive = true,
    this.textColor,
    this.shape,
    this.margin,
    this.isLoading = false,
    this.loadingColor,
    this.iconColor,
    this.showIconSpace = true,
  }) : super(key: key);

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final Color? fillColor;
  final Color? textColor;
  final Color? loadingColor;
  final bool isActive;
  final bool isLoading;
  final dynamic icon;
  final double? height;
  final double? width;
  final BoxShape? shape;
  final String text;
  final TextStyle textStyle;
  final void Function()? onPressed;
  final Color? iconColor;
  final bool showIconSpace;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isActive ? 1 : .6,
      child: GestureDetector(
        onTap: isActive && !isLoading ? onPressed : null,
        behavior: HitTestBehavior.opaque,
        child: Container(
            padding: padding,
            margin: margin,
            height: height,
            width: width,
            decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: fillColor,
                shape: shape ?? BoxShape.rectangle,
                border: borderColor != null
                    ? Border.all(width: 1, color: borderColor!)
                    : null),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  icon is IconData
                      ? Icon(
                          icon,
                          color: iconColor,
                        )
                      : SvgPicture.asset(icon, height: 14),
                  if (showIconSpace) horizontalSpace10
                ],
                isLoading
                    ? CupertinoActivityIndicator(
                        color: fillColor == AppColors.primary
                            ? AppColors.white
                            : loadingColor,
                      )
                    : Text(
                        text,
                        style: textStyle.copyWith(
                            color: fillColor == AppColors.primary || fillColor == AppColors.blood
                                ? AppColors.white
                                : textColor),
                      ),
              ],
            )),
      ),
    );
  }
}
