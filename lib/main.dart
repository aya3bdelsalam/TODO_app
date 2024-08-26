import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/application_theme_manager.dart';
import 'package:todo_app/core/page_route_names.dart';
import 'package:todo_app/core/routes_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/core/services/loading_service.dart';
import 'core/settings_provider.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// crud write read update delete

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => SettingsProvider(), child: const MyApp()));
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
        title: 'To Do App',
        debugShowCheckedModeBanner: false,
        themeMode: provider.currentTheme,
        theme: ApplicationThemeManager.lightThemeData,
        darkTheme: ApplicationThemeManager.darkThemeData,
        initialRoute: PageRouteNames.initial,
        onGenerateRoute: RouteGenerator.onGenerateRoute,
        builder: EasyLoading.init(
          builder: BotToastInit(),
        ),
        locale: Locale(provider.currentLanguage),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales);
  }
}
