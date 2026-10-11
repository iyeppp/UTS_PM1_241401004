import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

/// Tombol lebar penuh. Set [isOutlined] untuk varian sekunder.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isOutlined = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final style = ButtonStyle(
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: r.lg, vertical: r.md),
      ),
      textStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: r.subtitleSize, fontWeight: FontWeight.w600),
      ),
    );

    final text = Text(label);
    final iconWidget = icon == null ? null : Icon(icon, size: r.iconSize);

    final Widget button = isOutlined
        ? (iconWidget == null
              ? OutlinedButton(onPressed: onPressed, style: style, child: text)
              : OutlinedButton.icon(
                  onPressed: onPressed,
                  style: style,
                  icon: iconWidget,
                  label: text,
                ))
        : (iconWidget == null
              ? ElevatedButton(onPressed: onPressed, style: style, child: text)
              : ElevatedButton.icon(
                  onPressed: onPressed,
                  style: style,
                  icon: iconWidget,
                  label: text,
                ));

    return SizedBox(width: double.infinity, child: button);
  }
}
