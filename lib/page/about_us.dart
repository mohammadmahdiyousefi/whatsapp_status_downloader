import 'package:adivery/adivery_ads.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:whatsapp_status_downloader/ads_widget/banner_ads.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});
  final String email = "mailto:mmye1481@gmail.com";
  final String telegram = "https://t.me/Hamsafar_Translatorbot";
  final String github = "https://github.com/mohammadmahdiyousefi";
  Future<void> _launchUrl(String url) async {
    await canLaunchUrl(Uri.parse(url)).then((value) async {
      if (value) {
        await launchUrl(Uri.parse(url));
      } else {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    });
  }

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
          localText.contactUs,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(16),
              ListTile(
                onTap: () async {
                  await _launchUrl(email);
                },
                leading: const Icon(Icons.email),
                title: Text(localText.emailText,
                    style: Theme.of(context).listTileTheme.titleTextStyle),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              const Gap(16),
              ListTile(
                onTap: () async {
                  await _launchUrl(telegram);
                },
                leading: const Icon(Icons.near_me),
                title: Text(localText.telegramText,
                    style: Theme.of(context).listTileTheme.titleTextStyle),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              const Gap(16),
              ListTile(
                onTap: () async {
                  await _launchUrl(github);
                },
                leading: const Icon(Icons.g_mobiledata),
                title: Text(localText.githubText,
                    style: Theme.of(context).listTileTheme.titleTextStyle),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              const Gap(32),
              creatabannerad(BannerAdSize.MEDIUM_RECTANGLE) ?? const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
