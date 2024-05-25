import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ProductDetailsSheet extends StatelessWidget {
  const ProductDetailsSheet({Key? key, required this.characters})
      : super(key: key);
  final List<ProductCharacters> characters;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: characters.isEmpty ? .7 : .4,
        minChildSize: characters.isEmpty ? .7 : .4,
        maxChildSize: .9,
        builder: (context, controller) {
          return Container(
              padding: const EdgeInsets.only(bottom: 100),
              color: Theme.of(context).cardColor,
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(24),
                  itemBuilder: (context, index) {
                    final character = characters[index];
                    return Column(
                      children: [
                        if (index == 0) ...[
                          Row(
                            children: [
                              Text(
                                'product.product_details'.tr(),
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
                          verticalSpace16,
                        ],
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Text(
                              character.key!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.grey),
                            )),
                            const SizedBox(width: 42),
                            Expanded(
                                child: Text(
                              character.value!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.w800),
                            )),
                          ],
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, child) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(height: 1, color: AppColors.grey),
                    );
                  },
                  itemCount: characters.length));
        });
  }
}
