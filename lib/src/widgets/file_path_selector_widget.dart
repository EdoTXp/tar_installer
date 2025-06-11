import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePathSelectorWidget extends StatefulWidget {
  final String? initialFilePath;
  final void Function(String selectedPath) onFilePathSelected;
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
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialFilePath,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _chooseDirectory() async {
    String? directoryPath = await FilePicker.platform.getDirectoryPath(
      initialDirectory: widget.initialFilePath ?? '/home',
    );
    if (directoryPath != null) {
      _controller.text = directoryPath;
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
      _controller.text = result.files.first.path ?? '';
      widget.onFilePathSelected(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Expanded(
          child: TextField(
            readOnly: true,
            controller: _controller,
            decoration: InputDecoration(
              labelText: widget.isDirectory ? 'Directory Path' : 'File Path',
              border: const OutlineInputBorder(),
              hintText: widget.isDirectory
                  ? 'Select a directory'
                  : 'Select a TAR file',
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
