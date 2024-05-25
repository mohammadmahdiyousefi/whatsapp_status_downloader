import 'dart:io';
import 'package:adivery/adivery.dart';
import 'package:adivery/adivery_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_status_downloader/ads_widget/banner_ads.dart';
import 'package:whatsapp_status_downloader/ads_widget/prepare_interstitial_ad.dart';
import 'package:whatsapp_status_downloader/bloc/file_storage/file_srorage_bloc.dart';
import 'package:whatsapp_status_downloader/bloc/image_status/whatsapp_image_status_bloc.dart';
import 'package:whatsapp_status_downloader/bloc/theme/theme_bloc.dart';
import 'package:whatsapp_status_downloader/bloc/theme/theme_state.dart';
import 'package:whatsapp_status_downloader/bloc/video_status/whatsapp_video_staus_bloc.dart';
import 'package:whatsapp_status_downloader/di/di.dart';
import 'package:whatsapp_status_downloader/page/file_save_screen.dart';
import 'package:whatsapp_status_downloader/page/image_list_screen.dart';
import 'package:whatsapp_status_downloader/page/video_list_screen.dart';
import 'package:whatsapp_status_downloader/service/get_directory_path.dart';
import 'package:whatsapp_status_downloader/service/permission/premission.dart';
import 'package:whatsapp_status_downloader/widget/drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:whatsapp_status_downloader/widget/help_diolog.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int index = 0;
  List<Widget> screens = [
    BlocProvider(
      create: (context) {
        var bloc = WhatsappImageStatusBloc();
        bloc.add(WhatsappImageStatusGet());
        return bloc;
      },
      child: const ImageListScreen(),
    ),
    BlocProvider(
      create: (context) {
        var bloc = WhatsappVideoStausBloc();
        bloc.add(WhatsappVideoStatusGet());
        return bloc;
      },
      child: const VideoListScreen(),
    ),
    BlocProvider(
      create: (context) {
        var bloc = locator.get<FileSrorageBloc>();
        bloc.add(FileSrorageGetEvent());
        return bloc;
      },
      child: const SavedFileScreen(),
    ),
  ];
  @override
  void initState() {
    premission();
    createDirectory();
    openHelpDiolog();
    AdiveryPlugin.prepareInterstitialAd('0443d026-503a-4165-b951-20026be36cab');
    super.initState();
  }

  Future<void> createDirectory() async {
    final directoryPath = await getDirectoryPath();
    final directory = Directory(directoryPath);
    if (!await directory.exists()) {
      await directory.create();
    }
  }

  void openHelpDiolog() async {
    await SharedPreferences.getInstance().then((value) {
      final bool diolog = value.getBool("helpdiolog") ?? false;
      if (!diolog) {
        helpDiolog(context);
      }
    });
  }

  Future<String> getDirectoryPath() async {
    final appDirectory = await PathDirectory.getSaveFileDirectoryPath();
    return appDirectory;
  }

  void premission() async {
    await AppPremission.storage().then((value) {
      if (value) {
        // ToastMessage.showCustomToast(
        //     context, "دسترسی به حافظه با موفقیت داده شد", Colors.green);
      } else {
        // ToastMessage.showCustomToast(
        //     context, "خطا, در دسترسی به حافظه مجوز داده نشده است", Colors.red);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(state.mode == ThemeMode.light
                ? "assets/images/light_bg.jpg"
                : "assets/images/dark_bg.jpg"),
          )),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              drawerEnableOpenDragGesture: false,
              appBar: AppBar(
                scrolledUnderElevation: 0,
                title: Text(AppLocalizations.of(context)!.homeAppBar,
                    style: Theme.of(context).appBarTheme.titleTextStyle),
                actions: [
                  IconButton(
                      onPressed: () async {
                        await helpDiolog(context);
                      },
                      icon: const Icon(Icons.info_outline))
                ],
              ),
              drawer: const DrawerCustom(),
              bottomNavigationBar: _bottomNavigationBar(),
              body: Column(
                children: [
                  Expanded(
                    child: IndexedStack(
                      index: index,
                      children: screens,
                    ),
                  ),
                  const Gap(8),
                  creatabannerad(BannerAdSize.BANNER) ?? const SizedBox()
                ],
              )),
        );
      },
    );
  }

  Widget _bottomNavigationBar() {
    final localText = AppLocalizations.of(context)!;
    return SizedBox(
      height: 70,
      child: NavigationBar(
        backgroundColor: Theme.of(context).navigationBarTheme.backgroundColor,
        indicatorColor: Theme.of(context).navigationBarTheme.indicatorColor,
        selectedIndex: index,
        onDestinationSelected: (value) {
          index = value;
          setState(() {});
          if (index == 2) {
            showInterstitial();
          }
        },
        destinations: [
          NavigationDestination(
              icon: Icon(
                Icons.photo,
                color: Theme.of(context).iconTheme.color,
              ),
              selectedIcon: const Icon(
                Icons.photo,
              ),
              label: localText.images),
          NavigationDestination(
              icon: Icon(
                Icons.video_collection,
                color: Theme.of(context).iconTheme.color,
              ),
              selectedIcon: const Icon(
                Icons.video_collection,
              ),
              label: localText.video),
          NavigationDestination(
              icon: Icon(
                Icons.bookmark,
                color: Theme.of(context).iconTheme.color,
              ),
              selectedIcon: const Icon(
                Icons.bookmark,
              ),
              label: localText.saved)
        ],
      ),
    );
  }
}
