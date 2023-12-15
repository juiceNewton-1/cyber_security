import 'package:hive/hive.dart';
import 'package:cyber_security/models/password.dart';

part 'password_entity.g.dart';

@HiveType(typeId: 0)
class PasswordEntity extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String source;
  @HiveField(2)
  final String login;
  @HiveField(3)
  final String password;

  PasswordEntity(
      {required this.name,
      required this.source,
      required this.login,
      required this.password});

  factory PasswordEntity.fromPassword(Password password) => PasswordEntity(
        name: password.name,
        source: password.source,
        login: password.login,
        password: password.password,
      );
}
