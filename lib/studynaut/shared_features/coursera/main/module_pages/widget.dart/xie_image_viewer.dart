import 'dart:io';

import 'package:flutter/material.dart';

class XieImageViewer extends StatelessWidget {
  final String imageFilePath;

  const XieImageViewer({required this.imageFilePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Image.file(File(imageFilePath)),
    ));
  }
}
