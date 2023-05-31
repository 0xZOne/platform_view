import 'package:flutter/material.dart';
import 'dart:async';

import 'texture_controller.dart';

class TextureWidget extends StatefulWidget {
  const TextureWidget({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  State<TextureWidget> createState() => _TextureWidgetState();
}

class _TextureWidgetState extends State<TextureWidget> {
  final _controller = TextureController();

  @override
  initState() {
    super.initState();
    initializeController();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Texture(textureId: _controller.textureId),
    );
  }

  Future<void> initializeController() async {
    await _controller.initialize(widget.width, widget.height);
    setState(() {});
  }
}
