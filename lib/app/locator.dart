import 'package:bingo/app/router.dart';
import 'package:bingo/core/network/globuskans_api_service.dart';
import 'package:bingo/data/sources/local/storage.dart';
import 'package:bingo/data/sources/network/address_api.dart';
import 'package:bingo/data/sources/network/auth_api.dart';
import 'package:bingo/data/sources/network/card_api.dart';
import 'package:bingo/data/sources/network/order_api.dart';
import 'package:bingo/data/sources/network/products_api.dart';
import 'package:bingo/data/sources/network/search_api.dart';
import 'package:bingo/data/sources/network/template_api.dart';
import 'package:bingo/domain/repositories/address_repository.dart';
import 'package:bingo/domain/repositories/auth_repository.dart';
import 'package:bingo/domain/repositories/card_repository.dart';
import 'package:bingo/domain/repositories/order_repository.dart';
import 'package:bingo/domain/repositories/products_repository.dart';
import 'package:bingo/domain/repositories/search_repository.dart';
import 'package:bingo/domain/repositories/template_repository.dart';
import 'package:bingo/domain/services/address_service/address_service.dart';
import 'package:bingo/domain/services/app/app_service.dart';
import 'package:bingo/domain/services/auth_service/auth_service.dart';
import 'package:bingo/domain/services/card_service/card_service.dart';
import 'package:bingo/domain/services/navbar_service/navbar_service.dart';
import 'package:bingo/domain/services/notification_service/notification_service.dart';
import 'package:bingo/domain/services/order_service/order_service.dart';
import 'package:bingo/domain/services/products_service/products_service.dart';
import 'package:bingo/domain/services/search_service/search_service.dart';
import 'package:bingo/domain/services/templates/templates_service.dart';
import 'package:stacked/stacked_annotations.dart';

import '../domain/services/client_service.dart';

final getIt = StackedLocator.instance;

Future<void> setUpLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  getIt.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies

  // DATAS
  getIt.registerLazySingleton(() => LocalStorageImpl());
  getIt.registerLazySingleton(() => BingoApi());
  getIt.registerLazySingleton(() => AuthApiImpl());
  getIt.registerLazySingleton(() => ProductsApiImpl());
  getIt.registerLazySingleton(() => OrderApiImpl());
  getIt.registerLazySingleton(() => CardApiImpl());
  getIt.registerLazySingleton(() => AddressApiImpl());
  getIt.registerLazySingleton(() => SearchApiImpl());
  getIt.registerLazySingleton(() => TemplateApiImpl());

  // SERVICES
  getIt.registerLazySingleton(() => AppService());
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton(() => NavBarService());
  getIt.registerLazySingleton(() => ProductsService());
  getIt.registerLazySingleton(() => OrderService());
  getIt.registerLazySingleton(() => CardService());
  getIt.registerLazySingleton(() => AddressService());
  getIt.registerLazySingleton(() => SearchService());
  getIt.registerLazySingleton(() => NotificationService());
  getIt.registerLazySingleton(() => TemplateService());
  getIt.registerLazySingleton(() => ClientService());

  // REPOSITORIES
  getIt.registerLazySingleton(() => AuthRepositoryImpl());
  getIt.registerLazySingleton(() => ProductsRepositoryImpl());
  getIt.registerLazySingleton(() => OrderRepositoryImpl());
  getIt.registerLazySingleton(() => CardRepositoryImpl());
  getIt.registerLazySingleton(() => AddressRepositoryImpl());
  getIt.registerLazySingleton(() => SearchReposioryImpl());
  getIt.registerLazySingleton(() => TemplateRepositoryImpl());

  getIt.registerLazySingleton(() => AppRouter());
}
