import 'package:flutter/material.dart';
import 'package:tar_installer/src/tar_installer_app.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  final WindowOptions windowOptions = WindowOptions(
    size: const Size(600, 250),
    backgroundColor: Colors.white,
    title: 'TAR Installer',
    skipTaskbar: false,
    minimumSize: const Size(600, 250),
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const TarInstallerApp());
}
