import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:cyber_security/routes/route_names.dart';
import 'package:cyber_security/services/database/database_keys.dart';
import 'package:cyber_security/services/database/database_service.dart';
import 'package:cyber_security/widgets/components/app_gradient_button.dart';
import 'package:cyber_security/widgets/components/app_text_filed.dart';

class PasswordCreationView extends StatefulWidget {
  const PasswordCreationView({super.key});

  @override
  State<PasswordCreationView> createState() => _PasswordCreationViewState();
}

class _PasswordCreationViewState extends State<PasswordCreationView> {
  final _passwordController = TextEditingController();
  final _databaseService = GetIt.instance<DatabaseService>();

  var _isButtonEnabled = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onPasswordChange(String password) {
    if (password.isNotEmpty) {
      if (_isButtonEnabled) return;
      setState(() => _isButtonEnabled = true);
    } else {
      setState(() => _isButtonEnabled = false);
    }
  }

  void _continue() {
    _databaseService.put(DatabaseKeys.password, _passwordController.text);
    Navigator.of(context).pushReplacementNamed(RouteNames.home);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'To enter the application,\nplease create a password\nor set up a face ID',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 41),
              AppTextField(
                obscureText: true,
                textController: _passwordController,
                onChanged: _onPasswordChange,
              ),
              SizedBox(height: 41),
              AppGradientButton(
                label: 'continue',
                onPressed: _continue,
                enabled: _isButtonEnabled,
              )
            ],
          ),
        ),
      ),
    );
  }
}
