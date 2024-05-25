import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_status_downloader/bloc/file_storage/file_srorage_bloc.dart';
import 'package:whatsapp_status_downloader/service/manage_file.dart';
import 'package:whatsapp_status_downloader/service/toast.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.file});
  final File file;

  @override
  Widget build(BuildContext context) {
    bool isSaved = false;
    return BlocBuilder<FileSrorageBloc, FileSrorageState>(
        builder: (context, state) {
      isSaved = _checkSave(state);
      return GestureDetector(
        onTap: () async {
          if (isSaved) {
            await ManageFile.deleteFile(file).then((value) {
              value.fold((error) {
                ToastMessage.showCustomToast(
                    context, "مشکلی در انجام عملیات پیش آمد", Colors.orange);
              }, (success) {
                ToastMessage.showCustomToast(
                    context, "فایل از حالت ذخیره خارج شد ", Colors.red);
                BlocProvider.of<FileSrorageBloc>(context)
                    .add(FileSrorageRefreshEvent());
              });
            });
          } else {
            await ManageFile.saveFile(file).then((value) {
              value.fold((error) {
                ToastMessage.showCustomToast(
                    context, "مشکلی در ذخیره فایل رخ داد ", Colors.orange);
              }, (success) {
                ToastMessage.showCustomToast(
                    context, "فایل با موفقیت ذخیره شد", Colors.green);
                BlocProvider.of<FileSrorageBloc>(context)
                    .add(FileSrorageRefreshEvent());
              });
            });
          }
        },
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: const Color.fromARGB(185, 217, 253, 211),
              borderRadius: BorderRadius.circular(8)),
          child: Center(
              child: Icon(
            isSaved ? Icons.bookmark_added : Icons.bookmark_add_outlined,
            size: 20,
            color: const Color(0xff15603e),
          )),
        ),
      );
    });
  }

  bool _checkSave(FileSrorageState state) {
    if (state is FileSrorageData) {
      return state.files.any((element) {
        return element.path.split("/").last.contains(file.path.split("/").last);
      });
    } else {
      return false;
    }
  }
}
