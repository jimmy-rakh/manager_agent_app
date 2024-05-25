import 'package:auto_route/auto_route.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/custom_widgets/search_bar_widget.dart';
import 'package:bingo/core/utils/is_dark.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:iconly/iconly.dart';

class CustomSearchAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomSearchAppBar({
    Key? key,
    required this.isSearching,
    required this.searchController,
    required this.onClear,
    required this.isBusy,
    required this.onChanged,
    required this.isSearched,
    required this.onSearchFieldTapped,
    this.focusNode,
    this.showFilter = false,
    this.onFilterTapped,
    this.onSubmit,
    this.allowAction = false,
  }) : super(key: key);

  final bool isSearching;
  final bool isBusy;
  final bool isSearched;
  final bool showFilter;
  final TextEditingController searchController;
  final void Function(String?) onClear;
  final void Function(String) onChanged;
  final void Function() onSearchFieldTapped;
  final void Function()? onFilterTapped;
  final void Function(String)? onSubmit;
  final FocusNode? focusNode;
  final bool allowAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      leadingWidth: isSearching ? 56 : 0,
      leading: AnimatedScale(
          duration: Durations.medium2,
          scale: isSearching ? 1 : 0,
          child: AutoLeadingButton(
              builder: (context, leadingType, action) => GestureDetector(
                  onTap: () {
                    onClear(null);
                    debugPrint(router.currentSegments.last.name);
                    if (action != null && allowAction) action();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Icon(
                    IconlyLight.arrow_left_2,
                    color: isDarkModeEnabled(context)
                        ? AppColors.textDark
                        : AppColors.textLight,
                  )))),
      title: AnimatedContainer(
          height: 40,
          duration: const Duration(milliseconds: 900),
          margin: EdgeInsets.only(
              left: isSearching ? 0 : 24, right: isSearching ? 16 : 0),
          curve: Curves.fastOutSlowIn,
          child: SearchBarWidget(
            hintText: 'common.search'.tr(),
            controller: searchController,
            isSearching: isBusy,
            isSearched: isSearched,
            onChanged: onChanged,
            onClear: onClear,
            onSubmit: onSubmit,
            onTap: onSearchFieldTapped,
            focusNode: focusNode,
          )),
      actions: [
        horizontalSpace20
        // if (showFilter)
        //   AnimatedScale(
        //     duration: Durations.medium2,
        //     scale: showFilter ? 1 : 0,
        //     child: GestureDetector(
        //       behavior: HitTestBehavior.opaque,
        //       onTap: onFilterTapped,
        //       child: Padding(
        //         padding: EdgeInsets.only(right: isSearching ? 24 : 0),
        //         child: Opacity(
        //             opacity: isSearching ? 1 : 0,
        //             child: Icon(
        //               IconlyLight.filter,
        //               size: 24,
        //               color: isDarkModeEnabled(context)
        //                   ? AppColors.textDark
        //                   : AppColors.textLight,
        //             )),
        //       ),
        //     ),
        //   )
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}
