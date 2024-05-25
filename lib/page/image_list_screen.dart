import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsapp_status_downloader/bloc/file_storage/file_srorage_bloc.dart';
import 'package:whatsapp_status_downloader/bloc/image_status/whatsapp_image_status_bloc.dart';
import 'package:whatsapp_status_downloader/di/di.dart';
import 'package:whatsapp_status_downloader/service/permission/premission.dart';
import 'package:whatsapp_status_downloader/service/toast.dart';
import 'package:whatsapp_status_downloader/widget/openfile.dart';
import 'package:whatsapp_status_downloader/widget/save_button.dart';
import 'package:whatsapp_status_downloader/widget/share_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImageListScreen extends StatelessWidget {
  const ImageListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localText = AppLocalizations.of(context)!;
    return BlocBuilder<WhatsappImageStatusBloc, WhatsappImageStatusState>(
      builder: (context, state) {
        if (state is WhatsappImageStatusLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        } else if (state is WhatsappImageStatusData) {
          return RefreshIndicator(
            color: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            onRefresh: () async {
              BlocProvider.of<WhatsappImageStatusBloc>(context)
                  .add(WhatsappImageStatusGet());
            },
            child: GridView.builder(
              itemCount: state.images.length,
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 230,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await openFileInExternalApp(state.images[index].path)
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
                              image: FileImage(state.images[index]),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            BlocProvider.value(
                              value: locator.get<FileSrorageBloc>(),
                              child: SaveButton(file: state.images[index]),
                            ),
                            const Spacer(),
                            ShareButton(path: state.images[index].path),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is WhatsappImageStatusEmpty) {
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
                    localText.emptyimage,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () {
                      BlocProvider.of<WhatsappImageStatusBloc>(context)
                          .add(WhatsappImageStatusGet());
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
        } else if (state is WhatsappImageStatusError) {
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
                          BlocProvider.of<WhatsappImageStatusBloc>(context)
                              .add(WhatsappImageStatusGet());
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
        } else {
          return Center(
            child: Text(
              localText.unknownerror,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );
        }
      },
    );
  }
}
