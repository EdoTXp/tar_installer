import 'package:flutter/material.dart';
import 'package:tar_installer/src/views/desktop_entry_page.dart';
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
      routes: {
        TarSelectionPage.routeName: (context) => TarSelectionPage(),
        DesktopEntryPage.routeName: (context) {
          final arguments =
              ModalRoute.of(context)!.settings.arguments as Map<String, String>;

          return DesktopEntryPage(
            selectedTARFilePath: arguments.values.first,
            installTARLocation: arguments.values.last,
          );
        },
      },
      initialRoute: TarSelectionPage.routeName,
    );
  }
}
