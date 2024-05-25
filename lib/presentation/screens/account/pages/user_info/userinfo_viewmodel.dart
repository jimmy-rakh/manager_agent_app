import 'package:bingo/app/locator.dart';
import 'package:bingo/core/utils/text_masks.dart';
import 'package:bingo/data/models/user/requests/change_user_status.dart';
import 'package:bingo/data/models/user/response/user_model.dart';
import 'package:bingo/data/models/user/response/user_requests.dart';
import 'package:bingo/domain/services/auth_service/auth_service.dart';
import 'package:bingo/domain/services/navigation_service/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UserInfoViewModel extends ReactiveViewModel {
  final AuthService _authService = getIt();

  @override
  List<ListenableServiceMixin> get listenableServices => [_authService];

  UserModel get user => _authService.userData!;
  List<UserRequestsDto> get userRequests => _authService.userRequests;

   TextEditingController nameController = TextEditingController();
   TextEditingController surnameController= TextEditingController();
   TextEditingController phoneController= TextEditingController();
   TextEditingController lastnameController= TextEditingController();
   TextEditingController companyNameController= TextEditingController();
   TextEditingController companyInnController= TextEditingController();
   TextEditingController activityContoller= TextEditingController();
   TextEditingController positionController= TextEditingController();
   TextEditingController addressController= TextEditingController();

  onReady() async {

    await getData();
    nameController = TextEditingController(text: user.firstName);
    surnameController = TextEditingController(text: user.surname);
    phoneController = TextEditingController(
        text: '+998 ${phoneMask.maskText('${user.phoneNumbers}')}');
    lastnameController = TextEditingController(text: user.lastname);
    companyNameController = TextEditingController(text: user.companyName);
    companyInnController = TextEditingController(text: user.companyInn);
    activityContoller = TextEditingController(text: user.kindOfActivity);
    positionController = TextEditingController(text: user.position);
    addressController = TextEditingController(text: user.address);

  }

  getData() async {
    setBusy(true);
    try {
      await _authService.getProfileData();
    } catch (e) {
      NavigationService.showErrorToast(e.toString());
    }
    setBusy(false);
  }

  onDataChange() async {
    ChangeUserStatusRequest request = ChangeUserStatusRequest(
      name: nameController.text,
      surname: surnameController.text,
      lastname: lastnameController.text,
      // type: user!.type,
      // address: addressController.text,
      // kindOfActivity: activityContoller.text,
      // position: positionController.text,
      // legalAddress: addressController.text,
      // companyName: companyNameController.text,
      // companyInn: companyInnController.text
    );
    setBusy(true);
    try {
      await _authService.editUserData(request);
    } catch (e) {
      NavigationService.showErrorToast(e.toString());
    }
    setBusy(false);
  }


  toChangeTypeView() async {
    // TODO await NavigationService.pushNamed(routeName: Routes.changeUserTypeView)
    //     .then((value) => onReady());
  }
}
