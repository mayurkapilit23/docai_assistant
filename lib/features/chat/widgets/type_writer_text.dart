import 'package:flutter/material.dart';

class TypeWriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final VoidCallback? onCompleted;

  const TypeWriterText({
    super.key,
    required this.text,
    required this.style,
    this.onCompleted,
  });

  @override
  State<TypeWriterText> createState() => _TypeWriterTextState();
}

class _TypeWriterTextState extends State<TypeWriterText> {
  String _displayed = '';
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() async {
    while (_index < widget.text.length) {
      await Future.delayed(const Duration(milliseconds: 25));

      if (!mounted) return;

      setState(() {
        _displayed += widget.text[_index];
        _index++;
      });
    }

    widget.onCompleted?.call(); // ✅ Notify
  }

  @override
  Widget build(BuildContext context) {
    return Text(_displayed, style: widget.style);
  }
}
