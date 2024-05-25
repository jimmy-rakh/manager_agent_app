import 'package:bingo/core/custom_widgets/default_sheet_parent.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:iconly/iconly.dart';

class ProductInfoSheet extends StatelessWidget {
  const ProductInfoSheet({Key? key, required this.data}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return DefaultSheetParent(
      radius: 12,
      padding: 24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'product.description'.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.pop(context),
                child: Icon(
                  IconlyLight.close_square,
                  size: 32,
                  color: Theme.of(context).colorScheme.error,
                ),
              )
            ],
          ),
          verticalSpace12,
          Html(data: data)
        ],
      ),
    );
  }
}
