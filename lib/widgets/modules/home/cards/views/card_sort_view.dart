import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cyber_security/generated/assets.gen.dart';
import 'package:cyber_security/helpers/extension.dart';
import 'package:cyber_security/models/arguments.dart';
import 'package:cyber_security/widgets/modules/home/cards/controller/cards_controller.dart';

class CardSortView extends StatefulWidget {
  final CardSortViewArguments arguments;
  const CardSortView({super.key, required this.arguments});

  @override
  State<CardSortView> createState() => _CardSortViewState();

  factory CardSortView.create(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as CardSortViewArguments;
    return CardSortView(arguments: arguments);
  }
}

class _CardSortViewState extends State<CardSortView> {
  late var _cardSort;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    _cardSort = widget.arguments.cardSort;
  }

  void _selectCardSort(CardSort cardSort) {
          setState(() => _cardSort = cardSort);
          _onExit();
  }

  void _onExit() {
    Navigator.of(context).pop(_cardSort);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onExit();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: CupertinoButton(
            padding: EdgeInsets.only(left: 5),
            child: Assets.icons.close.svg(),
            onPressed: _onExit,
          ),
          title: Text('Display'),
        ),
        body: ListView.separated(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
          ),
          itemBuilder: (context, index) {
            final cardSort = CardSort.values[index];
            return _SortTile(
              onPressed: () => _selectCardSort(cardSort),
              label: cardSort.name.capitalize,
              isActive: cardSort == _cardSort,
            );
          },
          separatorBuilder: (context, index) => Divider(
            height: 44,
            thickness: 2,
            color: Theme.of(context).colorScheme.surface,
          ),
          itemCount: CardSort.values.length,
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
          Text(
            '$label cards',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w500),
          ),
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
        shape: BoxShape.circle,
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
