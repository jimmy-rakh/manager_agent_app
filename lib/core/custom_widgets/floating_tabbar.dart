import 'package:flutter/material.dart';
import 'package:bingo/core/styles/colors.dart';

class FloatingTabBar extends StatelessWidget {
  final TabController tabController;
  final List<String> tabList;
  final List<Color>? colors;
  final Function(int index) onTabTapped;

  const FloatingTabBar(
      {Key? key,
      required this.tabController,
      required this.tabList,
      required this.onTabTapped,
      this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12)),
        height: 45,
        child: TabBar(
            padding: EdgeInsets.zero,
            controller: tabController,
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            indicatorWeight: 0,
            indicator: BoxDecoration(
              // borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(tabController.index == 0 ? 12 : 0),
              //     topRight: Radius.circular(tabController.index == 2 ? 12 : 0),
              //     bottomLeft: Radius.circular(tabController.index == 0 ? 12 : 0),
              //     bottomRight:
              //         Radius.circular(tabController.index == 2 ? 12 : 0)),
              color: colors != null
                  ? colors![tabController.index]
                  : Theme.of(context).primaryColor,
            ),
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: const EdgeInsets.all(0),
            labelColor: Colors.white,
            indicatorColor: colors != null
                ? colors![tabController.index]
                : Theme.of(context).primaryColor,
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            onTap: onTabTapped,
            tabs: [
              for (int i = 0; i < tabList.length; i++)
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(tabController.index == 0 ? 12 : 0),
                        topRight:
                            Radius.circular(tabController.index == 2 ? 12 : 0),
                        bottomLeft:
                            Radius.circular(tabController.index == 0 ? 12 : 0),
                        bottomRight:
                            Radius.circular(tabController.index == 2 ? 12 : 0)),
                  ),
                  child: Center(
                    child: Opacity(
                      opacity: i == tabController.index ? 1 : .8,
                      child: Text(
                        tabList[i],
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: i == tabController.index
                                ? AppColors.white
                                : null),
                      ),
                    ),
                  ),
                ),
            ]),
      ),
    );
  }
}
