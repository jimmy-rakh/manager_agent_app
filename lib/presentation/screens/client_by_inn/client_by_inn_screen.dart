import 'package:auto_route/annotations.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/client_by_inn/widgets/balance_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconly/iconly.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:stacked/stacked.dart';

import '../../../app/router.dart';
import '../../../core/custom_widgets/app_button.dart';
import '../../../core/custom_widgets/app_text_field.dart';
import '../../../core/custom_widgets/circle_image.dart';
import '../../../core/network/constants.dart';
import '../../../core/styles/colors.dart';
import 'client_by_inn_viewmodel.dart';

@RoutePage()
class ClientByInnScreen extends StatelessWidget {
  const ClientByInnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ClientByInnViewModel(),
        onViewModelReady: (viewModel) => viewModel.onReady(context),
        builder: (context, viewModel, child) {
          return KeyboardDismisser(
            child: Scaffold(
                appBar: AppBar(
                  actions: [
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(0,0,20,0),
                    //   child: GestureDetector(
                    //       onTap: (){
                    //         router.push(const CategoriesRouterRoute());
                    //       },
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(12),
                    //           color: AppColors.primary
                    //         ),
                    //         child: const Padding(
                    //           padding: EdgeInsets.all(10.0),
                    //           child: Row(
                    //             children: [
                    //               Text("Наменклатура",style: TextStyle(color: AppColors.white),),
                    //               horizontalSpace10,
                    //               Icon(IconlyLight.category,color: AppColors.white,),
                    //             ],
                    //           ),
                    //         ),
                    //       )),
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: GestureDetector(
                          onTap: () {
                            router.push(const AccountRouterRoute());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.primary),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Row(
                                children: [
                                  Text(
                                    "Профиль",
                                    style: TextStyle(color: AppColors.white),
                                  ),
                                  horizontalSpace10,
                                  Icon(
                                    IconlyLight.profile,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView(
                      shrinkWrap: true,
                      children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20, top: 50),
                      child: Text(
                        'Информация о Клиенте',
                        style: TextStyle(
                            color: AppColors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 35),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                width:MediaQuery.of(context).size.width * .7,
                                child: AppTextField(
                                    textInputType: TextInputType.number,
                                    fieldController: viewModel.usernameController,
                                    label: 'Ввидите ИНН Клиента'),
                              ),
                            ),
                            horizontalSpace5,
                            AppButton(
                                width:MediaQuery.of(context).size.width * .2,
                                text: 'Поиск',
                                textStyle: Theme.of(context).textTheme.bodyLarge!,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                borderRadius: BorderRadius.circular(10),
                                fillColor: Theme.of(context).primaryColor,
                                isLoading: viewModel.isBusy,
                                onPressed: () {
                                  if (viewModel.usernameController.text.isNotEmpty) {
                                    viewModel.getData();
                                    FocusScope.of(context).unfocus();
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),

                    viewModel.client == null || viewModel.isBusy
                        ? const SizedBox()
                        : Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColors.primary.withOpacity(0.07),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            // CustomCircleImage(
                                            //   size: const Size(90, 90),
                                            //   imageUrl:
                                            //       viewModel.client!.avatarUrl ==
                                            //               null
                                            //           ? null
                                            //           : NetworkConstants
                                            //                   .okansBaseUrl +
                                            //               viewModel.client!
                                            //                   .avatarUrl!,
                                            // ),
                                            // horizontalSpace12,
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 150,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              "Контактное лицо"),
                                                          Text(':'),
                                                        ],
                                                      ),
                                                    ),
                                                    horizontalSpace10,
                                                    Text(
                                                      viewModel.client
                                                              ?.fullName ??
                                                          '',
                                                      maxLines: 1,
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 150,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("Телефон"),
                                                          Text(':'),
                                                        ],
                                                      ),
                                                    ),
                                                    horizontalSpace10,
                                                    Text(viewModel
                                                            .client
                                                            ?.phoneNumbers
                                                            ?.first ??
                                                        '',
                                                      maxLines: 1,)
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 150,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("Компания"),
                                                          Text(':'),
                                                        ],
                                                      ),
                                                    ),
                                                    horizontalSpace10,
                                                    Text(
                                                      viewModel.client
                                                              ?.companyName ??
                                                          '',
                                                      maxLines: 1,
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 150,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("Тип Клиента"),
                                                          Text(':'),
                                                        ],
                                                      ),
                                                    ),
                                                    horizontalSpace10,
                                                    Text(viewModel
                                                            .client?.type ??
                                                        '',
                                                      maxLines: 1,)
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          router.push(NavBarRoute());
                                        },
                                        child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: const BoxDecoration(
                                            borderRadius:
                                                BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12)),
                                            color: AppColors.primary,
                                          ),
                                          child: const Center(child: Text("Заказ",style: TextStyle(color: AppColors.white,fontSize: 18),)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 40),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColors.primary.withOpacity(0.07),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: viewModel
                                          .client?.clientBalances?.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final client = viewModel
                                            .client?.clientBalances?[index];
                                        return Column(
                                          children: [
                                            BalanceCard(
                                                client?.name,
                                                client?.balance?.balance
                                                    .toString(),
                                                client?.balance?.limit
                                                    .toString(),
                                                client?.balance?.bonus
                                                    .toString()),
                                            const Divider(
                                              thickness: 0.3,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                  ]),
                )
                // jl;
                ),
          );
        });
  }
}
