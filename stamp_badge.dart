import 'package:flutter/material.dart';
import '../../app/theme/app_theme.dart';

/// The recurring "ink stamp" motif — used for rank, percentile, premium
/// marker, and cutoff-cleared status. Slightly irregular edge via a custom
/// clipper keeps it from reading as a plain circle avatar.
class StampBadge extends StatelessWidget {
  final String value; // e.g. "#142" or "91.2%"
  final String label; // e.g. "RANK" or "PERCENTILE"
  final double size;

  const StampBadge({
    super.key,
    required this.value,
    required this.label,
    this.size = 96,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gold = isDark ? AppColors.stampGoldDark : AppColors.stampGold;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: gold, width: 2.5),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: AppTheme.dataStyle.copyWith(color: gold, fontSize: size * 0.22)),
          Text(
            label,
            style: TextStyle(fontSize: size * 0.09, color: gold, letterSpacing: 1.2),
          ),
        ],
      ),
    );
  }
}
