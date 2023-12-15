import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cyber_security/generated/assets.gen.dart';


class CodePasswordView extends StatefulWidget {
  const CodePasswordView({super.key});

  @override
  State<CodePasswordView> createState() => _CodePasswordViewState();
}

class _CodePasswordViewState extends State<CodePasswordView> {
  void _deleteCodePassword() {}

  void _changeCodePassword() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CupertinoButton(
          child: Assets.icons.close.svg(),
          onPressed: Navigator.of(context).pop,
          padding: EdgeInsets.zero,
        ),
        title: Text(
          'Code Password',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Code password to enter the application',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SizedBox(height: 18),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: _GradientText(
                'Change code password',
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFC701),
                    Color(0xFFFF8E09),
                  ],
                ),
              ),
              onPressed: _changeCodePassword,
            ),
            SizedBox(height: 10),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: _GradientText(
                'Delete code password',
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFC701),
                    Color(0xFFFF8E09),
                  ],
                ),
              ),
              onPressed: _deleteCodePassword,
            ),
            SizedBox(height: 41),
          ],
        ),
      ),
    );
  }
}

class _GradientText extends StatelessWidget {
  const _GradientText(
    this.text, {
    required this.gradient,
  });

  final String text;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: Theme.of(context).textTheme.displaySmall),
    );
  }
}
