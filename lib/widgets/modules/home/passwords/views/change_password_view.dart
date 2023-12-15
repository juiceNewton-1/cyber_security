import 'package:flutter/material.dart';
import 'package:cyber_security/models/arguments.dart';
import 'package:cyber_security/models/password.dart';
import 'package:cyber_security/widgets/components/app_drawer.dart';
import 'package:cyber_security/widgets/components/app_gradient_button.dart';
import 'package:cyber_security/widgets/components/app_text_filed.dart';
import 'package:cyber_security/widgets/components/settings_button.dart';
import 'package:cyber_security/widgets/modules/home/passwords/controllers/change_password_controller.dart';

class ChangePasswordView extends StatefulWidget {
  final ChangePasswordViewArguments? arguments;
  const ChangePasswordView({super.key, this.arguments});

  factory ChangePasswordView.create(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments
        as ChangePasswordViewArguments?;
    return ChangePasswordView(arguments: arguments);
  }

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _nameController = TextEditingController();
  final _loginController = TextEditingController();
  final _sourceController = TextEditingController();
  final _passwordController = TextEditingController();

  final _changePasswordController = ChangePasswordController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ChangePasswordViewArguments? get _arguments => widget.arguments;

  String get _appBarTitle =>
      _arguments != null ? 'Change Password' : 'Add Password';

  late bool _isButtonEnabled;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    if (_arguments != null) {
      _nameController.text = _arguments!.password.name;
      _loginController.text = _arguments!.password.login;
      _sourceController.text = _arguments!.password.source;
      _passwordController.text = _arguments!.password.password;
      _isButtonEnabled = true;
    } else {
      _isButtonEnabled = false;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _loginController.dispose();
    _sourceController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onChanged(String value) => setState(
        () => _isButtonEnabled = _nameController.text.isNotEmpty &&
            _sourceController.text.isNotEmpty &&
            _loginController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty,
      );

  void _install() {
    final password = Password(
      name: _nameController.text,
      source: _sourceController.text,
      login: _loginController.text,
      password: _passwordController.text,
    );
    if (_arguments == null) {
      _changePasswordController.addPassword(password);
    } else {
      _changePasswordController.updatePassword(
        password,
        _arguments!.index,
      );
    }
    Navigator.of(context).pop();
  }

  void _openDrawer() => _scaffoldKey.currentState!.openDrawer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        leading: SettingsButton(
          onPressed: _openDrawer,
        ),
        title: Text(_appBarTitle),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 30,
        ),
        child: Column(
          children: [
            AppTextField(
              textController: _nameController,
              placeholder: 'Name',
              onChanged: _onChanged,
            ),
            SizedBox(height: 17),
            AppTextField(
              textController: _sourceController,
              onChanged: _onChanged,
              placeholder: 'Source from which accesses',
            ),
            SizedBox(height: 17),
            AppTextField(
              textController: _loginController,
              onChanged: _onChanged,
              placeholder: 'Login',
            ),
            SizedBox(height: 17),
            AppTextField(
              textController: _passwordController,
              onChanged: _onChanged,
              placeholder: 'Password',
            ),
            SizedBox(height: 22),
            AppGradientButton(
              label: 'install',
              enabled: _isButtonEnabled,
              onPressed: _install,
            )
          ],
        ),
      ),
    );
  }
}
