import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_assets.dart';
import '../core/constants/app_strings.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/primary_button.dart';
import '../widgets/responsive_center.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman awal: ilustrasi, judul, deskripsi, dan tombol mulai/lanjut kuis.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onStart});

  /// Dipanggil untuk menuju halaman kuis (navigasi diatur di Tahap 10).
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppAssets.logo, height: r.iconSize * 1.2),
            SizedBox(width: r.sm),
            const Flexible(
              child: Text(AppStrings.appTitle, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        actions: const [ThemeToggleButton()],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: r.md),
            child: ResponsiveCenter(
              child: r.useTwoColumns
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: _Hero(maxHeight: r.heightFraction(0.6)),
                        ),
                        SizedBox(width: r.xl),
                        Expanded(child: _HomeContent(onStart: onStart)),
                      ],
                    )
                  : Column(
                      children: [
                        _Hero(maxHeight: r.heightFraction(0.32)),
                        SizedBox(height: r.lg),
                        _HomeContent(onStart: onStart),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.maxHeight});

  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Image.asset(AppAssets.heroQuiz, fit: BoxFit.contain),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final scheme = Theme.of(context).colorScheme;
    final quiz = context.watch<QuizProvider>();
    final hasProgress = quiz.answeredCount > 0 && !quiz.isFinished;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: r.useTwoColumns
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Text(
          AppStrings.homeHeadline,
          textAlign: r.useTwoColumns ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            fontSize: r.headlineSize,
            fontWeight: FontWeight.w700,
            color: scheme.onSurface,
            height: 1.25,
          ),
        ),
        SizedBox(height: r.md),
        Text(
          AppStrings.homeDescription,
          textAlign: r.useTwoColumns ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            fontSize: r.subtitleSize,
            color: scheme.onSurface.withValues(alpha: 0.75),
            height: 1.5,
          ),
        ),
        SizedBox(height: r.md),
        Chip(
          avatar: Icon(Icons.quiz_outlined, size: r.iconSize * 0.8),
          label: Text(
            '${quiz.totalQuestions} ${AppStrings.questionsLabel}',
            style: TextStyle(fontSize: r.bodySize),
          ),
        ),
        SizedBox(height: r.lg),
        if (hasProgress) ...[
          PrimaryButton(
            label: AppStrings.resume,
            icon: Icons.play_arrow_rounded,
            onPressed: onStart,
          ),
          SizedBox(height: r.sm),
          PrimaryButton(
            label: AppStrings.restart,
            icon: Icons.restart_alt_rounded,
            isOutlined: true,
            onPressed: () {
              quiz.reset();
              onStart();
            },
          ),
        ] else
          PrimaryButton(
            label: AppStrings.start,
            icon: Icons.play_arrow_rounded,
            onPressed: () {
              quiz.reset();
              onStart();
            },
          ),
      ],
    );
  }
}
