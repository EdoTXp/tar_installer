import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tar_installer/src/views/desktop_entry_page.dart';
import 'package:tar_installer/src/widgets/file_path_selector_widget.dart';

class TarSelectionPage extends StatelessWidget {

  static const routeName = '/';
  const TarSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedTARFilePath = '';
    String installTARLocation = '/opt';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.0,
          children: [
            Text('TAR Location'),
            FilePathSelectorWidget(
              onFilePathSelected: (filePath) => selectedTARFilePath = filePath,
            ),
            Text('TAR Install Location'),
            FilePathSelectorWidget(
              initialFilePath: installTARLocation,
              isDirectory: true,
              onFilePathSelected: (filePath) => installTARLocation = filePath,
            ),
            const Spacer(),
            Row(
              children: [
                OutlinedButton.icon(
                  label: Text('Settings'),
                  icon: const Icon(Icons.settings),
                  onPressed: () {},
                ),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: () => SystemChannels.platform.invokeMethod(
                    'SystemNavigator.pop',
                  ),
                  label: Text('Exit'),
                  icon: const Icon(Icons.close),
                ),
                const SizedBox(width: 5.0),
                ElevatedButton.icon(
                  label: Text('Next Page'),
                  icon: const Icon(Icons.navigate_next),
                  onPressed: () {
                    if (selectedTARFilePath.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select a TAR file.'),
                          backgroundColor: Colors.red,
                          showCloseIcon: true,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      return;
                    }

                    Navigator.pushNamed(
                      context,
                      DesktopEntryPage.routeName,
                      arguments: {
                        'selectedTARFilePath': selectedTARFilePath,
                        'installTARLocation': installTARLocation,
                      },
                    );
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
