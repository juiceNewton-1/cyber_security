import 'package:cyber_security/services/database/database_keys.dart';
import 'package:cyber_security/services/database/database_service.dart';
import 'package:cyber_security/widgets/components/app_gradient_button.dart';
import 'package:cyber_security/widgets/components/app_text_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppPasswordChangeView extends StatefulWidget {
  const AppPasswordChangeView({super.key});

  @override
  State<AppPasswordChangeView> createState() => _AppPasswordChangeViewState();
}

class _AppPasswordChangeViewState extends State<AppPasswordChangeView> {
  final _databaseService = GetIt.instance<DatabaseService>();
  final _passwordController = TextEditingController();

  late var _password;

  var _step = ChangeStep.initial;

  var _isButtonEnabled = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    _password = _databaseService.get(DatabaseKeys.password);
  }

  bool _validatePassword() => _passwordController.text == _password;

  void _setupNewPass(String password) {
    _databaseService.put(DatabaseKeys.password, password);
    Navigator.of(context).pop();
  }

  void _continue() {
    if (_validatePassword()) {
      _databaseService.delete(DatabaseKeys.password);
      setState(() {
        _password = '';
        _step = ChangeStep.newpass;
        _passwordController.clear()
;      });
    } else {
      showDialog(context: context, builder: (context) =>CupertinoAlertDialog(
            title: Text(
              'Wrong password. Please, try again',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            actions: [
              CupertinoActionSheetAction(
                onPressed: Navigator.of(context).pop,
                child: Text('OK'),
              ),
            ],
          ), );
    }
  }

  void _buttonAction() {
    switch (_step) {
      case ChangeStep.initial:
        _continue();
      case ChangeStep.newpass:
        _setupNewPass(_passwordController.text);
    }
  }

  void _onChanged(String value) => setState(() => _isButtonEnabled = _step == ChangeStep.newpass && _passwordController.text.length >= 5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _step == ChangeStep.initial
                    ? 'Enter your password\nto continue'
                    : 'Enter your new\npassword',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 41),
              AppTextField(
                obscureText: true,
                textController: _passwordController,
                onChanged: _onChanged,
              ),
              SizedBox(height: 41),
              AppGradientButton(
                enabled: _step == ChangeStep.initial || _isButtonEnabled,
                label:    _step == ChangeStep.initial
                    ? 'Continue'
                    : 'Save',
                onPressed: _buttonAction,
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum ChangeStep {
  initial,
  newpass,
}
