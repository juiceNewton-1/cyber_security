import 'package:cyber_security/helpers/email_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cyber_security/generated/assets.gen.dart';
import 'package:cyber_security/widgets/components/app_gradient_button.dart';
import 'package:cyber_security/widgets/components/app_text_filed.dart';

class ContactDelevopersView extends StatefulWidget {
  const ContactDelevopersView({super.key});

  @override
  State<ContactDelevopersView> createState() => _ContactDelevopersViewState();
}

class _ContactDelevopersViewState extends State<ContactDelevopersView> {
  final _messageSubjectController = TextEditingController();
  final _messageController = TextEditingController();

  var _isButtonEnabled = false;

  @override
  void dispose() {
    _messageSubjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _onChanged(String value) =>
      setState(() => _isButtonEnabled = _messageController.text.isNotEmpty &&
          _messageSubjectController.text.isNotEmpty);

  Future<void> _send() async => await EmailHelper.launchEmailSubmission(
        toEmail: 'phamninhhoang697@gmail.com',
        subject: _messageSubjectController.text,
        body: _messageController.text,
        errorCallback: () => showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            content: Text(
              'Some error has occured. Please\ntry again.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            actions: [
              CupertinoActionSheetAction(
                onPressed: Navigator.of(context).pop,
                child: Text('OK'),
              ),
            ],
          ),
        ),
        doneCallback: Navigator.of(context).pop,
      );

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
          'Contact Developers',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 33),
            AppTextField(
              textController: _messageSubjectController,
              onChanged: _onChanged,
              placeholder: 'Message subject',
            ),
            SizedBox(height: 30),
            AppTextField(
              textController: _messageController,
              onChanged: _onChanged,
              placeholder: 'Message',
            ),
            SizedBox(height: 65),
            AppGradientButton(
              label: 'Send',
              enabled: _isButtonEnabled,
              onPressed: _send,
            )
          ],
        ),
      ),
    );
  }
}
