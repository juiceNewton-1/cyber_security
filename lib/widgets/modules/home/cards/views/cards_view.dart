import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cyber_security/generated/assets.gen.dart';
import 'package:cyber_security/helpers/extension.dart';
import 'package:cyber_security/models/arguments.dart';
import 'package:cyber_security/routes/route_names.dart';
import 'package:cyber_security/services/database/entities/card_entity.dart';
import 'package:cyber_security/theme/custom_colors.dart';
import 'package:cyber_security/widgets/components/app_drawer.dart';
import 'package:cyber_security/widgets/components/app_gradient_button.dart';
import 'package:cyber_security/widgets/components/app_slidable_action.dart';
import 'package:cyber_security/widgets/components/settings_button.dart';
import 'package:cyber_security/widgets/modules/home/cards/controller/cards_controller.dart';
import 'package:cyber_security/models/card.dart';

class CardsView extends StatefulWidget {
  CardsView({super.key});

  @override
  State<CardsView> createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  late final _cardsController = CardsController();

  Future<void> _navigateToSort() async {
    final cardSort = await Navigator.of(context).pushNamed(
      RouteNames.cardSort,
      arguments:
          CardSortViewArguments(cardSort: _cardsController.value.cardSort),
    );
    if (_cardsController.value.cardSort != cardSort) {
      _cardsController.sort(cardSort! as CardSort);
    }
  }

  final _key = GlobalKey<ScaffoldState>();

  void _openDrawer() => _key.currentState!.openDrawer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: _cardsController,
          builder: (context, value, child) => _CardSortPanel(
            cardSort: value.cardSort,
            onPressed: _navigateToSort,
          ),
        ),
        leading: SettingsButton(
          onPressed: _openDrawer,
        ),
        actions: [
          CupertinoButton(
            padding: EdgeInsets.only(right: 15),
            child: Assets.icons.addInactive.svg(),
            onPressed: () =>
                Navigator.of(context).pushNamed(RouteNames.addCard),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: _cardsController,
        builder: (context, value, child) {
          if (value.cards.isEmpty) {
            return _EmptyState();
          } else {
            final cards = value.cardSort == CardSort.all
                ? value.cards
                : value.cards
                    .where((e) => e.cardStatus.name == value.cardSort.name)
                    .toList();
            return _NonEmptyState(
              cards: cards,
              delete: _cardsController.deleteCard,
              archive: _cardsController.archiveCard,
              activate: _cardsController.activateCard,
            );
          }
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'There are no Password\nin the app'.toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: 58),
          AppGradientButton(
            label: 'add card',
            onPressed: () =>
                Navigator.of(context).pushNamed(RouteNames.addCard),
          ),
          SizedBox(height: 58),
          Text(
            'Add a new one and store your PIN\ncodes securely',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}

class _NonEmptyState extends StatelessWidget {
  final List<UserCard> cards;
  final void Function(UserCard) delete;
  final void Function(UserCard) archive;
  final void Function(UserCard) activate;
  const _NonEmptyState({
    required this.cards,
    required this.delete,
    required this.archive,
    required this.activate,
  });

  @override
  Widget build(BuildContext context) {
    return cards.isEmpty
        ? Center(
            child: Text(
              'Empty',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          )
        : ListView.separated(
            padding: EdgeInsets.only(left: 16, right: 16, top: 20),
            itemCount: cards.length,
            separatorBuilder: (context, index) => SizedBox(height: 18),
            itemBuilder: (context, index) {
              final card = cards[index];
              final isArchived = card.cardStatus == CardStatus.archival;
              return Slidable(
                startActionPane: ActionPane(
                  extentRatio: 0.3,
                  motion: ScrollMotion(),
                  children: [
                    isArchived
                        ? AppSlidableAction(
                            backgroundColor: Theme.of(context)
                                .extension<CustomColors>()!
                                .green,
                            label: 'Activate',
                            onPressed: () => activate.call(card),
                          )
                        : AppSlidableAction(
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                            label: 'Archive',
                            onPressed: () => archive.call(card),
                          ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SizedBox(width: 10),
                    AppSlidableAction(
                      backgroundColor:
                          Theme.of(context).extension<CustomColors>()!.red,
                      label: 'Delete',
                      onPressed: () => delete.call(card),
                    ),
                  ],
                ),
                child: _CardTile(
                  card: card,
                  isArchived: isArchived,
                  onPressed: () => Navigator.of(context).pushNamed(
                    RouteNames.addCard,
                    arguments: AddCardViewArguments(
                      card: card,
                      index: index,
                    ),
                  ),
                ),
              );
            },
          );
  }
}

class _CardTile extends StatelessWidget {
  final UserCard card;
  final bool isArchived;
  final VoidCallback? onPressed;
  const _CardTile({
    required this.card,
    required this.isArchived,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 13),
        width: double.infinity,
        height: 62,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: isArchived ? Theme.of(context).colorScheme.surface : null,
          gradient: isArchived
              ? null
              : LinearGradient(
                  colors: [
                    Color(0xFFFFC701),
                    Color(0xFFFF8E09),
                  ],
                ),
        ),
        child: Row(
          children: [
            Text(
              card.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Spacer(),
            SizedBox(width: 20),
            Text(
              card.number,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardSortPanel extends StatelessWidget {
  final CardSort cardSort;
  final VoidCallback? onPressed;
  const _CardSortPanel({
    required this.cardSort,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        width: 139,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(38),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${cardSort.name.capitalize} cards',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(width: 11),
            Assets.icons.chevronDown.svg()
          ],
        ),
      ),
    );
  }
}

class _SortTile extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback? onPressed;
  const _SortTile({
    required this.label,
    required this.isActive,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Row(
        children: [
          Text(label),
          Spacer(),
          _Radio(isActive: isActive),
        ],
      ),
    );
  }
}

class _Radio extends StatelessWidget {
  final bool isActive;
  const _Radio({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 19,
      height: 19,
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).colorScheme.surface : null,
        border: isActive
            ? null
            : Border.all(
                width: 2,
                color: Theme.of(context).colorScheme.surface,
              ),
      ),
      child: isActive
          ? Icon(
              Icons.done,
              color: Color(0xFF373737),
              size: 15,
            )
          : null,
    );
  }
}
