import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tar_installer/src/constants/app_images.dart';

class IconChooserWidget extends StatefulWidget {
  final String? initialIconPath;
  final void Function(String iconPath)? onIconSelected;

  const IconChooserWidget({
    super.key,
    this.initialIconPath,
    this.onIconSelected,
  });

  @override
  State<IconChooserWidget> createState() => _IconChooserWidgetState();
}

class _IconChooserWidgetState extends State<IconChooserWidget> {
  late String _selectedIconPath;

  @override
  void initState() {
    super.initState();
    _selectedIconPath = AppImages.logo;
  }

  Future<void> _chooseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'svg'],
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedIconPath = result.files.single.path ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 5,
        children: [
          Image.file(
            File(_selectedIconPath),
            width: 80,
            height: 80,
            fit: BoxFit.fill,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
                wasSynchronouslyLoaded
                ? child
                : AnimatedOpacity(
                    opacity: frame != null ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: child,
                  ),
            errorBuilder: (_, _, _) {
              return const Icon(
                Icons.error,
                color: Colors.red,
              );
            },
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _chooseFile,
              child: const Text('Choose Icon'),
            ),
          ),
        ],
      ),
    );
  }
}
