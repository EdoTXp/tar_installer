import 'package:flutter/material.dart';

import 'package:tar_installer/src/widgets/icon_chooser_widget.dart';
import 'package:tar_installer/src/widgets/text_field_with_label.dart';

class DesktopEntryPage extends StatefulWidget {
  final String selectedTARFilePath;
  final String installTARLocation;

  static const routeName = '/desktop_entry';

  const DesktopEntryPage({
    super.key,
    required this.selectedTARFilePath,
    required this.installTARLocation,
  });

  @override
  State<DesktopEntryPage> createState() => _DesktopEntryPageState();
}

class _DesktopEntryPageState extends State<DesktopEntryPage> {
  late String splittedAppName;

  @override
  void initState() {
    super.initState();
    splittedAppName = widget.selectedTARFilePath
        .split('/')
        .last
        .split('.tar')
        .first;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 8,
          children: [
            Center(
              child: Text(
                '[Desktop Entry]',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 32,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: IconChooserWidget(
                    onIconSelected: (iconPath) {},
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: 5,
                    children: [
                      TextFieldWithLabel(
                        label: 'Type:',
                        onChanged: (type) {},
                        initialValue: 'Application',
                        isRequired: true,
                      ),
                      TextFieldWithLabel(
                        label: 'Version:',
                        onChanged: (name) {},
                        initialValue: '1.0',
                      ),
                      TextFieldWithLabel(
                        label: 'Name:',
                        onChanged: (name) {},
                        initialValue: splittedAppName,
                        isRequired: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            TextFieldWithLabel.blocField(
              label: 'Comment:',
              onChanged: (comment) {},
              initialValue: 'A TAR file installer',
            ),
            TextFieldWithLabel(
              label: 'Path:',
              onChanged: (path) {},
              initialValue: widget.installTARLocation,
              isRequired: true,
            ),
            TextFieldWithLabel(
              label: 'Exec:',
              onChanged: (name) {},
              initialValue: '$splittedAppName.bin',
            ),
            TextFieldWithLabel(
              label: 'Categories:',
              onChanged: (categories) {},
              initialValue: 'Utility;Installer;',
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: Text('Back'),
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 5.0),
                ElevatedButton.icon(
                  label: Text('Install'),
                  icon: const Icon(Icons.install_desktop),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
