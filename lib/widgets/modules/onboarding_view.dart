import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:cyber_security/routes/route_names.dart';
import 'package:cyber_security/services/database/database_keys.dart';
import 'package:cyber_security/services/database/database_service.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final _databaseService = GetIt.instance<DatabaseService>();
  var _currentIndex = 0;

  @override
  void initState() {
    _init();
    super.initState();
  }

  String _getOnboardingText() {
    switch (_currentIndex) {
      case 0:
        return 'save and group cards';
      case 1:
        return "keep your\npasswords\nso you don't\nforget them";
      case 2:
        return 'check the\ncomplexity of\nyour password';
      case 3:
        return 'read news on\nhow to protect\nyourself on the\nInternet';
      default:
        return '';
    }
  }

  void _progress() {
    if (_currentIndex == 3) {
      Navigator.of(context).pushReplacementNamed(RouteNames.passwordCreation);
    } else {
      setState(() => _currentIndex++);
    }
  }

  void _init() {
    _databaseService.put(DatabaseKeys.seenOnboarding, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _progress,
        child: Container(
          alignment: Alignment(0, 0.5),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset(
                'assets/images/onboarding_${_currentIndex + 1}.png',
              ).image,
              fit: BoxFit.cover,
            ),
          ),
          child: Text(
            _getOnboardingText().toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ),
    );
  }
}
