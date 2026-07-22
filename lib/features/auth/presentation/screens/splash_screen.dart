import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(milliseconds: 2600));
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final onboardingDone = prefs.getBool('onboarding_done') ?? false;

    if (!mounted) return;
    context.go(onboardingDone ? RouteNames.auth : RouteNames.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ─── Radial Glow خلفي أخضر ───────────────────────────
          Positioned.fill(
            child: _CenteredGlow(),
          ),

          // ─── المحتوى الرئيسي: شعار + نصوص ───────────────────
          Center(
            child: _MainContent(),
          ),

          // ─── النقاط ونص الجامعة في الأسفل ────────────────────
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: _BottomSection(),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// غلاف مركزي للـ Glow
// ─────────────────────────────────────────────────────────────
class _CenteredGlow extends StatelessWidget {
  const _CenteredGlow();

  @override
  Widget build(BuildContext context) {
    return const Center(child: _RadialGlowWidget());
  }
}

// ─────────────────────────────────────────────────────────────
// Radial Glow
// ─────────────────────────────────────────────────────────────
class _RadialGlowWidget extends StatelessWidget {
  const _RadialGlowWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288,
      height: 288,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            // opacity 0.2 للـ glow الأخضر
            AppColors.primary.withValues(alpha: 0.2),
            Colors.transparent,
          ],
          stops: const [0.0, 0.7],
        ),
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          duration: const Duration(seconds: 3),
          // لون shimmer بشفافية أخف
          color: AppColors.primary.withValues(alpha: 0.1),
        );
  }
}

// ─────────────────────────────────────────────────────────────
// المحتوى الرئيسي: شعار + نصوص
// ─────────────────────────────────────────────────────────────
class _MainContent extends StatelessWidget {
  const _MainContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ─── الشعار مع animation scale + fade ───────────────
        Container(
          width: 96,
          height: 96,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            gradient: AppColors.primaryGradient,
            boxShadow: AppShadows.primaryGlow,
          ),
          child: const Icon(Icons.school, color: Colors.white, size: 44),
        )
            .animate()
            .scale(
              begin: const Offset(0.6, 0.6),
              end: const Offset(1.0, 1.0),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
            )
            .fadeIn(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOut,
            ),

        const SizedBox(height: 16),

        // ─── النصوص: الاسم + التاغلاين مع animation ─────────
        const _LogoTexts(),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// نصوص الشعار
// ─────────────────────────────────────────────────────────────
class _LogoTexts extends StatelessWidget {
  const _LogoTexts();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'GazaEdu Bridge',
          style: AppTextStyles.display.copyWith(color: AppColors.foreground),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          'منصة غزة للتعلم الذاتي',
          style: AppTextStyles.body.copyWith(color: AppColors.mutedForeground),
          textAlign: TextAlign.center,
        ),
      ],
    )
        .animate()
        .fadeIn(
          delay: const Duration(milliseconds: 400),
          duration: const Duration(milliseconds: 500),
        )
        .slideY(
          begin: 0.2,
          end: 0,
          delay: const Duration(milliseconds: 400),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
  }
}

// ─────────────────────────────────────────────────────────────
// القسم السفلي: نقاط التحميل + نص الجامعة
// ─────────────────────────────────────────────────────────────
class _BottomSection extends StatelessWidget {
  const _BottomSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ─── 3 نقاط وميض staggered ───────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) => _LoadingDot(index: index)),
        ),

        const SizedBox(height: 8),

        // ─── نص الجامعة ───────────────────────────────────────
        Text(
          'جامعة فلسطين — 2025/2026',
          style: AppTextStyles.mini.copyWith(color: AppColors.mutedForeground),
          textAlign: TextAlign.center,
        )
            .animate()
            .fadeIn(
              delay: const Duration(milliseconds: 1200),
              duration: const Duration(milliseconds: 500),
            ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// نقطة تحميل واحدة (staggered)
// ─────────────────────────────────────────────────────────────
class _LoadingDot extends StatelessWidget {
  const _LoadingDot({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .fadeIn(
          delay: Duration(milliseconds: index * 200),
          duration: const Duration(milliseconds: 1200),
        )
        .then()
        .fadeOut(
          duration: const Duration(milliseconds: 1200),
        );
  }
}
