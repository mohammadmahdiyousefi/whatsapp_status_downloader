import 'package:adivery/adivery_ads.dart';

BannerAd? creatabannerad(BannerAdSize bannerAdSize) {
  BannerAd? ads = BannerAd(
    '7d37042b-e5d5-4a0d-9775-c196a09b6c30',
    bannerAdSize,
    onAdLoaded: (ad) {
      ad.loadAd();
    },
    onAdClicked: (ad) {},
    onError: (ad, reason) {},
  );
  return ads;
}
