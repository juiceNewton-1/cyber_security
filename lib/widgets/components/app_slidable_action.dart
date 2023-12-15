import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:flutter/material.dart';

class AppSlidableAction extends StatelessWidget {
  final Color backgroundColor;
  final String label;
  final VoidCallback? onPressed;
  const AppSlidableAction({
    super.key,
    required this.backgroundColor,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        alignment: Alignment.center,
        width: 82,
        height: 62,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: backgroundColor,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
