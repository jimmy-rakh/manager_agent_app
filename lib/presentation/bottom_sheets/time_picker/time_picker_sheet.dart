import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimePickerSheet extends StatefulWidget {
  const TimePickerSheet({super.key});

  @override
  State<TimePickerSheet> createState() => _TimePickerSheetState();
}

class _TimePickerSheetState extends State<TimePickerSheet> {
  late DateTime pickedDate;
  late DateTime minimumDate;
  late DateTime maximumDate;

  @override
  void initState() {
    pickedDate = DateTime.now().add(const Duration(hours: 5));
    minimumDate = DateTime.now().add(const Duration(hours: 4));
    maximumDate = DateTime.now().add(const Duration(days: 7));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        verticalSpace24,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'checkout.delivery_time'.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SizedBox(
          height: ScreenSize.height * .2,
          child: CupertinoDatePicker(
            initialDateTime: pickedDate,
            minimumDate: minimumDate,
            maximumDate: maximumDate,
            use24hFormat: true,
            onDateTimeChanged: (DateTime newDateTime) {
              pickedDate = newDateTime;
              setState(() {});
            },
          ),
        ),
        AppButton(
            text: 'common.select'.tr(),
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            fillColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            isActive: pickedDate.compareTo(minimumDate) > 0,
            onPressed: () => Navigator.pop(context, pickedDate))
      ],
    );
  }
}
