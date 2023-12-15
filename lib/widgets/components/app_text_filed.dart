import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final void Function(String)? onChanged;
  final String? placeholder;
  final TextEditingController textController;
  final bool obscureText;
  const AppTextField({
    super.key,
    this.onChanged,
    required this.textController,
    this.placeholder,
    this.obscureText = false
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      obscureText: obscureText,
      placeholder: placeholder,
      placeholderStyle: Theme.of(context)
          .textTheme
          .displaySmall!
          .copyWith(color: Theme.of(context).colorScheme.onSecondary),
      onChanged: onChanged,
      padding: EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 21,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(14),
      ),
      controller: textController,
    );
  }
}
