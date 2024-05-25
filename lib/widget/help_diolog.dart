import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> helpDiolog(BuildContext context) async {
  final localText = AppLocalizations.of(context)!;
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            localText.helpdiolog,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(localText.helpdiolog1,
                  style: Theme.of(context).textTheme.titleMedium),
              const Gap(8),
              Text(localText.helpdiolog2,
                  style: Theme.of(context).textTheme.titleMedium),
              const Gap(8),
              Text(localText.helpdiolog3,
                  style: Theme.of(context).textTheme.titleMedium),
              const Gap(8),
              Text(localText.helpdiolog4,
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool("helpdiolog", true);
                },
                child: Text(localText.underastandbutton,
                    style: Theme.of(context)
                        .appBarTheme
                        .titleTextStyle!
                        .copyWith(fontSize: 16)))
          ],
        );
      });
}
