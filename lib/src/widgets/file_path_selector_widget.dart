import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePathSelectorWidget extends StatefulWidget {
  final String? initialFilePath;
  final Function(String) onFilePathSelected;
  final bool isDirectory;

  const FilePathSelectorWidget({
    super.key,
    this.initialFilePath,
    this.isDirectory = false,
    required this.onFilePathSelected,
  });

  @override
  State<FilePathSelectorWidget> createState() => _FilePathSelectorWidgetState();
}

class _FilePathSelectorWidgetState extends State<FilePathSelectorWidget> {
  late String _filePath = widget.initialFilePath ?? 'TAR file path';

  Future<void> _chooseDirectory() async {
    String? directoryPath = await FilePicker.platform.getDirectoryPath(
      initialDirectory: widget.initialFilePath ?? '/home',
    );
    if (directoryPath != null) {
      setState(() {
        _filePath = directoryPath;
      });
      widget.onFilePathSelected(directoryPath);
    }
  }

  Future<void> _chooseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      initialDirectory: widget.initialFilePath ?? '/home',
      type: FileType.custom,
      allowedExtensions: ['tar.*'],
    );
    if (result != null && result.files.isNotEmpty) {
      String filePath = result.files.first.path ?? '';
      setState(() {
        _filePath = filePath;
      });
      widget.onFilePathSelected(filePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Expanded(
          child: TextField(
            enabled: false,
            decoration: InputDecoration(
              labelText: _filePath,
              labelStyle: const TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () async {
            if (widget.isDirectory) {
              await _chooseDirectory();
            } else {
              await _chooseFile();
            }
          },
          label: Text(
            widget.isDirectory ? 'Select Directory' : 'Select File',
          ),
          icon: const Icon(Icons.folder_open),
          style: ElevatedButton.styleFrom(minimumSize: const Size(100, 50)),
        ),
      ],
    );
  }
}
