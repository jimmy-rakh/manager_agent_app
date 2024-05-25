import 'package:flutter/material.dart';
import 'package:bingo/core/utils/spaces.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList(
      {Key? key,
      required this.child,
      required this.height,
      required this.onItemTapped,
      this.itemBackColor,
      this.listPadding = 25,
      this.itemRadius = 12,
      this.seperatedPadding = horizontalSpace16})
      : super(key: key);

  final Widget child;
  final double height;
  final Color? itemBackColor;
  final double listPadding;
  final Widget seperatedPadding;
  final double itemRadius;
  final void Function() onItemTapped;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: listPadding),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onItemTapped,
                child: child);
          },
          separatorBuilder: (BuildContext context, int index) =>
              seperatedPadding,
          itemCount: 10),
    );
  }
}
