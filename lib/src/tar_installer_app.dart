import 'package:flutter/material.dart';
import 'package:tar_installer/src/views/tar_selection_page.dart';

class TarInstallerApp extends StatelessWidget {
  const TarInstallerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: TarSelectionPage(),
    );
  }
}
