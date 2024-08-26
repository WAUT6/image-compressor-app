import 'package:flutter/material.dart';
import 'package:image_compressor/themes/constants/theme_constants.dart';

import 'pages/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Compressor',
      debugShowCheckedModeBanner: false,
      theme: ThemeConstants.lightTheme,
      home: const HomePage(),
    );
  }
}
