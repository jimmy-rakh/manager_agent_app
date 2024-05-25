import 'package:flutter/material.dart';
import 'package:bingo/core/styles/colors.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({
    super.key,
    required this.countController,
    required this.onDecrement,
    required this.onIncrement,
     this.onChanged,
     this.focusNode,
    this.onFieldTapped,
  });

  final TextEditingController countController;

  final void Function() onDecrement;
  final void Function() onIncrement;
  final void Function(String)? onChanged;
  final VoidCallback? onFieldTapped;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onDecrement,
          child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(4))),
              height: 30,
              width: 36,
              alignment: Alignment.center,
              child: const Icon(
                Icons.remove_rounded,
                color: AppColors.white,
              )),
        ),
        Container(
          width:MediaQuery.of(context).size.width * .3,
          height: 30,
          decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 2)),
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            controller: countController,
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16),
            maxLength: 4,
            keyboardType: TextInputType.number,
            maxLines: 1,
            onTap: onFieldTapped,
            focusNode: focusNode,
            showCursor: false,
            textAlign: TextAlign.center,
            onChanged: onChanged,
            decoration: const InputDecoration(
              counterText: "",
              isDense: true,
              filled: false,
              border: InputBorder.none,
            ),
          ),
        ),
        GestureDetector(
          onTap: onIncrement,
          child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius:
                      const BorderRadius.horizontal(right: Radius.circular(4))),
              height: 30,
              width: 36,
              child: const Icon(
                Icons.add_rounded,
                color: AppColors.white,
              )),
        )
      ],
    );
  }
}
