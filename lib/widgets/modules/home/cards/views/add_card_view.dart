import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_input_formatter/mask_input_formatter.dart';
import 'package:cyber_security/generated/assets.gen.dart';
import 'package:cyber_security/models/arguments.dart';
import 'package:cyber_security/models/card.dart';
import 'package:cyber_security/services/database/entities/card_entity.dart';
import 'package:cyber_security/widgets/components/app_text_filed.dart';
import 'package:cyber_security/widgets/components/card_text_field.dart';
import 'package:cyber_security/widgets/modules/home/cards/controller/add_card_controller.dart';

class AddCardView extends StatefulWidget {
  final AddCardViewArguments? arguments;
  const AddCardView({super.key, required this.arguments});

  @override
  State<AddCardView> createState() => _AddCardViewState();

  factory AddCardView.create(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as AddCardViewArguments?;
    return AddCardView(arguments: arguments);
  }
}

class _AddCardViewState extends State<AddCardView> {
  AddCardViewArguments? get _arguments => widget.arguments;
  var _isButtonEnabled = false;

  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _expirationDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _pinController = TextEditingController();
  final _addCardController = AddCardController();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    if (_arguments != null) {
      _nameController.text = _arguments!.card.name;
      _numberController.text = _arguments!.card.number;
      _expirationDateController.text = _arguments!.card.expirationDate;
      _cvvController.text = _arguments!.card.cvv;
      _pinController.text = _arguments!.card.pin;
      _isButtonEnabled = true;
    } else {
      _isButtonEnabled = false;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _expirationDateController.dispose();
    _cvvController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(
      () => _isButtonEnabled = _numberController.text.length == 4 &&
          _expirationDateController.text.length == 5 &&
          _cvvController.text.length == 3 &&
          _pinController.text.length == 4,
    );
  }

  void _save() {
    final card = UserCard(
      name: _nameController.text.isEmpty ? 'Undefined' : _nameController.text,
      number: _numberController.text,
      expirationDate: _expirationDateController.text,
      cvv: _cvvController.text,
      pin: _pinController.text,
      cardStatus: CardStatus.active,
    );
    if (_arguments != null) {
      _addCardController.updateCard(
        card,
        _arguments!.index,
      );
    } else {
      _addCardController.addCard(card);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Card'),
        leading: CupertinoButton(
          padding: EdgeInsets.only(left: 20),
          child: Assets.icons.close.svg(),
          onPressed: Navigator.of(context).pop,
        ),
        actions: [
          _SaveButton(
            isActive: _isButtonEnabled,
            onPressed: _isButtonEnabled ? _save : null,
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30),
            AppTextField(
              textController: _nameController,
              placeholder: 'Name card',
              onChanged: _onChanged,
            ),
            SizedBox(height: 19),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 26),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CardTextField(
                    hint: 'YYYY',
                    textEditingController: _numberController,
                    prefix: 'XXXX-XXXX-XXXX-',
                    maxLength: 4,
                    onChanged: _onChanged,
                  ),
                  SizedBox(height: 34),
                  CardTextField(
                    textEditingController: _expirationDateController,
                    hint: '00/00',
                    maxLength: 5,
                    onChanged: _onChanged,
                    formatters: [MaskInputFormatter(mask: '##/##')],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CardTextField(
                          textEditingController: _cvvController,
                          hint: 'CVV',
                          maxLength: 3,
                          onChanged: _onChanged,
                        ),
                      ),
                      SizedBox(width: 42),
                      Expanded(
                        child: CardTextField(
                          textEditingController: _pinController,
                          hint: 'Pin',
                          maxLength: 4,
                          onChanged: _onChanged,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback? onPressed;
  const _SaveButton({
    required this.isActive,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Container(
        alignment: Alignment.center,
        width: 68,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(38),
          color: isActive ? null : Theme.of(context).colorScheme.secondary,
          gradient: isActive
              ? LinearGradient(
                  colors: [
                    Color(0xFFFFC701),
                    Color(0xFFFF8E09),
                  ],
                )
              : null,
        ),
        child: Text(
          'Save',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: isActive
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSecondary,
              ),
        ),
      ),
    );
  }
}
