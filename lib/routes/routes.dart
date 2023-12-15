import 'package:flutter/material.dart';
import 'package:cyber_security/routes/route_names.dart';
import 'package:cyber_security/widgets/modules/agreement_view.dart';
import 'package:cyber_security/widgets/modules/code_password_view.dart';
import 'package:cyber_security/widgets/modules/contact_developers_view.dart';
import 'package:cyber_security/widgets/modules/home/articles/views/article_view.dart';
import 'package:cyber_security/widgets/modules/home/cards/views/add_card_view.dart';
import 'package:cyber_security/widgets/modules/home/cards/views/card_sort_view.dart';
import 'package:cyber_security/widgets/modules/home/home_view.dart';
import 'package:cyber_security/widgets/modules/home/passwords/views/change_password_view.dart';
import 'package:cyber_security/widgets/modules/onboarding_view.dart';
import 'package:cyber_security/widgets/modules/password_creation_view.dart';
import 'package:cyber_security/widgets/modules/privacy_view.dart';
import 'package:cyber_security/widgets/modules/splash_view.dart';

typedef AppRoute = Widget Function(BuildContext context);

class AppRoutes {
  static Map<String, AppRoute> get(BuildContext context) => {
        RouteNames.splash: (context) => const SplashView(),
        RouteNames.onboarding: (context) => const OnboardingView(),
        RouteNames.passwordCreation: (context) => const PasswordCreationView(),
        RouteNames.home: (context) => HomeView(),
        RouteNames.agreement: (context) => AgreementView.create(context),
        RouteNames.contactDevelopers: (context) =>
            const ContactDelevopersView(),
        RouteNames.article: (context) => ArticleView.ceate(context),
        RouteNames.changePassword: (context) =>
            ChangePasswordView.create(context),
        RouteNames.addCard: (context) => AddCardView.create(context),
        RouteNames.cardSort: (context) => CardSortView.create(context),
        RouteNames.privacy: (context) => const PrivacyView(),
        RouteNames.codePassword: (context) => const CodePasswordView(),
      };
}
