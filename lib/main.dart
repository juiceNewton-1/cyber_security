import 'dart:developer';
import 'package:cyber_security/firebase_options.dart';
import 'package:cyber_security/routes/routes.dart';
import 'package:cyber_security/services/database/database_service.dart';
import 'package:cyber_security/services/database/entities/theme_mode_entity.dart';
import 'package:cyber_security/services/service_locator.dart';
import 'package:cyber_security/theme/dark_theme.dart';
import 'package:cyber_security/theme/ligth_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await _initApp();
  runApp(const CyberSecurity());
}

Future<void> _initApp() async {
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  } on Exception catch (e) {
    log("Failed to initialize Firebase: $e");
  }

  await ServiceLocator.setup();
}

class CyberSecurity extends StatefulWidget {
  const CyberSecurity({super.key});

  @override
  State<CyberSecurity> createState() => _CyberSecurityState();

  static _CyberSecurityState of(BuildContext context) =>
      context.findAncestorStateOfType<_CyberSecurityState>()!;
}

class _CyberSecurityState extends State<CyberSecurity> {
  final _databaseService = GetIt.instance<DatabaseService>();
  late ThemeMode _themeMode;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void changeTheme(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        _databaseService.updateTheme(ThemeModeEntity.ligth);
      case ThemeMode.dark:
        _databaseService.updateTheme(ThemeModeEntity.dark);
      case ThemeMode.system:
        return;
    }
    setState(() {
      _themeMode = themeMode;
    });
  }

  void _init() {
    final isDarkTheme = _databaseService.isDarkTheme();
    if (isDarkTheme) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Storage Pin-up-card Information",
      theme: LigthTheme.get,
      darkTheme: DarkTheme.get,
      themeMode: _themeMode,
      routes: AppRoutes.get(context),
      debugShowCheckedModeBanner: false,
    );
  }
}
