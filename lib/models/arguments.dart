import 'package:cyber_security/models/article.dart';
import 'package:cyber_security/models/password.dart';
import 'package:cyber_security/widgets/modules/agreement_view.dart';
import 'package:cyber_security/widgets/modules/home/cards/controller/cards_controller.dart';
import 'package:cyber_security/models/card.dart';


class AgreementViewArguments {
  final AgreementType agreementType;

  const AgreementViewArguments({required this.agreementType});
}

class ArticleViewArguments {
  final Article article;

  const ArticleViewArguments({required this.article});
}

class ChangePasswordViewArguments {
  final Password password;
  final int index;

  const ChangePasswordViewArguments({
    required this.password,
    required this.index,
  });
}

class CardSortViewArguments {
  final CardSort cardSort;

  const CardSortViewArguments({
    required this.cardSort,
  });
}

class AddCardViewArguments {
  final UserCard card;
  final int index;

  const AddCardViewArguments({
    required this.card,
    required this.index,
  });
}
