import 'package:flutter/material.dart';
import 'package:notes/app/settings/router.dart';
import 'package:notes/app/settings/theme.dart';
import 'package:easy_localization/easy_localization.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      routerConfig: router,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.noScaling,
        ),
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
