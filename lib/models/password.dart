import 'package:equatable/equatable.dart';
import 'package:cyber_security/services/database/entities/password_entity.dart';

class Password extends Equatable {
  final String name;
  final String source;
  final String login;
  final String password;

  const Password({
    required this.name,
    required this.source,
    required this.login,
    required this.password,
  });

  factory Password.fromEntity(PasswordEntity passwordEntity) => Password(
        name: passwordEntity.name,
        source: passwordEntity.source,
        login: passwordEntity.login,
        password: passwordEntity.password,
      );

  @override
  List<Object?> get props => [
        name,
        source,
        login,
        password,
      ];
}
