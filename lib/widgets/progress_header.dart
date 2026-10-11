import 'package:flutter/material.dart';

import '../core/constants/app_strings.dart';
import '../core/utils/responsive.dart';

/// Indikator progres kuis: "Soal x dari y" + bar progres beranimasi.
class ProgressHeader extends StatelessWidget {
  const ProgressHeader({super.key, required this.current, required this.total});

  /// Nomor soal aktif (mulai dari 1).
  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final scheme = Theme.of(context).colorScheme;
    final value = total == 0 ? 0.0 : current / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.progressLabel,
              style: TextStyle(
                fontSize: r.bodySize,
                color: scheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            Text(
              '$current / $total',
              style: TextStyle(
                fontSize: r.bodySize,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
            ),
          ],
        ),
        SizedBox(height: r.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(r.radius),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: value),
            duration: const Duration(milliseconds: 300),
            builder: (context, animated, _) => LinearProgressIndicator(
              value: animated,
              minHeight: r.sm,
              backgroundColor: scheme.onSurface.withValues(alpha: 0.1),
            ),
          ),
        ),
      ],
    );
  }
}
