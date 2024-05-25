import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:iconly/iconly.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget(
      {Key? key,
      this.cursorColor = AppColors.primary,
      required this.hintText,
      required this.controller,
      required this.isSearching,
      required this.isSearched,
      this.onSubmit,
      this.onClear,
      this.onChanged,
      this.onTap,
      this.focusNode})
      : super(key: key);

  final Color? cursorColor;
  final String hintText;
  final TextEditingController controller;
  final bool isSearching;
  final bool isSearched;
  final void Function(String)? onSubmit;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final Function? onClear;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
        autocorrect: false,
        textAlign: TextAlign.left,
        cursorColor: cursorColor,
        controller: controller,
        placeholder: hintText,
        style: Theme.of(context).textTheme.bodySmall,
        onSubmitted: onSubmit,
        onChanged: onChanged,
        focusNode: focusNode,
        onTap: onTap,
        prefix: const Padding(
            padding: EdgeInsets.fromLTRB(12, 8, 8, 8),
            child: Icon(
              IconlyLight.search,
              color: Color(0xffc4c4c4),
              size: 16,
            )),
        suffix: !isSearching && !isSearched
            ? const SizedBox()
            : isSearching
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: CupertinoActivityIndicator(
                      color: AppColors.grey,
                    ))
                : IconButton(
                    onPressed: () => onClear!(''),
                    icon: const Icon(CupertinoIcons.multiply_circle_fill),
                    color: AppColors.grey,
                  ),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10)));
  }
}
