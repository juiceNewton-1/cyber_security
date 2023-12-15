import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cyber_security/services/database/entities/card_entity.dart';
import 'package:cyber_security/services/database/entities/password_entity.dart';
import 'package:cyber_security/services/database/entities/theme_mode_entity.dart';

class DatabaseService {
  late Box _common;
  late Box<PasswordEntity> _passwords;
  late Box<CardEntity> _cards;
  late Box<ThemeModeEntity> _theme;
  Future<DatabaseService> init() async {
    final appDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDirectory.path);
    Hive.registerAdapter(PasswordEntityAdapter());
    Hive.registerAdapter(CardEntityAdapter());
    Hive.registerAdapter(CardStatusAdapter());
    Hive.registerAdapter(ThemeModeEntityAdapter());
    _common = await Hive.openBox('common');
    _passwords = await Hive.openBox('passwords');
    _cards = await Hive.openBox('cards');
    _theme = await Hive.openBox('theme');
    return this;
  }

  Stream<BoxEvent> get passwordsStream => _passwords.watch();

  Stream<BoxEvent> get cardsStream => _cards.watch();

  void put(String key, dynamic value) => _common.put(key, value);

  dynamic get(String key) => _common.get(key);

  void delete(String key) => _common.delete(key);

  void addPassword(PasswordEntity passwordEntity) =>
      _passwords.add(passwordEntity);

  void deletePassword(int index) => _passwords.deleteAt(index);

  void updatePassword(PasswordEntity passwordEntity, int index) =>
      _passwords.putAt(index, passwordEntity);

  Iterable<PasswordEntity> getPasswords() => _passwords.values;

  void addCard(CardEntity cardEntity) => _cards.add(cardEntity);

  void deleteCard(int index) => _cards.deleteAt(index);

  void updateCard(CardEntity cardEntity, int index) =>
      _cards.putAt(index, cardEntity);

  Iterable<CardEntity> getCards() => _cards.values;

  bool isDarkTheme() => _theme.get('theme') == ThemeModeEntity.dark;

  void updateTheme(ThemeModeEntity themeModeEntity) =>
      _theme.put('theme', themeModeEntity);
}
