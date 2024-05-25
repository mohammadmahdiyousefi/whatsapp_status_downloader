import 'package:adivery/adivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:whatsapp_status_downloader/bloc/theme/theme_bloc.dart';
import 'package:whatsapp_status_downloader/bloc/theme/theme_event.dart';
import 'package:whatsapp_status_downloader/bloc/theme/theme_state.dart';
import 'package:whatsapp_status_downloader/di/di.dart';
import 'package:whatsapp_status_downloader/home.dart';
import 'package:whatsapp_status_downloader/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AdiveryPlugin.initialize('46b0ea74-b915-401c-af42-078816861018');
  getItInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = ThemeBloc();
        bloc.add(InitThemeEvent());
        return bloc;
      },
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeAnimationDuration: Duration.zero,
            theme: AppTheme.lighttheme,
            darkTheme: AppTheme.darktheme,
            themeMode: state.mode,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            locale: Locale(state.appLanguage),
            supportedLocales: const [
              Locale("fa"),
              Locale("en"),
            ],
            home: const Homepage(),
          );
        },
      ),
    );
  }
}
