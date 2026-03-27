import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis/components/themes/app_theme.dart';

class PaginationFooter extends StatelessWidget {

  const PaginationFooter({
    super.key,
    required this.shownCount,
    required this.totalCount,
    required this.onShowMore,
    required this.onCollapse,
    this.isLoading = false,
  });
  final int shownCount;
  final int totalCount;
  final VoidCallback onShowMore;
  final bool isLoading;
  final VoidCallback onCollapse;

  @override
  Widget build(BuildContext context) {
    final progress = totalCount == 0 ? 0.0 : shownCount / totalCount;
    final hasMore = shownCount < totalCount;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        children: [
          Text(
            'Showing $shownCount of $totalCount results',
            style: GoogleFonts.inter(
                fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 12),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 2,
              backgroundColor: AppColors.inputBorder,
              valueColor: const AlwaysStoppedAnimation(AppColors.textPrimary),
            ),
          ),
          if (totalCount > 0) ...[
            const SizedBox(height: 24),
            InkWell(
              onTap: isLoading
                  ? null
                  : hasMore
                  ? onShowMore
                  : onCollapse,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.inputBorder),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: isLoading
                      ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : Text(
                    hasMore ? 'Show More' : 'Show Less',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}