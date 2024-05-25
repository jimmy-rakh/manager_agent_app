import 'package:easy_localization/easy_localization.dart';

extension GetMonthNameFromDateTime on DateTime {
  String getMonth() {
    switch (month) {
      case 1:
        return 'dates.january'.tr();
      case 2:
        return 'dates.february'.tr();
      case 3:
        return 'dates.march'.tr();
      case 4:
        return 'dates.april'.tr();
      case 5:
        return 'dates.may'.tr();
      case 6:
        return 'dates.june'.tr();
      case 7:
        return 'dates.july'.tr();
      case 8:
        return 'dates.august'.tr();
      case 9:
        return 'dates.september'.tr();
      case 10:
        return 'dates.october'.tr();
      case 11:
        return 'dates.november'.tr();
      case 12:
        return 'dates.december'.tr();
    }
    return '';
  }

  ///takes "2021-10-14T05:38:30.919Z" returns 14.10.2021
  String dateFormatter() {
    DateTime datetime = this;
    return "${datetime.day < 10 ? '0${datetime.day}' : datetime.day}.${datetime.month < 10 ? '0${datetime.month}' : datetime.month}.${datetime.year}";
  }

  ///takes "2021-10-14T05:38:30.919Z" returns 14.10.2021, 5:38
  String dateTimeFormatter() {
    return DateFormat('dd.MM.yyyy, hh:mm').format(toLocal());
  }

  ///takes "2021-10-14T05:38:30.919Z" returns 05:38
  String timeFormatter() {
    DateTime datetime = this;
    return "${datetime.hour < 10 ? '0${datetime.hour}' : datetime.hour}:${datetime.minute < 10 ? '0${datetime.minute}' : datetime.minute}";
  }

  ///takes "2021-10-14T05:38:30.919Z" returns October 2021
  String dateFormatterWithMonth() {
    DateTime datetime = this;
    return "${datetime.getMonth()} ${datetime.year}";
  }
}

extension GetMonthNameFromInt on int {
  String getMonth() {
    switch (this) {
      case 0:
        return 'dates.Jan'.tr();
      case 1:
        return 'dates.Feb'.tr();
      case 2:
        return 'dates.Mar'.tr();
      case 3:
        return 'dates.Apr'.tr();
      case 4:
        return 'dates.May'.tr();
      case 5:
        return 'dates.Jun'.tr();
      case 6:
        return 'dates.Jul'.tr();
      case 7:
        return 'dates.Aug'.tr();
      case 8:
        return 'dates.Sep'.tr();
      case 9:
        return 'dates.Oct'.tr();
      case 10:
        return 'dates.Nov'.tr();
      case 11:
        return 'dates.Dec'.tr();
    }
    return '';
  }
}
