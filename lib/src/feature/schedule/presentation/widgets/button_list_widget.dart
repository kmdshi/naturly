import 'package:flutter/material.dart';
import 'package:naturly/src/core/common/layout/layout.dart';

class ButtonListWidget extends StatefulWidget {
  final List<Widget> buttons;
  const ButtonListWidget({super.key, required this.buttons});

  @override
  State<ButtonListWidget> createState() => _ButtonListWidgetState();
}

class _ButtonListWidgetState extends State<ButtonListWidget> {
  @override
  Widget build(BuildContext context) {
    final isCompact =
        WindowSizeScope.of(context).isCompact ||
        WindowSizeScope.of(context).isMedium;

    return isCompact
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:
              widget.buttons
                  .map(
                    (b) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: b,
                    ),
                  )
                  .toList(),
        )
        : Wrap(spacing: 6, runSpacing: 6, children: widget.buttons);
  }
}
