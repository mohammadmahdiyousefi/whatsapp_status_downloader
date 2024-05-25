import 'package:permission_handler/permission_handler.dart';

class AppPremission {
  static Future<bool> storage() async {
    var status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> storageStatus() async {
    var status = await Permission.manageExternalStorage.status;
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}
