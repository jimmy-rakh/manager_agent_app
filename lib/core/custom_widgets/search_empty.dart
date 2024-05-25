import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SearchEmpty extends StatelessWidget {
  const SearchEmpty({super.key, required this.isHistory});

  final bool isHistory;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 80),
            child: Icon(
              IconlyLight.search,
              color: Colors.grey,
              size: 120,
            ),
          ),
          Text(
            isHistory ? 'search.empty_history'.tr() : 'search.no_matches'.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          )
        ]);
  }
}
