import 'package:flutter/material.dart';
import 'native_view.dart';

class PlatformViewListDemo extends StatelessWidget {
  const PlatformViewListDemo(
      {Key? key,
      required this.usingAndroidViewSurface,
      required this.usingHybridComposition})
      : super(key: key);
  final bool usingAndroidViewSurface;
  final bool usingHybridComposition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlatformView List Demo'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            child: const Text('Open route'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondRoute()),
              );
            },
          ),
          Expanded(
              child: ListViewWidget(
                  usingAndroidViewSurface: usingAndroidViewSurface,
                  usingHybridComposition: usingHybridComposition)),
        ],
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

class ListViewWidget extends StatelessWidget {
  const ListViewWidget(
      {Key? key,
      required this.usingAndroidViewSurface,
      required this.usingHybridComposition})
      : super(key: key);
  final bool usingAndroidViewSurface;
  final bool usingHybridComposition;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1000,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 4.0, right: 10.0, bottom: 4.0),
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 2.0,
                    child: SizedBox(
                      height: 100,
                      child: ListTile(
                        tileColor: Colors.white,
                        title: Text('Flutter View: ${index + 1}'),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2.0,
                    child: SizedBox(
                      height: 100,
                      child: NativeView(
                          usingAndroidViewSurface: usingAndroidViewSurface,
                          usingHybridComposition: usingHybridComposition),
                    ),
                  ),
                ],
              ),
            ));
  }
}
