import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobWidget extends StatefulWidget {
  final String adUnitId;

  AdMobWidget({required this.adUnitId});

  @override
  _AdMobWidgetState createState() => _AdMobWidgetState();
}

class _AdMobWidgetState extends State<AdMobWidget> {
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: widget.adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _bannerAd.size.width.toDouble(),
      height: _isAdLoaded ? _bannerAd.size.height.toDouble() : 0,
      alignment: Alignment.center,
      child: _isAdLoaded ? AdWidget(ad: _bannerAd) : SizedBox(),
    );
  }
}