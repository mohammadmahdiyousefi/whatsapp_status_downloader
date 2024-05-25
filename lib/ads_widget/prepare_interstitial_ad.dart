import 'package:adivery/adivery.dart';

void showInterstitial() {
  AdiveryPlugin.isLoaded('0443d026-503a-4165-b951-20026be36cab')
      .then((isLoaded) async {
    if (isLoaded == true && isLoaded != null) {
      showPlacement(isLoaded, '0443d026-503a-4165-b951-20026be36cab');
    }
  });
}

void showPlacement(bool isLoaded, String placementId) {
  if (isLoaded) {
    AdiveryPlugin.show(placementId);
  }
}
