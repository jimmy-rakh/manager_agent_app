import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final phoneMask = MaskTextInputFormatter(
    mask: '(##) ###-##-##', filter: {"#": RegExp(r'[0-9]')});
