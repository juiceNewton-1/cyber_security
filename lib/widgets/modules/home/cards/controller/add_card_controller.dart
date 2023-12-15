import 'package:get_it/get_it.dart';
import 'package:cyber_security/models/card.dart';
import 'package:cyber_security/services/database/database_service.dart';
import 'package:cyber_security/services/database/entities/card_entity.dart';

class AddCardController {
  final _databaseService = GetIt.instance<DatabaseService>();


  void addCard(UserCard card) {
    final cardEntity = CardEntity.fromCard(card);
    _databaseService.addCard(cardEntity);
  }

  void updateCard(UserCard card, int index) {
    final cardEntity = CardEntity.fromCard(card);
    _databaseService.updateCard(cardEntity, index);
  }
}
