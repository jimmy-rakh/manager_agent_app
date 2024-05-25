import 'package:bingo/data/models/card/response/get_card_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:iconly/iconly.dart';
import 'package:pull_down_button/pull_down_button.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget(
      {super.key,
      required this.background,
      required this.cardInfo,
      required this.onDelete});

  final String background;
  final GetCardResponse cardInfo;
  final void Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return PullDownButton(
        position: PullDownMenuPosition.automatic,
        itemBuilder: (context) {
          return [
            PullDownMenuTitle(title: Text('card.settings'.tr())),
            const PullDownMenuDivider.large(),
            PullDownMenuItem(
              enabled: true,
              title: 'common.delete'.tr(),
              onTap: () => onDelete(cardInfo.id!),
              isDestructive: true,
              iconColor: Colors.red,
              icon: CupertinoIcons.trash,
            )
          ];
        },
        buttonBuilder: (context, showMenu) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Container(
              height: 160,
              padding: EdgeInsets.zero,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(background), fit: BoxFit.cover)),
              child: Stack(children: [
                Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.black54, Colors.transparent]))),
                Positioned(
                    left: 16,
                    top: 14,
                    child: Text(cardInfo.ownerName ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: AppColors.white))),
                Positioned(
                    left: 16,
                    top: 38,
                    child: Text(
                      cardInfo.numberShort ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontSize: 22, color: AppColors.white),
                    )),
                Positioned(
                    left: 16,
                    top: 66,
                    child: Text(
                      '02/28',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontSize: 16, color: AppColors.white),
                    )),
                Positioned(
                    left: 16,
                    bottom: 15,
                    child: Text(
                      cardInfo.name ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: AppColors.white),
                    )),
                Positioned(
                    right: 16,
                    bottom: 15,
                    child: GestureDetector(
                      onTap: showMenu,
                      child: const Icon(
                        IconlyLight.edit_square,
                        color: AppColors.white,
                      ),
                    ))
              ]),
            ),
          );
        });
  }
}
