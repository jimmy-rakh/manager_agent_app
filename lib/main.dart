import 'package:bingo/app/app.dart';
import 'package:bingo/app/locator.dart';
import 'package:bingo/core/custom_widgets/keyboard_escape.dart';
import 'package:bingo/core/enum/user_status.dart';
import 'package:bingo/core/utils/device_info.dart';
import 'package:bingo/data/models/categories/catigories_dto.dart';
import 'package:bingo/data/sources/local/storage_constants.dart';
import 'package:bingo/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await _setUpHive();
    await _initializeFirebase();
    setUpLocator();
    await EasyLocalization.ensureInitialized();
    DeviceInfo.getDeviceData();
    runApp(EasyLocalization(supportedLocales: const [
      Locale('ru'),
      Locale('uz'),
    ], path: 'assets/locale', child: const MainApp()));
  } catch (e) {
    runApp(const KeyboardEscape(child: MainApp()));
  }
}

Future<void> _initializeFirebase() async {
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    await Firebase.initializeApp();
  }
}

Future<void> _setUpHive() async {
  Hive.init((await getApplicationDocumentsDirectory()).path);

  Hive.registerAdapter(UserStatusAdapter());
  Hive.registerAdapter(CategoriesAdapter());

  await Hive.openBox(StorageConstants.okansBox);
  await Hive.openBox(StorageConstants.themeBox);
  await Hive.openBox(StorageConstants.userStatusBox);
}
