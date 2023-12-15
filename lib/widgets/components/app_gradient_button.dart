import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cyber_security/theme/custom_colors.dart';

class AppGradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool enabled;
  final String label;
  final Widget? icon;
  final double heigth;
  final double width;
  const AppGradientButton({
    super.key,
    this.onPressed,
    required this.label,
    this.icon,
    this.width = 246,
    this.heigth = 56,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        width: width,
        height: heigth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(38),
          color: !enabled
              ? Theme.of(context).extension<CustomColors>()!.disabled
              : null,
          gradient: enabled
              ? LinearGradient(
                  colors: [
                    Color(0xFFFFC701),
                    Color(0xFFFF8E09),
                  ],
                )
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 11),
            ],
            Text(
              label.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            )
          ],
        ),
      ),
      onPressed: enabled ? onPressed : null,
    );
  }
}
