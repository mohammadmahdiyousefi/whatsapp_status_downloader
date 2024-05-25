import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> openFileInExternalApp(String path) async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  if (androidInfo.version.sdkInt >= 33) {
    try {
      final List<PermissionStatus> status = [
        await Permission.videos.status,
        await Permission.audio.status,
        await Permission.photos.status,
      ];
      if (status[0].isGranted && status[1].isGranted && status[2].isGranted) {
        if (await File(path).exists()) {
          await OpenFile.open(path);
        } else {
          throw 'File does not exist';
        }
      } else {
        await [Permission.videos, Permission.photos, Permission.audio]
            .request()
            .then((value) async {
          if (value.values.toList()[0].isGranted &&
              value.values.toList()[1].isGranted &&
              value.values.toList()[2].isGranted) {
            await openFileInExternalApp(path);
          } else {
            throw 'Permission not granted';
          }
        });
      }
    } catch (e) {
      throw e.toString();
    }
  } else {
    try {
      final PermissionStatus status = await Permission.storage.status;
      if (status.isGranted) {
        if (await File(path).exists()) {
          await OpenFile.open(path);
        } else {
          throw 'File does not exist';
        }
      } else {
        await Permission.storage.request().then((value) async {
          if (value.isGranted) {
            await openFileInExternalApp(path);
          } else {
            throw 'Permission not granted';
          }
        });
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
