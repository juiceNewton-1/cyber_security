import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:cyber_security/generated/assets.gen.dart';
import 'package:cyber_security/helpers/dialog_helper.dart';
import 'package:cyber_security/main.dart';
import 'package:cyber_security/models/arguments.dart';
import 'package:cyber_security/routes/route_names.dart';
import 'package:cyber_security/services/database/database_service.dart';
import 'package:cyber_security/widgets/modules/agreement_view.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final _databaseService = GetIt.instance<DatabaseService>();
  late var _isDarkTheme;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    _isDarkTheme = _databaseService.isDarkTheme();
  }

  void _switchTheme(bool isDarkTheme) {
    CyberSecurity.of(context).changeTheme(
      isDarkTheme ? ThemeMode.dark : ThemeMode.light,
    );
    setState(() => _isDarkTheme = isDarkTheme);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 40,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Assets.icons.profile.svg(),
                SizedBox(width: 16),
                Text(
                  'Name',
                  style: Theme.of(context).textTheme.displayMedium,
                )
              ],
            ),
            SizedBox(height: 26),
            Divider(
              thickness: 2,
              color: Theme.of(context).colorScheme.surface,
            ),
            SizedBox(height: 14),
            _DrawerTile(
              label: 'Dark mode',
              child: CupertinoSwitch(
                value: _isDarkTheme,
                onChanged: _switchTheme,
              ),
            ),
            SizedBox(height: 14),
            _DrawerTile(
              label: 'Terms of Use',
              onPressed: () => Navigator.of(context).pushNamed(
                RouteNames.agreement,
                arguments: AgreementViewArguments(
                  agreementType: AgreementType.terms,
                ),
              ),
            ),
            SizedBox(height: 14),
            _DrawerTile(
              label: 'Privacy policy',
              onPressed: () => Navigator.of(context).pushNamed(
                RouteNames.agreement,
                arguments: AgreementViewArguments(
                  agreementType: AgreementType.privacy,
                ),
              ),
            ),
            SizedBox(height: 14),
            _DrawerTile(
              label: 'Change code password',
              onPressed: () =>
                  Navigator.of(context).pushNamed(RouteNames.appPasswordChange),
            ),
            SizedBox(height: 14),
            _DrawerTile(
              label: 'Rate us',
              onPressed: () => showDialog(
                context: context,
                builder: (context) => RateDialog(),
              ),
            ),
            SizedBox(height: 14),
            _DrawerTile(
              label: 'Contact Developers',
              onPressed: () =>
                  Navigator.of(context).pushNamed(RouteNames.contactDevelopers),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Widget? child;
  const _DrawerTile({
    required this.label,
    this.child,
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
            label,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Spacer(),
          child ?? Assets.icons.chevronRigth.svg()
        ],
      ),
    );
  }
}
