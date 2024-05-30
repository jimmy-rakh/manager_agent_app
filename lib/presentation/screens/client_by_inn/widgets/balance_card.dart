import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../../core/utils/spaces.dart';
import '../client_by_inn_viewmodel.dart';

class BalanceCard extends ViewModelWidget<ClientByInnViewModel> {
  const BalanceCard(this.company, this.balance, this.limit, this.bonus, {super.key});
  final String? company;
  final String? balance;
  final String? limit;
  final String? bonus;

  @override
  Widget build(BuildContext context, ClientByInnViewModel viewModel) {
    final currentWidth = MediaQuery.of(context).size.width;
    final crossCount = (currentWidth/ 300).floor();
    return currentWidth < 600 ? Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
            width: 220,
            child: Text(company ?? "",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace12,
            Row(
              children: [
                const SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Баланс"),
                      Text(':'),
                    ],
                  ),
                ),
                horizontalSpace10,
                Text(balance ?? "")
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Лимит"),
                      Text(':'),
                    ],
                  ),
                ),
                horizontalSpace10,
                Text(limit ?? "")
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Бонус"),
                      Text(':'),
                    ],
                  ),
                ),
                horizontalSpace10,
                Text(bonus ?? "")
              ],
            ),
          ],
        ),
      ],
    ):Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
            width: 220,
            child: Text(company ?? "",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace12,
            Row(
              children: [
                const SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Баланс"),
                      Text(':'),
                    ],
                  ),
                ),
                horizontalSpace10,
                Text(balance ?? "")
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Лимит"),
                      Text(':'),
                    ],
                  ),
                ),
                horizontalSpace10,
                Text(limit ?? "")
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Бонус"),
                      Text(':'),
                    ],
                  ),
                ),
                horizontalSpace10,
                Text(bonus ?? "")
              ],
            ),
          ],
        ),
      ],
    );
  }
}
