import 'package:flutter/material.dart';

import '../core/constants/app_strings.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

/// Ringkasan hasil: skor besar + jumlah benar dan salah.
class ResultSummaryCard extends StatelessWidget {
  const ResultSummaryCard({
    super.key,
    required this.score,
    required this.correct,
    required this.wrong,
  });

  final int score;
  final int correct;
  final int wrong;

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(r.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.scoreLabel,
              style: TextStyle(
                fontSize: r.subtitleSize,
                color: scheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            Text(
              '$score',
              style: TextStyle(
                fontSize: r.displaySize,
                fontWeight: FontWeight.w700,
                color: scheme.primary,
              ),
            ),
            SizedBox(height: r.md),
            Row(
              children: [
                Expanded(
                  child: _Stat(
                    label: AppStrings.correctLabel,
                    value: correct,
                    color: AppColors.correct,
                  ),
                ),
                Expanded(
                  child: _Stat(
                    label: AppStrings.wrongLabel,
                    value: wrong,
                    color: AppColors.wrong,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value, required this.color});

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    return Column(
      children: [
        Text(
          '$value',
          style: TextStyle(
            fontSize: r.headlineSize,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: r.bodySize,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
