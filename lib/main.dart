import 'dart:ui_web' as ui;
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:webapp/image_load_view.dart';

void main() {
  // Register the platform view for custom HTML <img> tag
  ui.PlatformViewRegistry().registerViewFactory(
    'image-container',
    (int viewId) => html.DivElement()..id = 'image-container',
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ImageLoadView(),
      theme: ThemeData(useMaterial3: true ,),
    );
  }
}
