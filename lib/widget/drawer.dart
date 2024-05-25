import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_status_downloader/bloc/theme/theme_bloc.dart';
import 'package:whatsapp_status_downloader/bloc/theme/theme_event.dart';
import 'package:whatsapp_status_downloader/bloc/theme/theme_state.dart';
import 'package:whatsapp_status_downloader/page/about_us.dart';
import 'package:whatsapp_status_downloader/page/change_language.dart';
import 'package:whatsapp_status_downloader/page/terms_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final localText = AppLocalizations.of(context)!;
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset("assets/images/app_icon/app_logo.png",
                      height: 170, width: 170, fit: BoxFit.fill),
                ),
                FutureBuilder(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        "${snapshot.data!.appName}  ${snapshot.data!.version}",
                        style: const TextStyle(color: Colors.white),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    BlocBuilder<ThemeBloc, ThemeState>(
                      builder: (context, state) {
                        return ListTile(
                            leading: const Icon(Icons.dark_mode),
                            title: Text(localText.darkmode),
                            onTap: () {
                              if (state.mode == ThemeMode.dark) {
                                BlocProvider.of<ThemeBloc>(context)
                                    .add(LightThemeEvent());
                              } else {
                                BlocProvider.of<ThemeBloc>(context)
                                    .add(DarkThemeEvent());
                              }
                            },
                            trailing: Switch(
                              value: state.mode == ThemeMode.dark,
                              onChanged: (value) {
                                if (state.mode == ThemeMode.dark) {
                                  BlocProvider.of<ThemeBloc>(context)
                                      .add(LightThemeEvent());
                                } else {
                                  BlocProvider.of<ThemeBloc>(context)
                                      .add(DarkThemeEvent());
                                }
                              },
                              activeColor: Theme.of(context).primaryColor,
                            ));
                      },
                    ),
                    const Gap(6),
                    ListTile(
                      leading: const Icon(Icons.star),
                      title: Text(
                        localText.rateapp,
                      ),
                      onTap: () async {
                        const String url =
                            "bazaar://details?id=com.example.calculator_pro_aseman";
                        await canLaunchUrl(Uri.parse(url)).then((value) async {
                          if (value) {
                            await launchUrl(Uri.parse(url));
                          } else {
                            await launchUrl(Uri.parse(url),
                                mode: LaunchMode.externalApplication);
                          }
                        });
                      },
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                    const Gap(6),
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: Text(localText.appLanguage),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const ChangeLanguageScreen();
                          },
                        ));
                      },
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                    const Gap(6),
                    ListTile(
                      leading: const Icon(Icons.share),
                      title: Text(localText.share),
                      onTap: () {
                        Share.shareUri(Uri.parse(
                            "https://cafebazaar.ir/app/com.whatsapp_status_downloader_downloader"));
                      },
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                    const Gap(6),
                    ListTile(
                      leading: const Icon(Icons.balance),
                      title: Text(localText.termsandConditions),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const TermsAndConditionScreen();
                          },
                        ));
                      },
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                    const Gap(6),
                    ListTile(
                      leading: const Icon(Icons.groups_3),
                      title: Text(localText.contactUs),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const ContactUsScreen();
                          },
                        ));
                      },
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                    const Gap(6),
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: Text(localText.about),
                      onTap: () {},
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
