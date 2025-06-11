import 'package:flutter/material.dart';

class TextFieldWithLabel extends StatelessWidget {
  final String label;
  final String? initialValue;
  final void Function(String) onChanged;
  final int maxLines;
  final double width;

  final bool isRequired;

  const TextFieldWithLabel({
    super.key,
    required this.label,
    this.initialValue,
    required this.onChanged,
    this.maxLines = 1,
    this.isRequired = false,
    this.width = double.infinity,
  });

  const TextFieldWithLabel.blocField({
    super.key,
    required this.label,
    this.initialValue,
    required this.onChanged,
    this.maxLines = 3,
    this.isRequired = false,
    this.width = double.infinity,
  }) : assert(maxLines > 0, 'maxLines must be greater than 0');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        spacing: 5,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Expanded(
            child: TextFormField(
              initialValue: initialValue,
              onChanged: onChanged,
              autovalidateMode: isRequired
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              maxLines: maxLines,
              validator: isRequired
                  ? (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required.';
                      }
                      return null;
                    }
                  : null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
