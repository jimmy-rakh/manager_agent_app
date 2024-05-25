import 'dart:convert';
import 'dart:io';

import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/enum/order_statuses.dart';
import 'package:bingo/data/sources/local/storage_constants.dart';
import 'package:bingo/domain/services/order_service/order_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class NotificationService {
  final _orderService = getIt<OrderService>();
  NotificationService() {
    _setupNotificationService();
  }

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'fcm_default_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotifications =
      FlutterLocalNotificationsPlugin();

  Future<String?> getFcmToken() async {
    return await _firebaseMessaging.getToken();
  }

  void _setupNotificationService() async {
    // iOS notifications setup
    (Platform.isIOS
            ? await _flutterLocalNotifications
                .resolvePlatformSpecificImplementation<
                    IOSFlutterLocalNotificationsPlugin>()
                ?.requestPermissions(
                  alert: true,
                  badge: true,
                  sound: true,
                )
            : await _flutterLocalNotifications
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()
                ?.requestNotificationsPermission()) ??
        false;
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Android foreground notifications setup
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/notification_icon');
    var iosSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: iosSettings);
    if (Platform.isAndroid) {
      await _flutterLocalNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_channel);
    }
    await _flutterLocalNotifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _onSelectNotification);
    print(await _firebaseMessaging.getToken());

    // Init firebase notification listeners
    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        final data = remoteMessage.data;
        _toOrderPage(data);
      }
    });
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  }

  Future<void> _showNotification(RemoteMessage remoteMessage) async {
    if (remoteMessage.notification?.title == null &&
        remoteMessage.notification?.body == null) {
      return;
    }

    final notification = remoteMessage.notification;
    String data = jsonEncode(remoteMessage.data);

    await _showBackgroundNotification(
        title: notification?.title, body: notification?.body, payload: data);
  }

  Future<void> _onSelectNotification(NotificationResponse response) async {
    if (response.payload != null) {
      Map<String, dynamic> data = jsonDecode(response.payload!);
      _onBackgroundNotificationPressed(data);
    }
  }

  Future<void> _showBackgroundNotification(
      {String? title, String? body, String? payload}) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: Importance.max,
      playSound: true,
      showProgress: true,
      priority: Priority.high,
    );
    var iOSChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
    await _flutterLocalNotifications
        .show(0, title, body, platformChannelSpecifics, payload: payload);
  }

  void _onBackgroundNotificationPressed(Map<String, dynamic> data) async {
    _toOrderPage(data);
    print(data);
  }

  Future<void> _onMessageOpenedApp(RemoteMessage message) async {
    final data = message.data;
    _toOrderPage(data);
  }

  void _toOrderPage(Map<String, dynamic> data) {
    if (data.containsKey('status')) {
      router.push(OrderDetailsRoute(orderId: int.parse(data['id'])));
    }
  }

  void _handleMessage(RemoteMessage message) async {
    print(message);
    print(message.data);

    switch (message.data['status']) {
      case 'NEW':
        handleNewOrder();
        break;
      case 'WAITPAY':
        _fetchUnpaidOrders();
        break;
      default:
    }

    if (Platform.isAndroid) {
      _showNotification(message);
    }
  }


  Future<void> _fetchUnpaidOrders() async {
    try {
      _orderService.fetchUnpaidOrders();
    } catch (e) {
      print(e);
    }
  }

  void handleNewOrder() {
    print('\n\n New Order \n\n');
  }

  Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
    Hive.init((await getApplicationDocumentsDirectory()).path);

    await Hive.openBox(StorageConstants.okansBox);
    if (message.data.containsKey('status')) {
      final box = Hive.box(StorageConstants.okansBox);
      switch (message.data['status']) {
        case OrderStatuses.waitPay:
          List<int> waitPayOrders =
              box.get(StorageConstants.waitPaymentOrders, defaultValue: []);
          waitPayOrders.add(message.data['id']);
          box.put(StorageConstants.waitPaymentOrders, waitPayOrders);
          break;
        case OrderStatuses.completed:
          break;
        default:
      }
    }
    print(message.toMap());
  }
}
