import 'package:equatable/equatable.dart';
import 'package:cyber_security/services/database/entities/card_entity.dart';

class UserCard extends Equatable {
  final String name;
  final String number;
  final String expirationDate;
  final String cvv;
  final String pin;
  final CardStatus cardStatus;

  const UserCard({
    required this.name,
    required this.number,
    required this.expirationDate,
    required this.cvv,
    required this.pin,
    required this.cardStatus,
  });

  factory UserCard.fromEntity(CardEntity cardEntity) => UserCard(
        name: cardEntity.name,
        number: cardEntity.number,
        expirationDate: cardEntity.expirationDate,
        cvv: cardEntity.cvv,
        pin: cardEntity.pin,
        cardStatus: cardEntity.cardStatus,
      );

  UserCard copyWith({
    String? name,
    String? number,
    String? expirationDate,
    String? cvv,
    String? pin,
    CardStatus? cardStatus,
  }) =>
      UserCard(
        name: name ?? this.name,
        number: number ?? this.number,
        expirationDate: expirationDate ?? this.expirationDate,
        cvv: cvv ?? this.cvv,
        pin: pin ?? this.pin,
        cardStatus: cardStatus ?? this.cardStatus,
      );

  @override
  List<Object?> get props => [
        name,
        number,
        expirationDate,
        cvv,
        pin,
        cardStatus,
      ];
}
