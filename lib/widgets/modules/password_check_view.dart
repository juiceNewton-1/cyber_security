import 'package:cyber_security/routes/route_names.dart';
import 'package:cyber_security/services/database/database_keys.dart';
import 'package:cyber_security/services/database/database_service.dart';
import 'package:cyber_security/widgets/components/app_gradient_button.dart';
import 'package:cyber_security/widgets/components/app_text_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PasswordCheckView extends StatefulWidget {
  const PasswordCheckView({super.key});

  @override
  State<PasswordCheckView> createState() => _PasswordCheckViewState();
}

class _PasswordCheckViewState extends State<PasswordCheckView> {
  final _databaseService = GetIt.instance<DatabaseService>();
  final _passwordController = TextEditingController();

  late var _password;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    _password = _databaseService.get(DatabaseKeys.password);
  }

  bool _validatePassword() => _passwordController.text == _password;

  void _continue() {
    if (_validatePassword()) {
      Navigator.of(context).pushReplacementNamed(RouteNames.home);
    } else {
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
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
        ),
      );
    }
  }

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
                'Enter your password\nto continue',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 41),
              AppTextField(
                obscureText: true,
                textController: _passwordController,
              ),
              SizedBox(height: 41),
              AppGradientButton(
                label: "Continue",
                onPressed: _continue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
