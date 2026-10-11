import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

/// Memusatkan konten dan membatasi lebar maksimumnya (tablet/web), plus
/// memberi padding horizontal yang mengikuti ukuran layar.
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: r.maxContentWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: r.md),
          child: child,
        ),
      ),
    );
  }
}
