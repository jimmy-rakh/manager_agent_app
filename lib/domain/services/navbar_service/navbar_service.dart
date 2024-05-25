import 'package:bingo/app/locator.dart';
import 'package:bingo/core/enum/user_status.dart';
import 'package:bingo/domain/services/auth_service/auth_service.dart';
import 'package:bingo/domain/services/search_service/search_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NavBarService with ListenableServiceMixin {
  final AuthService _authService = getIt();
  final SearchService _searchService = getIt();

  NavBarService() {
    listenToReactiveValues([
      _currIndex,
      _homeScrollController,
      _searchScrollController,
      _firstScreenSearchStatus,
      _secondScreenSearchStatus
    ]);
  }

  final ReactiveValue<int> _currIndex = ReactiveValue(0);
  final ReactiveValue<ScrollController> _homeScrollController =
      ReactiveValue(ScrollController());
  final ReactiveValue<ScrollController> _searchScrollController =
      ReactiveValue(ScrollController());

  final ReactiveValue<bool> _firstScreenSearchStatus = ReactiveValue(false);
  final ReactiveValue<bool> _secondScreenSearchStatus = ReactiveValue(false);


  int get currIndex => _currIndex.value;
  bool get firstScreenSearchStatus => _firstScreenSearchStatus.value;
  bool get secondScreenSearchStatus => _secondScreenSearchStatus.value;
  UserStatus get userStatus => _authService.userStatus;
  ScrollController get homeScrollController => _homeScrollController.value;
  ScrollController get searchScrollController => _searchScrollController.value;

  void onChange(int index) {
    // FocusScope.of(NavigationService.nestedKeys[currIndex].currentContext ??
    //         NavigationService.nestedKeys[index].currentContext!)
    //     .unfocus();
    // _currIndex.value = index;
  }

  changeSearchingValue(bool value, int index) {
    index == 0
        ? _firstScreenSearchStatus.value = value
        : _secondScreenSearchStatus.value = value;
    if(index == 1 && value == false) {
      _searchService.updateSearchRequest();
    }
  }


}
