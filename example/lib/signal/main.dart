import 'package:flutter/material.dart';
import 'package:pro_mana/Graffiti/Graffiti.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '绘图',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ImagePainterExample(),
    );
  }
}

class ImagePainterExample extends StatelessWidget {
  const ImagePainterExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Graffiti(config: GraffitiConfig(type: PaintingType.file),);
  }
}