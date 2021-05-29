import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:test_ads/ad_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  runApp(Provider.value(
    value: adState,
    builder: (context, child) => MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //mulai dari sini iklannya
  BannerAd banner;

  @override
  void initState() {
    super.initState();
    banner = BannerAd(
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );
    banner.load();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Test Ad"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.yellowAccent,
              ),
              flex: 4,
            ),
            SizedBox(
              height: 50,
              //nanti containernya ganti iklan
              child: AdWidget(ad: banner),
            ),
            /*Expanded(
              child: Container(
                color: Colors.greenAccent,
              ),
              flex: 1,
            ) */
          ],
        ),
      ),
    );
  }
}
