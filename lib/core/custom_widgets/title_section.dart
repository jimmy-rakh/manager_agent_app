import 'package:flutter/material.dart';

class TitleSectionWidget extends StatelessWidget {
  const TitleSectionWidget({Key? key, required this.name, this.onTap})
      : super(key: key);

  final String name;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          Text(
            name,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w300),
          ),
          if (onTap != null) ...[
            const Spacer(),
            // GestureDetector(
            //   behavior: HitTestBehavior.opaque,
            //   onTap: onTap,
            //   child: Text(
            //     'common.all'.tr(),
            //     style: Theme.of(context).textTheme.labelLarge!,
            //   ),
            // ),
          ]
        ],
      ),
    );
  }
}
