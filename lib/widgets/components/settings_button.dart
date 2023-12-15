import 'package:flutter/cupertino.dart';
import 'package:cyber_security/generated/assets.gen.dart';

class SettingsButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const SettingsButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Assets.icons.settings.svg(),
      onPressed: onPressed,
    );
  }
}
