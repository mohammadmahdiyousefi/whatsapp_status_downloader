import 'package:adivery/adivery_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:whatsapp_status_downloader/ads_widget/banner_ads.dart';
import 'package:whatsapp_status_downloader/bloc/theme/theme_bloc.dart';
import 'package:whatsapp_status_downloader/bloc/theme/theme_event.dart';
import 'package:whatsapp_status_downloader/bloc/theme/theme_state.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localText = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).iconTheme.color),
        ),
        title: Text(
          localText.appLanguage,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    BlocProvider.of<ThemeBloc>(context).add(SetLanguage("en"));
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  tileColor: state.appLanguage == "en"
                      ? Theme.of(context).primaryColor.withOpacity(0.3)
                      : null,
                  leading: const Icon(Icons.language),
                  title: const Text("English"),
                ),
                const Gap(8),
                ListTile(
                  onTap: () {
                    BlocProvider.of<ThemeBloc>(context).add(SetLanguage("fa"));
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  tileColor: state.appLanguage == "fa"
                      ? Theme.of(context).primaryColor.withOpacity(0.3)
                      : null,
                  leading: const Icon(Icons.language),
                  title: const Text("فارسی"),
                ),
                const Gap(32),
                creatabannerad(BannerAdSize.MEDIUM_RECTANGLE) ??
                    const SizedBox()
              ],
            ),
          );
        },
      ),
    );
  }
}
