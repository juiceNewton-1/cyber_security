import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:cyber_security/models/password.dart';
import 'package:cyber_security/services/database/database_service.dart';
import 'package:cyber_security/services/database/entities/password_entity.dart';

class PasswordsController extends ValueNotifier<PasswordsState> {
  PasswordsController() : super(PasswordsState.initial()) {
    _init();
  }
  final _databaseService = GetIt.instance<DatabaseService>();

  void _init() {
    final passwords =
        _databaseService.getPasswords().map((e) => Password.fromEntity(e));
    value.passwords.addAll(passwords);
    notifyListeners();

    _databaseService.passwordsStream.listen(_handleUpdates);
  }

  void addPassword(Password password) {
    final passwordEntity = PasswordEntity.fromPassword(password);
    _databaseService.addPassword(passwordEntity);
    value.passwords.add(password);
    notifyListeners();
  }

  void deletePassword(Password password) {
    final passwordIndex = value.passwords.indexOf(password);
    _databaseService.deletePassword(passwordIndex);
    value.passwords.removeAt(passwordIndex);
    notifyListeners();
  }

  void _handleUpdates(BoxEvent boxEvent) {
    final passwords = _databaseService
        .getPasswords()
        .map((e) => Password.fromEntity(e))
        .toList();
    value = value.copyWith(passwords: passwords);
  }
}

class PasswordsState {
  final List<Password> passwords;

  const PasswordsState({required this.passwords});

  factory PasswordsState.initial() => PasswordsState(passwords: []);

  PasswordsState copyWith({
    List<Password>? passwords,
  }) =>
      PasswordsState(
        passwords: passwords ?? this.passwords,
      );
}
