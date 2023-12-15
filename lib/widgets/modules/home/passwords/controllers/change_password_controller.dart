import 'package:get_it/get_it.dart';
import 'package:cyber_security/models/password.dart';
import 'package:cyber_security/services/database/database_service.dart';
import 'package:cyber_security/services/database/entities/password_entity.dart';

class ChangePasswordController {
  final _databaseService = GetIt.instance<DatabaseService>();

  void updatePassword(Password password, int index) {
    final passwordEntity = PasswordEntity.fromPassword(password);
    _databaseService.updatePassword(passwordEntity, index);
  }

  void addPassword(Password password) {
    final passwordEntity = PasswordEntity.fromPassword(password);
    _databaseService.addPassword(passwordEntity);
  }
}
