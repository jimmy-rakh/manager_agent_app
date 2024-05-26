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
    return  Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
            width: 250,
            child: Text(company ?? "",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)),
        horizontalSpace12,
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
