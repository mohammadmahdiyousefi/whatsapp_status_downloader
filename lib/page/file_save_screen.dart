import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsapp_status_downloader/bloc/file_storage/file_srorage_bloc.dart';
import 'package:whatsapp_status_downloader/service/manage_file.dart';
import 'package:whatsapp_status_downloader/service/permission/premission.dart';
import 'package:whatsapp_status_downloader/service/toast.dart';
import 'package:whatsapp_status_downloader/service/vthamnail.dart';
import 'package:whatsapp_status_downloader/widget/openfile.dart';
import 'package:whatsapp_status_downloader/widget/share_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SavedFileScreen extends StatelessWidget {
  const SavedFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localText = AppLocalizations.of(context)!;
    return BlocBuilder<FileSrorageBloc, FileSrorageState>(
        builder: (context, state) {
      if (state is FileSrorageData) {
        return GridView.builder(
          itemCount: state.files.length,
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 230,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16),
          itemBuilder: (context, index) {
            final bool isVideo = ["mp4", "mov", "avi", "wmv", "flv"]
                .contains(state.files[index].path.split(".").last);
            if (isVideo) {
              return FutureBuilder(
                future: VideoThumbnail.getThumbnail(state.files[index].path),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 35,
                          ),
                          Text(
                            snapshot.error.toString(),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return GestureDetector(
                      onTap: () async {
                        await openFileInExternalApp(state.files[index].path)
                            .catchError((e) {
                          ToastMessage.showCustomToast(
                              context, e.toString(), Colors.red);
                        });
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: double.infinity,
                            foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black38
                                    ])),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: FileImage(
                                  File(snapshot.data!),
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const Center(
                              child: CircleAvatar(
                            backgroundColor: Colors.white70,
                            child: Icon(Icons.play_arrow),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                DeleteBottun(file: state.files[index]),
                                const Spacer(),
                                ShareButton(path: state.files[index].path),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              );
            } else {
              return GestureDetector(
                onTap: () async {
                  await openFileInExternalApp(state.files[index].path)
                      .catchError((e) {
                    ToastMessage.showCustomToast(
                        context, e.toString(), Colors.red);
                  });
                },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      width: double.infinity,
                      foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black38])),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                            image: FileImage(state.files[index]),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          DeleteBottun(
                            file: state.files[index],
                          ),
                          const Spacer(),
                          ShareButton(path: state.files[index].path),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        );
      } else if (state is FileSrorageLoading) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        );
      } else if (state is FileSrorageError) {
        return Center(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 55,
                ),
                const Gap(8),
                Text(localText.error,
                    style: Theme.of(context).textTheme.titleLarge),
                const Gap(16),
                Text(
                  localText.error1title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.grey),
                ),
                const Gap(8),
                Text(
                  localText.error2title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.grey),
                ),
                const Gap(16),
                Text(
                  localText.accesstitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Gap(8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () async {
                    await AppPremission.storage().then((value) {
                      if (value) {
                        BlocProvider.of<FileSrorageBloc>(context)
                            .add(FileSrorageGetEvent());
                        ToastMessage.showCustomToast(
                            context, localText.accesstoast, Colors.green);
                      } else {
                        ToastMessage.showCustomToast(
                            context, localText.accessfaildtoast, Colors.red);
                      }
                    });
                  },
                  child: Text(
                    localText.accessbutton,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (state is FileSrorageEmpty) {
        return Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.report_problem_outlined,
                  color: Color(0xFFFFCB3B),
                  size: 55,
                ),
                const Gap(8),
                Text(
                  localText.emptyfile,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Theme.of(context).primaryColor),
                  onPressed: () {
                    BlocProvider.of<FileSrorageBloc>(context)
                        .add(FileSrorageGetEvent());
                  },
                  child: Text(
                    localText.refreshbutton,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return Center(
          child: Text(
            localText.unknownerror,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      }
    });
  }
}

class DeleteBottun extends StatelessWidget {
  const DeleteBottun({super.key, required this.file});
  final File file;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await ManageFile.deleteFile(file).then((value) {
          value.fold((error) {
            ToastMessage.showCustomToast(
                context, "مشکلی در حذف تصویر رخ داد ", Colors.red);
          }, (success) {
            ToastMessage.showCustomToast(context, "بامفقیت حذف شد", Colors.red);
            BlocProvider.of<FileSrorageBloc>(context)
                .add(FileSrorageGetEvent());
          });
        });
      },
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: const Color.fromARGB(185, 217, 253, 211),
            borderRadius: BorderRadius.circular(8)),
        child: const Center(
          child: Icon(
            Icons.delete,
            size: 20,
            color: Color(0xff15603e),
          ),
        ),
      ),
    );
  }
}
