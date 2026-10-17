import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_assets.dart';
import '../core/constants/app_strings.dart';
import '../core/router/app_router.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/primary_button.dart';
import '../widgets/responsive_center.dart';
import '../widgets/result_summary_card.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman hasil: skor, ringkasan benar/salah, dan pesan sesuai skor.
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  String _message(int score) {
    if (score >= 80) return AppStrings.resultHigh;
    if (score >= 50) return AppStrings.resultMid;
    return AppStrings.resultLow;
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final scheme = Theme.of(context).colorScheme;
    final quiz = context.watch<QuizProvider>();

    final summary = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _message(quiz.score),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: r.titleSize,
            fontWeight: FontWeight.w600,
            color: scheme.onSurface,
          ),
        ),
        SizedBox(height: r.md),
        ResultSummaryCard(
          score: quiz.score,
          correct: quiz.correctCount,
          wrong: quiz.wrongCount,
        ),
        SizedBox(height: r.lg),
        PrimaryButton(
          label: AppStrings.retry,
          icon: Icons.replay_rounded,
          onPressed: () {
            quiz.reset();
            Navigator.pushReplacementNamed(context, AppRoutes.quiz);
          },
        ),
        SizedBox(height: r.sm),
        PrimaryButton(
          label: AppStrings.backHome,
          icon: Icons.home_rounded,
          isOutlined: true,
          onPressed: () {
            quiz.reset();
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ],
    );

    final trophy = ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: r.heightFraction(r.useTwoColumns ? 0.5 : 0.25),
      ),
      child: Image.asset(AppAssets.trophy, fit: BoxFit.contain),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.resultTitle),
        automaticallyImplyLeading: false,
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
                        Expanded(child: trophy),
                        SizedBox(width: r.xl),
                        Expanded(child: summary),
                      ],
                    )
                  : Column(
                      children: [
                        trophy,
                        SizedBox(height: r.lg),
                        summary,
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
