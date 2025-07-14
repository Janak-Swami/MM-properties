import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utility/common/app_colors.dart';

class OnboardingPageContent extends StatelessWidget {
  final String imagePath;
  final String title;
  final String boldWord;
  final String description;
  final bool isFirstPage;
  final bool isLastPage;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final VoidCallback onPrevious;
  final int currentPageIndex;
  final int totalPages;

  const OnboardingPageContent({
    super.key,
    required this.imagePath,
    required this.title,
    required this.boldWord,
    required this.description,
    required this.isFirstPage,
    required this.isLastPage,
    required this.onNext,
    required this.onSkip,
    required this.onPrevious,
    required this.currentPageIndex,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> titleSpans = [];
    final effectiveTitle = title;
    final effectiveBoldWord = boldWord;

    if (effectiveBoldWord.isNotEmpty &&
        effectiveTitle.contains(effectiveBoldWord)) {
      final parts = effectiveTitle.split(effectiveBoldWord);
      titleSpans.add(TextSpan(text: parts[0]));
      if (parts.length > 1) {
        titleSpans.add(
          TextSpan(
            text: effectiveBoldWord,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w900,
              color: AppColors.munsell,
              fontSize: 30,
            ),
          ),
        );
        for (int i = 1; i < parts.length; i++) {
          titleSpans.add(TextSpan(text: parts[i]));
        }
      }
    } else {
      titleSpans.add(TextSpan(text: effectiveTitle));
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.lato(
                      color: AppColors.darkGrey,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                    children: titleSpans,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: GoogleFonts.lato(
                    color: AppColors.darkGrey.withValues(alpha: 0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 15,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 10.0,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.chineseWhite,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.image_not_supported,
                              color: AppColors.darkGrey,
                              size: 40,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
