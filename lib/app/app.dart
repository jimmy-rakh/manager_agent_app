import 'package:bingo/app/app_viewmodel.dart';
import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/observers/navigation_observer.dart';
import 'package:bingo/core/styles/theme.dart';
import 'package:bingo/domain/services/app/app_service.dart';
import 'package:bingo/domain/services/notification_service/notification_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  final _themeService = getIt<AppService>();
  final _appRouter = getIt<AppRouter>();
  final _notificationService = getIt<NotificationService>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _notificationService.getFcmToken();
    // final window = View.of(context).platformDispatcher;

    // window.onPlatformBrightnessChanged = () {
    //   WidgetsBinding.instance.handlePlatformBrightnessChanged();
    //   _themeService.setThemeData(window.platformBrightness == Brightness.dark);
    // };
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (model) => model.onReady(),
      builder: (context, viewModel, child) {
        return MaterialApp.router(
          title: 'Bingo',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          themeMode: _themeService.themeMode.value,
          theme: DefaultAppThemes.lightTheme,
          darkTheme: DefaultAppThemes.darkTheme,
          routerConfig: _appRouter.config(
            navigatorObservers: () => [NavigationObserver()],
          ),
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1)),
                child: child!);
          },
        );
      },
      viewModelBuilder: () => AppModel(),
    );
  }
}
