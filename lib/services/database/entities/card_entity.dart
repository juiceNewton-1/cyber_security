import 'package:hive/hive.dart';
import 'package:cyber_security/models/card.dart';

part 'card_entity.g.dart';

@HiveType(typeId: 1)
class CardEntity extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String number;
  @HiveField(2)
  final String expirationDate;
  @HiveField(3)
  final String cvv;
  @HiveField(4)
  final String pin;
  @HiveField(5)
  final CardStatus cardStatus;

  CardEntity({
    required this.name,
    required this.number,
    required this.expirationDate,
    required this.cvv,
    required this.pin,
    required this.cardStatus,
  });

  factory CardEntity.fromCard(UserCard card) => CardEntity(
        name: card.name,
        number: card.number,
        expirationDate: card.expirationDate,
        cvv: card.cvv,
        pin: card.pin,
        cardStatus: card.cardStatus,
      );
}

@HiveType(typeId: 2)
enum CardStatus {
  @HiveField(0)
  active,
  @HiveField(1)
  archival,
}
