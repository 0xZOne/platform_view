import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import 'list_view.dart';
import 'simple_webview.dart';
import 'transform.dart';

void main() {
  runApp(const MaterialApp(
    title: 'PlatformView Demo',
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool usingAndroidViewSurface = false;
  bool usingHybridComposition = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlatformView Demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Platform.isAndroid
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Text('UsingHybridComposition '),
                            Switch(
                              value: usingHybridComposition,
                              onChanged: (value) {
                                setState(() {
                                  usingHybridComposition = value;
                                  if (usingHybridComposition) {
                                    usingAndroidViewSurface = true;
                                  }
                                });
                              },
                              activeTrackColor: Colors.green,
                              activeColor: Colors.greenAccent,
                            ),
                          ],
                        )
                      : Container(),
                  Platform.isAndroid
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Text('UsingAndroidViewSurface '),
                            Switch(
                              value: usingAndroidViewSurface,
                              onChanged: (value) {
                                setState(() {
                                  usingAndroidViewSurface = value;
                                  if (!usingAndroidViewSurface) {
                                    usingHybridComposition = false;
                                  }
                                });
                              },
                              activeTrackColor: Colors.green,
                              activeColor: Colors.greenAccent,
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text('List View'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlatformViewListDemo(
                                usingHybridComposition: usingHybridComposition,
                                usingAndroidViewSurface:
                                    usingAndroidViewSurface)),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Matrix Transform'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransformWidget(
                                usingHybridComposition: usingHybridComposition,
                                usingAndroidViewSurface:
                                    usingAndroidViewSurface)),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: const Text('WebView'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SimpleWebView(url: 'https://www.uc.cn/'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
