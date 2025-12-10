import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gibas/core/utils/log.dart';

class AdsService {
  static BannerAd? _bannerAd;
  static InterstitialAd? _interstitialAd;
  static bool _isInterstitialReady = false;

  // 🔸 Ganti ke ID test dulu selama development
  static const String bannerTestId = 'ca-app-pub-3940256099942544/6300978111';
  static const String interstitialTestId = 'ca-app-pub-3940256099942544/1033173712';

  /// 🔹 Load Banner Ad
  static void loadBanner(VoidCallback onAdLoaded) {
    _bannerAd = BannerAd(
      adUnitId: bannerTestId, // Ganti ke ID aslimu pas rilis
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          Log.v('Banner loaded', tag: 'Ads');
          onAdLoaded();
        },
        onAdFailedToLoad: (ad, error) {
          Log.e('Banner failed to load: $error', tag: 'Ads');
          ad.dispose();
        },
      ),
    )..load();
  }

  /// 🔹 Widget Banner yang bisa langsung dipakai di UI
  static Widget bannerWidget() {
    if (_bannerAd == null) return const SizedBox.shrink();
    return Container(
      alignment: Alignment.center,
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }

  /// 🔹 Load Interstitial
  static void loadInterstitial() {
    InterstitialAd.load(
      adUnitId: interstitialTestId, // Ganti ke ID aslimu pas rilis
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialReady = true;
          Log.v('Interstitial loaded', tag: 'Ads');
        },
        onAdFailedToLoad: (error) {
          Log.e('Interstitial failed: $error', tag: 'Ads');
          _isInterstitialReady = false;
        },
      ),
    );
  }

  /// 🔹 Tampilkan Interstitial
  static void showInterstitial() {
    if (_isInterstitialReady && _interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          loadInterstitial(); // Auto reload setelah ditutup
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          Log.e('Interstitial failed to show: $error', tag: 'Ads');
          loadInterstitial();
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null;
      _isInterstitialReady = false;
    } else {
      Log.w('Interstitial not ready yet', tag: 'Ads');
      loadInterstitial();
    }
  }

  /// 🔹 Dispose semua ads
  static void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
  }
}
