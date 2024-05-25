import 'package:hive/hive.dart';

part 'user_status.g.dart';

@HiveType(typeId: 0)
enum UserStatus {
  @HiveField(0)
  notAuthorized,

  @HiveField(1)
  authorized
}
