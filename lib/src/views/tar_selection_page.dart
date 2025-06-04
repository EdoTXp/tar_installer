import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tar_installer/src/widgets/file_path_selector_widget.dart';

class TarSelectionPage extends StatefulWidget {
  const TarSelectionPage({super.key});

  @override
  State<TarSelectionPage> createState() => _TarSelectionPageState();
}

class _TarSelectionPageState extends State<TarSelectionPage> {
  String selectedFilePath = '';
  String installLocation = '/opt';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.0,
          children: [
            Text('TAR Location'),
            FilePathSelectorWidget(
              onFilePathSelected: (String filePath) {
                setState(() {
                  selectedFilePath = filePath;
                });
              },
            ),
            Text('TAR Install Location'),
            FilePathSelectorWidget(
              initialFilePath: installLocation,
              isDirectory: true,
              onFilePathSelected: (String filePath) {
                setState(() {
                  installLocation = filePath;
                });
              },
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
                  label: Text('Cancel'),
                  icon: const Icon(Icons.navigate_before),
                ),
                const SizedBox(width: 5.0),
                ElevatedButton.icon(
                  label: Text('Next Page'),
                  icon: const Icon(Icons.navigate_next),
                  onPressed: () {
                    // Handle installation logic here
                    debugPrint('Selected TAR file: $selectedFilePath');
                    debugPrint('Install location: $installLocation');
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
