import 'package:cyber_security/generated/assets.gen.dart';
import 'package:cyber_security/routes/route_names.dart';
import 'package:cyber_security/widgets/components/app_gradient_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:in_app_review/in_app_review.dart';

class DialogHelper {
  static var showingDialog = false;

  static Future<void> showNoInternetDialog(BuildContext context) async {
    if (!showingDialog) {
      showingDialog = true;
      await showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text(
              'You have lost your internet connection. Please check your settings and try again.'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                showingDialog = false;
                Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteNames.splash,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      );
    }
  }

  static Future<void> showCheckoutDialog(BuildContext context) async {
    if (!showingDialog) {
      showingDialog = true;
      await showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Order placed!'),
          content: const Text('Please await for our call.'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                'Ok',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.black,
                    ),
              ),
              onPressed: () {
                showingDialog = false;
                Navigator.of(context).popUntil(
                  (route) => route.settings.name == RouteNames.home,
                );
              },
            ),
          ],
        ),
      );
    }
  }
}

class RateDialog extends StatefulWidget {
  const RateDialog({super.key});

  @override
  State<RateDialog> createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  var _currentRate = 5;

  Future<void> _rate() async {
    await InAppReview.instance.openStoreListing(appStoreId: '6474267105');
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  void _updateRating(double rating) =>
      setState(() => _currentRate = rating.toInt());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 13, right: 13, top: 13, bottom: 53),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Assets.icons.close.svg(),
                  onPressed: Navigator.of(context).pop,
                ),
              ],
            ),
            SizedBox(height: 27),
            Text('Please rate us 5 stars on\nthe application website',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall),
            SizedBox(height: 28),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 58,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFF535353),
              ),
              child: RatingBar.builder(
                maxRating: 5,
                unratedColor: Theme.of(context).colorScheme.surface,
                updateOnDrag: true,
                initialRating: _currentRate.toDouble(),
                itemSize: 45,
                minRating: 1,
                itemBuilder: (context, index) => Icon(
                  Icons.star_rate_rounded,
                  color: Color(0xFFFFC701),
                ),
                onRatingUpdate: _updateRating,
              ),
            ),
            SizedBox(height: 34),
            AppGradientButton(
              label: '$_currentRate stars',
              width: 150,
              onPressed: _rate,
            )
          ],
        ),
      ),
    );
  }
}
