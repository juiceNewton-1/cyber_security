import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cyber_security/generated/assets.gen.dart';
import 'package:cyber_security/models/arguments.dart';
import 'package:cyber_security/models/password.dart';
import 'package:cyber_security/routes/route_names.dart';
import 'package:cyber_security/theme/custom_colors.dart';
import 'package:cyber_security/widgets/components/app_drawer.dart';
import 'package:cyber_security/widgets/components/app_gradient_button.dart';
import 'package:cyber_security/widgets/components/app_slidable_action.dart';
import 'package:cyber_security/widgets/components/settings_button.dart';
import 'package:cyber_security/widgets/modules/home/passwords/controllers/passwords_controller.dart';

class PasswordsView extends StatefulWidget {
  const PasswordsView({super.key});

  @override
  State<PasswordsView> createState() => _PasswordsViewState();
}

class _PasswordsViewState extends State<PasswordsView> {
  late final _passwordsController = PasswordsController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState!.openDrawer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Add Password'),
        leading: SettingsButton(
          onPressed: _openDrawer,
        ),
        actions: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Assets.icons.addActive.svg(),
            onPressed: () =>
                Navigator.of(context).pushNamed(RouteNames.changePassword),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: _passwordsController,
        builder: (context, value, child) {
          if (value.passwords.isEmpty) {
            return _EmptyState();
          } else {
            return _NonEmptyState(
              passwords: value.passwords,
              delete: _passwordsController.deletePassword,
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
            label: 'add password',
            onPressed: () =>
                Navigator.of(context).pushNamed(RouteNames.changePassword),
          ),
          SizedBox(height: 58),
          Text(
            'Add password and store your PIN codes\nsecurely',
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
  final List<Password> passwords;
  final void Function(Password) delete;

  const _NonEmptyState({
    required this.passwords,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(left: 16, right: 16, top: 20),
      itemCount: passwords.length,
      separatorBuilder: (context, index) => SizedBox(height: 18),
      itemBuilder: (context, index) => Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: ScrollMotion(),
          children: [
            AppSlidableAction(
              backgroundColor: Theme.of(context).colorScheme.surface,
              label: 'Change',
              onPressed: () => Navigator.of(context).pushNamed(
                RouteNames.changePassword,
                arguments: ChangePasswordViewArguments(
                  password: passwords[index],
                  index: index,
                ),
              ),
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SizedBox(width: 10),
            AppSlidableAction(
              backgroundColor: Theme.of(context).extension<CustomColors>()!.red,
              label: 'Delete',
              onPressed: () => delete(passwords[index]),
            ),
          ],
        ),
        child: _PasswordTIle(
          password: passwords[index],
          onPressed: () => Navigator.of(context).pushNamed(
            RouteNames.changePassword,
            arguments: ChangePasswordViewArguments(
              password: passwords[index],
              index: index,
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordTIle extends StatelessWidget {
  final Password password;
  final VoidCallback onPressed;

  const _PasswordTIle({
    required this.password,
    required this.onPressed,
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
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFC701),
              Color(0xFFFF8E09),
            ],
          ),
        ),
        child: Text(
          password.name,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
