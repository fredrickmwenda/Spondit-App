import 'package:flutter/material.dart';

class DeviceTextField extends StatefulWidget {
  final int maxLines;
  final String text;
  final ValueChanged<String> onChanged;

  const DeviceTextField({
    Key? key,
    this.maxLines = 1,

    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<DeviceTextField> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //const SizedBox(height: 8),
          TextField(
            controller: controller,
            maxLines: widget.maxLines,
          ),
        ],
      );
}