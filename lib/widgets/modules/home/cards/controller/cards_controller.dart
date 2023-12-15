import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:cyber_security/models/card.dart';
import 'package:cyber_security/services/database/database_service.dart';
import 'package:cyber_security/services/database/entities/card_entity.dart';

class CardsController extends ValueNotifier<CardsState> {
  CardsController() : super(CardsState.initial()) {
    _init();
  }
  final _databaseService = GetIt.instance<DatabaseService>();

  void _init() {
    final cards =
        _databaseService.getCards().map((e) => UserCard.fromEntity(e));
    value.cards.addAll(cards);
    notifyListeners();

    _databaseService.cardsStream.listen(_handleUpdates);
  }

  void deleteCard(UserCard card) {
    final cardIndex = value.cards.indexOf(card);
    _databaseService.deleteCard(cardIndex);
    value.cards.removeAt(cardIndex);
    notifyListeners();
  }

  void activateCard(UserCard card) {
    final cardIndex = value.cards.indexOf(card);
    final updatedCard = card.copyWith(cardStatus: CardStatus.active);
    final cardEntity = CardEntity.fromCard(updatedCard);
    _databaseService.updateCard(cardEntity, cardIndex);
    value.cards[cardIndex] = updatedCard;
    notifyListeners();
  }

    void archiveCard(UserCard card) {
    final cardIndex = value.cards.indexOf(card);
    final updatedCard = card.copyWith(cardStatus: CardStatus.archival);
    final cardEntity = CardEntity.fromCard(updatedCard);
    _databaseService.updateCard(cardEntity, cardIndex);
    value.cards[cardIndex] = updatedCard;
    notifyListeners();
  }

  void _handleUpdates(BoxEvent boxEvent) {
    final cards =
        _databaseService.getCards().map((e) => UserCard.fromEntity(e)).toList();
    value = value.copyWith(cards: cards);
  }

  void sort(CardSort cardSort) => value = value.copyWith(cardSort: cardSort);
}

class CardsState {
  final List<UserCard> cards;
  final CardSort cardSort;

  const CardsState({
    required this.cards,
    required this.cardSort,
  });

  factory CardsState.initial() => CardsState(
        cards: [],
        cardSort: CardSort.all,
      );

  CardsState copyWith({
    List<UserCard>? cards,
    CardSort? cardSort,
  }) =>
      CardsState(
        cards: cards ?? this.cards,
        cardSort: cardSort ?? this.cardSort,
      );
}

enum CardSort {
  all,
  active,
  archival,
}
