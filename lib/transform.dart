import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'native_view.dart';

class TransformWidget extends StatefulWidget {
  const TransformWidget(
      {Key? key,
      required this.usingAndroidViewSurface,
      required this.usingHybridComposition})
      : super(key: key);
  final bool usingAndroidViewSurface;
  final bool usingHybridComposition;

  @override
  State<StatefulWidget> createState() => _TransformWidgetState();
}

class _TransformWidgetState extends State<TransformWidget> {
  double opacity = 1.0;
  double radius = 30;
  double scale = 0.75;
  double angle = 45; // This will rotate widget in 45 degrees.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transform(rotation, clip)"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                MutatorNativeView(
                  usingAndroidViewSurface: widget.usingAndroidViewSurface,
                  usingHybridComposition: widget.usingHybridComposition,
                  angle: -math.pi / 180 * angle,
                  opacity: opacity,
                  radius: radius,
                  scale: scale,
                ),
                Opacity(
                  opacity: 0.5,
                  child: Container(
                    constraints: BoxConstraints.expand(
                      height: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .fontSize! *
                              1.1 +
                          50.0,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.blue[600],
                    alignment: Alignment.center,
                    transform: Matrix4.rotationZ(0.2),
                    child: Text('Flutter UI',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.white)),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('Opacity'),
                Slider(
                  value: opacity,
                  min: 0.0,
                  max: 1.0,
                  divisions: 20,
                  activeColor: Colors.greenAccent,
                  label: opacity.toString(),
                  onChanged: (double value) {
                    setState(() {
                      opacity = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('Rotate'),
                Slider(
                  value: angle,
                  min: 0.0,
                  max: 360.0,
                  divisions: 72,
                  activeColor: Colors.greenAccent,
                  label: angle.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      angle = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('Radius'),
                Slider(
                  value: radius,
                  min: 0.0,
                  max: 100.0,
                  divisions: 10,
                  activeColor: Colors.greenAccent,
                  label: radius.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      radius = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('Scale'),
                Slider(
                  value: scale,
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
                  activeColor: Colors.greenAccent,
                  label: scale.toString(),
                  onChanged: (double value) {
                    setState(() {
                      scale = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MutatorNativeView extends StatelessWidget {
  const MutatorNativeView(
      {required this.angle,
      required this.opacity,
      required this.radius,
      required this.scale,
      required this.usingAndroidViewSurface,
      required this.usingHybridComposition,
      Key? key})
      : super(key: key);
  final double opacity;
  final double radius;
  final double angle;
  final double scale;
  final bool usingAndroidViewSurface;
  final bool usingHybridComposition;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Transform.scale(
        scale: scale,
        child: Opacity(
          opacity: opacity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: SizedBox(
              height: 300,
              width: 300,
              child: NativeView(
                  usingAndroidViewSurface: usingAndroidViewSurface,
                  usingHybridComposition: usingHybridComposition),
            ),
          ),
        ),
      ),
    );
  }
}
