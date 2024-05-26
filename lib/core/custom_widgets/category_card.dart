import 'package:bingo/app/router.dart';
import 'package:bingo/data/models/categories/catigories_dto.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    super.key,
    required this.category,
    this.isSelected = false,
    this.showImage = true,
  });

  final CategoriesDto category;
  final bool isSelected;
  final bool showImage;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool expanded = false;

  toogleExpander() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StickyHeader(
      header: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: toogleExpander,
        child: Container(
          height: 50.0,
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.category.name!,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Icon(expanded ? IconlyLight.arrow_up_2 : IconlyLight.arrow_down_2)
            ],
          ),
        ),
      ),
      content: AnimatedSize(
        duration: Durations.medium1,
        child: expanded
            ? ListView.separated(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.category.subCategories?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => router.push(
                    SpecificProductsRoute(
                      category: widget.category,
                      subcategory: widget.category.subCategories![index],
                    ),
                  ),
                  child: Container(
                    height: 50.0,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.category.subCategories![index].name ?? 'без имени',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const Icon(IconlyLight.arrow_right_2)
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey.withOpacity(.2),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
