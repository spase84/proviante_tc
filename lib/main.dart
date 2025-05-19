import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes/app.dart';
import 'package:notes/app/components/runner_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notes/app/di/injector.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await Injector.setup();
    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('ru', 'RU')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ru', 'RU'),
        startLocale: const Locale('ru', 'RU'),
        child: const App(),
      ),
    );
  }, (error, stack) {
    runnerHelper.onZoneError(error, stack);
  });
}
