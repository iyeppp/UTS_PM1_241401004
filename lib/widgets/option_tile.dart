import 'package:flutter/material.dart';

import '../core/constants/app_assets.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

/// Status tampilan sebuah opsi jawaban.
enum OptionState { idle, selected, correct, wrong }

/// Satu opsi jawaban. StatefulWidget karena menyimpan status hover (web/desktop).
class OptionTile extends StatefulWidget {
  const OptionTile({
    super.key,
    required this.label,
    required this.letter,
    required this.onTap,
    this.state = OptionState.idle,
  });

  final String label;
  final String letter;
  final VoidCallback? onTap;
  final OptionState state;

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final scheme = Theme.of(context).colorScheme;

    final Color accent = switch (widget.state) {
      OptionState.idle => scheme.onSurface.withValues(alpha: 0.2),
      OptionState.selected => scheme.primary,
      OptionState.correct => AppColors.correct,
      OptionState.wrong => AppColors.wrong,
    };
    final bool highlighted = widget.state != OptionState.idle;
    final Color background = highlighted
        ? accent.withValues(alpha: 0.12)
        : (_hovered && widget.onTap != null
              ? scheme.onSurface.withValues(alpha: 0.05)
              : scheme.surface);

    final String? statusIcon = switch (widget.state) {
      OptionState.correct => AppAssets.iconCorrect,
      OptionState.wrong => AppAssets.iconWrong,
      _ => null,
    };

    return MouseRegion(
      cursor: widget.onTap == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(r.radius),
          border: Border.all(color: accent, width: highlighted ? 2 : 1),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(r.radius),
            onTap: widget.onTap,
            child: Padding(
              padding: EdgeInsets.all(r.md),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: r.iconSize * 0.7,
                    backgroundColor: highlighted
                        ? accent
                        : scheme.onSurface.withValues(alpha: 0.1),
                    child: Text(
                      widget.letter,
                      style: TextStyle(
                        fontSize: r.bodySize,
                        fontWeight: FontWeight.w600,
                        color: highlighted ? Colors.white : scheme.onSurface,
                      ),
                    ),
                  ),
                  SizedBox(width: r.md),
                  Expanded(
                    child: Text(
                      widget.label,
                      style: TextStyle(
                        fontSize: r.subtitleSize,
                        color: scheme.onSurface,
                      ),
                    ),
                  ),
                  if (statusIcon != null) ...[
                    SizedBox(width: r.sm),
                    Image.asset(
                      statusIcon,
                      width: r.iconSize,
                      height: r.iconSize,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
