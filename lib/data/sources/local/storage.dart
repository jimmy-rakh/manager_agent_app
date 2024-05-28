import 'package:bingo/core/enum/user_status.dart';
import 'package:bingo/data/models/categories/catigories_dto.dart';
import 'package:bingo/data/sources/local/storage_constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

abstract class LocalStorage {
  void setUserStatus(UserStatus userStatus);

  UserStatus getUserStatus();

  void setThemeMode(ThemeMode mode);

  ThemeMode getThemeMode();

  void setLocale(String locale);

  String? getLocale();

  void setDeviceToken(String token);

  String? getDeviceToken();

  Future<void> clear();

  void setCategories(List<CategoriesDto> categories);

  List<CategoriesDto> getCategories();
}

class LocalStorageImpl implements LocalStorage {
  @override
  UserStatus getUserStatus() {
    final box = Hive.box(StorageConstants.userStatusBox);
    if (box.isEmpty) {
      return UserStatus.notAuthorized;
    }
    return box.getAt(0);
  }

  @override
  void setUserStatus(UserStatus userStatus) {
    final box = Hive.box(StorageConstants.userStatusBox);
    if (box.isEmpty) {
      box.add(userStatus);
    } else {
      box.putAt(0, userStatus);
    }
  }

  @override
  ThemeMode getThemeMode() {
    final box = Hive.box(StorageConstants.themeBox);
    final String lsValue = box.get(StorageConstants.themeMode,
        defaultValue: ThemeMode.system.name);

    switch (lsValue) {
      case 'system':
        return ThemeMode.system;
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  @override
  void setThemeMode(ThemeMode mode) {
    final box = Hive.box(StorageConstants.themeBox);

    box.put(StorageConstants.themeMode, mode.name);
  }

  @override
  String? getLocale() {
    final box = Hive.box(StorageConstants.okansBox);
    return box.get(StorageConstants.locale, defaultValue: null);
  }

  @override
  void setLocale(String locale) {
    final box = Hive.box(StorageConstants.okansBox);
    box.put(StorageConstants.locale, locale);
  }

  @override
  String? getDeviceToken() {
    final box = Hive.box(StorageConstants.okansBox);
    return box.get(StorageConstants.deviceToken, defaultValue: null);
  }

  @override
  void setDeviceToken(String token) {
    final box = Hive.box(StorageConstants.okansBox);
    box.put(StorageConstants.deviceToken, token);
  }

  @override
  Future<void> clear() async {
    final box = Hive.box(StorageConstants.okansBox);
    final userStatusBox = Hive.box(StorageConstants.userStatusBox);
    await userStatusBox.clear();
    await box.clear();
  }

  @override
  void addWaitpayOrder(List<int> orderIds) {
    final box = Hive.box(StorageConstants.okansBox);
    box.put(StorageConstants.waitPaymentOrders, orderIds);
  }

  @override
  List<int> getWaitpayOrders() {
    final box = Hive.box(StorageConstants.okansBox);
    return box.get(StorageConstants.waitPaymentOrders, defaultValue: []);
  }

  @override
  void addWaitComment(List<int> orderIds) {
    final box = Hive.box(StorageConstants.okansBox);
    box.put(StorageConstants.waitComment, orderIds);
  }

  @override
  List<int> getWaitComment() {
    final box = Hive.box(StorageConstants.okansBox);
    return box.get(StorageConstants.waitComment, defaultValue: []);
  }

  @override
  List<CategoriesDto> getCategories() {
    final box = Hive.box(StorageConstants.okansBox);
    return box.get(StorageConstants.categories,
        defaultValue: []).cast<CategoriesDto>();
  }

  @override
  void setCategories(List<CategoriesDto> categories) {
    final box = Hive.box(StorageConstants.okansBox);

    box.put(StorageConstants.categories, categories);
  }
}
