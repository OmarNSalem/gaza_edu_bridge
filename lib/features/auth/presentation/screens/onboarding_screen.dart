import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_border_radius.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';

// ─── بيانات شريحة الـ Onboarding ────────────────────────────
class _OnboardingSlide {
  const _OnboardingSlide({
    required this.icon,
    required this.title,
    required this.titleEn,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String titleEn;
  final String body;
}

const List<_OnboardingSlide> _slides = [
  _OnboardingSlide(
    icon: Icons.wifi_off_rounded,
    title: 'تعلّم بدون إنترنت',
    titleEn: 'Learn Offline',
    body: 'نزّل المواد مرة واحدة واستمر في التعلم حتى بدون اتصال بالإنترنت.',
  ),
  _OnboardingSlide(
    icon: Icons.download_rounded,
    title: 'حمّل ملفاتك بسهولة',
    titleEn: 'Easy Downloads',
    body: 'ملفات PDF منظمة حسب المرحلة والصف، بأحجام صغيرة وجاهزة للقراءة في أي وقت.',
  ),
];

// ─── الشاشة الرئيسية ─────────────────────────────────────────
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// حفظ حالة الـ Onboarding والانتقال لشاشة Auth
  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    if (!mounted) return;
    context.go(RouteNames.auth);
  }

  /// الانتقال للشريحة التالية أو إنهاء الـ Onboarding
  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              // ─── Header: زر تخطي + Progress dots ───────────
              _OnboardingHeader(
                currentPage: _currentPage,
                totalPages: _slides.length,
                onSkip: _finish,
              ),

              // ─── محتوى الشرائح (PageView) ────────────────
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _slides.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    return _SlideContent(
                      slide: _slides[index],
                      key: ValueKey(index),
                    );
                  },
                ),
              ),

              // ─── Footer: زر التالي / ابدأ الآن ──────────
              _OnboardingFooter(
                isLastPage: _currentPage == _slides.length - 1,
                onNext: _nextPage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Header: زر تخطي + Progress dots ─────────────────────────
class _OnboardingHeader extends StatelessWidget {
  const _OnboardingHeader({
    required this.currentPage,
    required this.totalPages,
    required this.onSkip,
  });

  final int currentPage;
  final int totalPages;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // زر تخطي (يسار في RTL)
          TextButton(
            onPressed: onSkip,
            child: Text(
              'تخطي',
              style: AppTextStyles.body.copyWith(
                color: AppColors.mutedForeground,
              ),
            ),
          ),

          // Progress dots (يمين في RTL)
          Row(
            children: List.generate(
              totalPages,
              (i) => _ProgressDot(isActive: i == currentPage),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Progress Dot متحركة ─────────────────────────────────────
class _ProgressDot extends StatelessWidget {
  const _ProgressDot({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 24 : 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.primaryLight,
        borderRadius: AppBorderRadius.smallRadius,
      ),
    );
  }
}

// ─── Footer: زر التالي / ابدأ الآن ───────────────────────────
class _OnboardingFooter extends StatelessWidget {
  const _OnboardingFooter({
    required this.isLastPage,
    required this.onNext,
  });

  final bool isLastPage;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.xl2,
      ),
      child: AppButton(
        label: isLastPage ? 'ابدأ الآن' : 'التالي',
        onPressed: onNext,
      ),
    );
  }
}

// ─── محتوى شريحة واحدة ───────────────────────────────────────
class _SlideContent extends StatelessWidget {
  const _SlideContent({required this.slide, super.key});

  final _OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ─── أيقونة الشريحة مع animation ────────────────
          Container(
            width: 128,
            height: 128,
            decoration: const BoxDecoration(
              color: AppColors.surfaceAccent,
              borderRadius: AppBorderRadius.extraLargeRadius,
            ),
            child: Icon(slide.icon, size: 56, color: AppColors.primary),
          )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 400))
              .scale(
                begin: const Offset(0.85, 0.85),
                end: const Offset(1.0, 1.0),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
              ),

          const SizedBox(height: AppSpacing.xl),

          // ─── النصوص مع animation ─────────────────────────
          Column(
            children: [
              // العنوان العربي
              Text(
                slide.title,
                style: AppTextStyles.title.copyWith(
                  color: AppColors.foreground,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.xs),

              // العنوان الإنجليزي uppercase
              Text(
                slide.titleEn.toUpperCase(),
                style: AppTextStyles.captionMedium.copyWith(
                  color: AppColors.mutedForeground,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.lg),

              // نص الوصف مع maxWidth 300
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300),
                child: Text(
                  slide.body,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.mutedForeground,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
              .animate()
              .fadeIn(
                delay: const Duration(milliseconds: 150),
                duration: const Duration(milliseconds: 400),
              )
              .slideY(
                begin: 0.15,
                end: 0,
                delay: const Duration(milliseconds: 150),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
              ),
        ],
      ),
    );
  }
}
