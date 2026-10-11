import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

/// Kartu yang menampilkan nomor dan teks soal.
class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(r.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Soal $number',
              style: TextStyle(
                fontSize: r.bodySize,
                fontWeight: FontWeight.w600,
                color: scheme.primary,
              ),
            ),
            SizedBox(height: r.sm),
            Text(
              text,
              style: TextStyle(
                fontSize: r.titleSize,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
