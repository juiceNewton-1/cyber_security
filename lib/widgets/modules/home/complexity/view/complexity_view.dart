import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cyber_security/generated/assets.gen.dart';
import 'package:cyber_security/theme/custom_colors.dart';
import 'package:cyber_security/widgets/components/app_drawer.dart';
import 'package:cyber_security/widgets/components/app_text_filed.dart';
import 'package:password_strength/password_strength.dart';
import 'package:cyber_security/widgets/components/settings_button.dart';

class ComplexityView extends StatefulWidget {
  const ComplexityView({super.key});

  @override
  State<ComplexityView> createState() => _ComplexityViewState();
}

class _ComplexityViewState extends State<ComplexityView> {
  final _passwordController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _complexity = 0.0;

  bool get _passwordIsNotEmpty => _passwordController.text.isNotEmpty;

  void _handlePasswordComplexity(String password) {
    final complexity = estimatePasswordStrength(password);
    setState(() => _complexity = complexity);
  }

  Color _getComplexityColor() {
    if (_complexity < 0.3) {
      return Theme.of(context).extension<CustomColors>()!.red;
    } else if (_complexity > 0.3 && _complexity < 0.7) {
      return Theme.of(context).extension<CustomColors>()!.yellow;
    } else {
      return Theme.of(context).extension<CustomColors>()!.green;
    }
  }

  String _getComplexityDescription() {
    if (_complexity < 0.3) {
      return 'The password is too weak';
    } else if (_complexity > 0.3 && _complexity < 0.7) {
      return 'Average password, add symbols;&₽@~';
    } else {
      return 'Strong password';
    }
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
        actions: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Assets.icons.addActive.svg(),
            onPressed: () {},
          ),
          SizedBox(width: 10)
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Checking password complexity',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            SizedBox(height: 75),
            Text(
              'Create password',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SizedBox(height: 32),
            AppTextField(
              textController: _passwordController,
              onChanged: _handlePasswordComplexity,
            ),
            SizedBox(height: 54),
            Divider(
                thickness: 2,
                color: _passwordIsNotEmpty ? _getComplexityColor() : null),
            SizedBox(
              height: 15,
            ),
            Text(
              _passwordIsNotEmpty ? _getComplexityDescription() : '',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: _getComplexityColor()),
            ),
          ],
        ),
      ),
    );
  }
}
